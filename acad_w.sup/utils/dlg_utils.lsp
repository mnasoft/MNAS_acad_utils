(defun load_dcl  (f_name)
  (setq dcl_id (load_dialog (strcat (acad_sup) f_name)))
  (if (< dcl_id 0)
    (exit)))

(defun init_dlg  (lst_setup)
  (mapcar (function (lambda (el)
                      (cond ((= 2 (length el)) (set_tile (car el) (cadr el)))
                            ((= 3 (length el))
                             (start_list (car el))
                             (mapcar (function add_list) (caddr el))
                             (end_list)
                             (set_tile (car el) (cadr el))))))
          lst_setup))

(defun action-tile_dlg  (@setup_lst @setup_lst_name)
  (mapcar (function
            (lambda (el)
              (action_tile (car el) (strcat "(setq " @setup_lst_name " (action-save_dlg " @setup_lst "))"))))
          (eval (read @setup_lst))))


(defun action-save_dlg  (setup_lst)
  (setq setup_lst (mapcar (function (lambda (el)
                                      (cond ((= 2 (length el)) (list (car el) (get_tile (car el))))
                                            ((= 3 (length el)) (list (car el) (get_tile (car el)) (caddr el))))))
                          setup_lst))
  setup_lst
;;;  (init_dlg setup_lst)
  )



;;; (SEARCH_TABLE "LAYER")
;;; (SEARCH_TABLE "LINETYPE")
;;; (SEARCH_TABLE "STYLE")
;;; (SEARCH_TABLE "DIMSTYLE")
(defun search_table  (dictionary / rez rewind tbl_name)
  (setq rewind t)
  (while (setq tbl_name (cdr (assoc 2 (tblnext dictionary rewind))))
    (setq rewind nil
          rez    (cons tbl_name rez)))
  rez)

(defun about-gpl-string  ()
  " (в составе проекта MNAS_cad_utils).\nРаспространяется по лицензии GNU GPL версии 3 или более высокой.\nРазработал Н.А. Матвеев. E-mail: mnasoft@gmail.com")
