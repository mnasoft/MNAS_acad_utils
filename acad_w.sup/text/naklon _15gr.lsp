;;;(princ "\n�������� text/naklon _15gr.lsp")
(princ (strcat "\n�������� " (acad_sup) "/" "text/naklon _15gr.lsp"))

;;;;;;("to_15" "��������� ��������� �������� �� ���� � 15 ���." "������")
(defun c:to_15 (/ ed en)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq
    en (car (nentsel))
    ed (entget en)
    ed (subst (cons 51 0.261799) (assoc 51 ed) ed)
  )
  (entmod ed)
  (entupd en)
  (err-handle "")
)

(princ "\t...��������.\n")
;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
