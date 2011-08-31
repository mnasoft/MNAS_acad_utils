;;;The following procedure creates an ActiveX application that works with Microsoft Word 97 and an AutoCAD drawing that contains mtext.
;;;
;;;To copy mtext from an AutoCAD drawing into an Microsoft Word document

;;;1	Issue the following command to ensure that AutoLISP ActiveX support is loaded:

;(vl-load-com) 

;;;2	Obtain the AutoCAD application and current ModelSpace objects and save their pointers:

(setq *AcadApp* (vlax-get-acad-object))    ; Get AutoCAD application
(setq *ModelSpace* (vla-get-ModelSpace 
  (vla-get-ActiveDocument *AcadApp*)))     ; Get model space

;;;3	Import the Microsoft Word type library. Change the :tlb-filename argument in the following code to point to the msword8.olb file on your system, then run the code:

(if (equal nil mswc-wd100Words) ; check for a Word constant
  (vlax-import-type-library
    :tlb-filename "c:/Program Files/Microsoft Office/Office/msword8.olb"
    :methods-prefix "mswm-"
    :properties-prefix "mswp-"
    :constants-prefix "mswc-"
  ) 

) 

;;;This code first checks to see if a known Microsoft Word constant is defined with a value. If the constant has a value, it is assumed that the Word type library has already been imported and no further action is necessary. If the constant is nil, vlax-import-type-library is invoked.
;;;
;;;4	Establish a connection to a Microsoft Word application by running the following code:

 (setq msw (vlax-get-object "Word.Application.8"))
  (if (equal nil msw)
    (progn
      ; Word is not running. Start it.
      (setq msw (vlax-create-object "Word.Application.8"))
      (vla-put-visible msw :vlax-true)
    )

  )

;;;The code issues vlax-get-object to establish a connection to a running Microsoft Word application. (In this example, version 8—Word 97—is specified; if the 8 were omitted, any instance of Word would be accepted.) If there is no running instance of Word, vlax-create-object is issued to start one.
;;;
;;;5	The remaining code follows. Comments in the code explain the processing.

(if (/= nil msw)
  (progn
    ;; Get the document collection object.
    (setq docs (vla-get-documents msw))
    ;; Add a new document
    (setq doc (mswm-add docs))
    ;; Get the paragraphs of the document (to do some formatting)
    (setq paragraphs (mswp-get-paragraphs doc))
    ;; Now iterate through the model space and export any mtext
    ;; every Mtext entity to Word.
    (vlax-for ent *ModelSpace*
      (if (equal (vla-get-ObjectName ent) "AcDbMText")

	(progn
	  ;; Get the following information from the Mtext entity:
	  ;;     o the text string
	  ;;     o the location of a corner of the text boundary

	  (setq	text	     (vla-get-TextString ent)
		textpos	     (vla-get-InsertionPoint ent)
		arrayTextpos (vlax-variant-value textpos)
		textinfo
			     (strcat
			       (rtos (vlax-safearray-get-element arrayTextpos 0) 2 2)

			       ", "
			       (rtos (vlax-safearray-get-element arrayTextpos 1) 2 2)
			       ", "
			       (rtos (vlax-safearray-get-element arrayTextpos 2) 2 2)
			     )
	  ) ;_ end of setq
					; Print some info (with formatting)
					;  Get the last paragraph in the document
	  (setq pg (mswp-get-last paragraphs))
					;  Obtain the range of the paragraph
	  (setq range (mswp-get-range pg))
					;  Do some formatting

	  (mswp-put-bold range 1)	;bold
	  (mswp-put-underline range mswc-wdUnderlineSingle) ;underline
					; 4) Insert info about the text at the end of the paragraph
	  (mswm-InsertAfter
	    range
	    (strcat "AcDbMText at position " textinfo "\n")
	  )
					; Now show the text string (from the ACAD text entity)
	  (setq pg (mswp-get-last paragraphs))
	  (setq range (mswp-get-range pg))
	  (mswp-put-bold range 0)

	  (mswp-put-underline range mswc-wdUnderlineNone)
	  (mswm-InsertAfter range (strcat text "\n\n"))
	) ;_ end of progn  
      ) ;_ end of if AcDbMText
    ) ;_ end of vlax-for
  ) ;_ end of progn
  (princ "\nNo Microsoft Word application found.\n")

)
