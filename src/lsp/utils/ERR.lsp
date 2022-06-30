(defun file-open-err (fn) (alert (princ (strcat "\n�� ���� ������� ����: " fn ".\n"))) (exit))


(defun err (msg) (setq *error* old_err) (princ))

;;;f;;;("set-sys-var-lst (variable-lst)"
;;;f;;;"������������� �������� ��������� ����������\n
;;;f;;;variable-lst - ������, ������ ������� �������� ������ ��������� ������, ��������� ��:
;;;f;;;1 ������ - �������������� ��������� ���������� ACAD;
;;;f;;;2 ��������, ������� ��������������� ��� ���� ��������� ����������.
;;;f;;;(set-sys-var-lst '((\"cmdecho\" 1) (\"orthomode\" 0)))
;;;f;;;")
(defun set-sys-var-lst  (variable-lst)
  (mapcar (function (lambda (el) (setvar (car el) (cadr el)))) variable-lst))

;;;f;;;("get-sys-var-lst (variable-lst)"
;;;f;;;"��������� �������� ��������� ����������\n
;;;f;;;variable-lst - ������, ������ ������� �������� ������ - ���������� ��������� ���������� ACAD.
;;;f;;;(get-sys-var-lst '(\"cmdecho\" \"orthomode\" ))
;;;f;;;")
(defun get-sys-var-lst  (variable-lst)
  (mapcar (function (lambda (el) (list el (getvar el)))) variable-lst))




(defun err-init  (variable-lst          ; �����, �������� �������� - ��� ������ �� ���������� ��������� ����������.
                  /
                  echo)
  (setq *old_error* *error*
        *error* err-handle)
  (setq echo (getvar "cmdecho"))
  (setvar "cmdecho" 0)
  (command-s "_undo" "_begin")
  (setvar "cmdecho" echo)
  (setq *variable-lst* (get-sys-var-lst variable-lst)))

(defun err-handle  (msg / echo)
  (set-sys-var-lst *variable-lst*)
  (setq echo (getvar "cmdecho"))
  (setvar "cmdecho" 0)
  (command-s "_undo" "_end")
  (setvar "cmdecho" echo)
  (setq *error* *old_error*)
  (princ msg)
  (princ))


(defun c:test_err  ()
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (/ (car (getpoint "getpoint:")) (getdist "getdist:"))
  (err-handle ""))
