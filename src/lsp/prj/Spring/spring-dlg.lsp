(setq spring-setup_msg
       '(("d" "������� ���������, ��")
         ("D1" "������� ������� ��������, ��")
         ("D" "������� ������� �������, ��")
         ("L0" "������ ������� � ��������� ���������, ��")
         ("L1" "������ ������� ��� ��������������� ����������, ��")
         ("L2" "������ ������� ��� ������� ����������, ��")
         ("L3" "������ ������� ��� ������������ ����������, ��")
         ("L4" "������ ������� ��� ��������������� ������, ��")
         ("S1" "��������������� ���������� �������, ��")
         ("S2" "������� ���������� �������, ��")
         ("S3" "������������ ���������� �������, ��")
         ("t" "��� ������� � ��������� ���������, ��")
         ("Sk" "������� ����� �������� ����� �������, ��")
         ("h" "������� ��� �������, ��")
         ("L" "����� ��������� ����������� �������, ��")
         ("n" "����� ������ �������")
         ("n1" "������ ����� ������ �������")
         ("i" "������ �������")
         ("K1" "�����������, ����������� ������� �������� �����")
         ("K2" "�����������, ����������� ������� ���������� ����")
         ("F1" "���� ������� ��� ��������������� ����������, �")
         ("F2" "���� ������� ��� ������� ����������, �")
         ("F3" "���� ������� ��� ������������ ����������, �")
         ("tau1" "���������� ��� �������� ��� ��������������� ����������, ���")
         ("tau2" "���������� ��� �������� ��� ������� ����������, ���")
         ("tau3" "���������� ��� �������� ��� ������������ ����������, ���")
         ("[tau]" "����������� ���������� ��� ��������, ���")
         ("C" "��������� �������, �/��")
         ("G" "������ ������, ���")
         ("i1" "��������� ����� ������� � ��������� ��������� � � �������� ��������")
         ("m" "����� �������, ��")))

(defun c:spring  (/ action dcl_id do_dialog)
  (setq setup_lst '(("d" "1.0")           ; ������� ���������, ��
                  ("D1" "24.0")         ; ������� ������� ��������, ��
                  ("D" "23.0")          ; ������� ������� �������, ��
                  ("L0" "32")           ; ������ ������� � ��������� ���������, ��
                  ("L1" "30.0")         ; ������ ������� ��� ��������������� ����������, ��
                  ("L2" "25.0")         ; ������ ������� ��� ������� ����������, ��
                  ("L3" "22.0")         ; ������ ������� ��� ������������ ����������, ��
                  ("L4" "5.5")          ; ������ ������� ��� ��������������� ������, ��
                  ("S1" "30.0")         ; ��������������� ���������� �������, ��
                  ("S2" "25.0")         ; ������� ���������� �������, ��
                  ("S3" "22.0")         ; ������������ ���������� �������, ��
                  ("t" "8.125")         ; ��� ������� � ��������� ���������, ��
                  ("Sk" "0.5")          ; ������� ����� �������� ����� �������, ��
                  ("h" "10.0")          ; ������� ��� �������, ��
                  ("L" "200.0")         ; ����� ��������� ����������� �������, ��
                  ("n" "4.0")           ; ����� ������ �������
                  ("n1" "6.0")          ; ������ ����� ������ �������
                  ("i" "")              ; ������ �������
                  ("K1" "")             ; �����������, ����������� ������� �������� �����
                  ("K2" "")             ; �����������, ����������� ������� ���������� ����
                  ("F1" "")             ; ���� ������� ��� ��������������� ����������, �
                  ("F2" "")             ; ���� ������� ��� ������� ����������, �
                  ("F3" "")             ; ���� ������� ��� ������������ ����������, �
                  ("tau1" "")           ; ���������� ��� �������� ��� ��������������� ����������, ���
                  ("tau2" "")           ; ���������� ��� �������� ��� ������� ����������, ���
                  ("tau3" "")           ; ���������� ��� �������� ��� ������������ ����������, ���
                  ("[tau]" "640.0")     ; ����������� ���������� ��� ��������
                  ("C" "")              ; ��������� �������, �/��
                  ("G" "72600.0")       ; ������ ������, ���
                  ("i1" "")             ; ��������� ����� ������� � ��������� ��������� � � �������� ��������
                  ("m" "")              ; ����� �������, ��
                  ))
  (setq dcl_id (load_dialog "./src/lsp/prj/spring/Spring.DCL"))
  ;;  ;; "E:/home/namatv/git/GitHub/mnasoft/MNAS_acad_utils/src/lsp/prj/spring/Spring.DCL"
  (setq do_dialog t)
  (while do_dialog
    (if (not (new_dialog "spring" dcl_id))
      (exit))
    (init_dlg setup_lst)
    (action-tile_dlg "setup_lst" "setup_lst" "(spring-err)" "")
    (action_tile "d" "(spring-action_d)")
    (action_tile "D" "(spring-actionD)")
    (action_tile "D1" "(spring-actionD1)")
    (action_tile "n1" "(spring-action_n1)")
    (action_tile "n" "(spring-action_n)")
    (action_tile "t" "(spring-action_t)")
    (action_tile "L0" "(spring-actionL0)")
    (action_tile "S1" "(spring-actionS1)")
    (action_tile "L1" "(spring-actionL1)")
    (action_tile "S2" "(spring-actionS2)")
    (action_tile "L2" "(spring-actionL2)")
    (action_tile "S3" "(spring-actionS3)")
    (action_tile "L3" "(spring-actionL3)")
    (action_tile "G" "(spring-actionG)")
    (action_tile "info" "(spring-info)")
    (action_tile "help" "(spring-help)")
    (action_tile "Print" "(spring-print-html)")
    (action_tile "Draw" "(done_dialog 2)")
    (setq action (start_dialog))
    (cond ((= action 0) (setq do_dialog nil))
          ((= action 1) (setq do_dialog nil))
          ((= action 2) (spring-draw))))
  (unload_dialog dcl_id)
;;;  (setq *error* old_err)
;;;  (command "_.undo" "_end")
;;;  (setvar "cmdecho" 1)
  )

;;������� ��� ���������� ������ ���������� � ���������� setup_lst.
(defun spring-save-setup-lst () (setq setup_lst (action-save_dlg setup_lst)))

(defun spring-info () (alert (strcat "������ ������� ������ " (about-gpl-string))))

(defun spring-help () (help (strcat (acad_help) "/spring/spring.html")))

 