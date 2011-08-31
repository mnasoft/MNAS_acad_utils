;;;	AcadAppDocSpace() ������� vla-�������:
;;;	1. ���������� Acad - acadApp;
;;;	2. ��������� ��������� - acadDoc;
;;;	3. �������� ������������ (������ ��� �����) - acadSpace.
(defun AcadAppDocSpace_1()
  (setq
    acadApp   (vlax-get-acad-object)
    acadDoc   (vla-get-ActiveDocument acadApp)
    acadSpace
	      (cond
		((= 1 (caar (VPORTS))) (vla-get-PaperSpace acadDoc))
		(t (vla-get-ModelSpace acadDoc))
	      )
  )
  t
)
;;;Space ���������� ����� ������������ (������ ��� �����) �������� �������.
;;;����������:
;;;1. "PaperSpace" ���� ������� �������� ������������ �����;
;;;2. "ModelSpace" ���� ������� �������� ������������ ������;
(defun Space_1 ()
  (cond
    ((= 1 (caar (VPORTS))) "PaperSpace")
    (t "ModelSpace")
  )
)


;|�Visual LISP� Format Options�
(105 2 15 2 nil "end of" 90 15 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
