;;;(princ "\n�������� utils/red_list      ")
(princ (strcat "\n�������� " (acad_sup) "/" "utils/red_list      "))


;| ������� ������ �� �������� ��� ���������� ���������.			
									
	��������� � ������� ����� �������� ����������� ������� ��:	
	1) ������� ������� � ������ ����� ������������ �������;		
	2) �������  ������� � ������ ����� ������������ ��������;	
	3) ���������� ������������ ������� � ������;			
	4) �������� ������� �� ������;					
	5) ���������� ������;						
	("list_tile" "no" '("var_1" "var_2" "var_3" ... "var_n"))	
	�� ��������� �������� ������ �� ������.				
	
|;

(setq red_list_lsp t)
	       
;;	prinf(str var f)	- ����� � ���� f �������� ���������� var ��� ������ str.
;;	��� ����������� �������� ���������� ��� ������ ������� LOAD.
(defun prinf (str var f)
  (princ (strcat "(setq " str " '") f)
  (prin1 var f)
  (princ ")\n" f)
)

;;	ins_befor ($obj $no $li) 
;;	������� ������� $obj � ������ $li ����� �������� c ������� $no
;;	����� ������� $no ����������.
;;	��� ��������� ���������� �� ������.
;;	��������:
;;	(setq ob 45.0 no 1 li '(60. 70. 80. 90.))
;;      (ins_befor 'ob  'no 'li)
;;
;;	li = (60.0 45.0 70.0 80.0 90.0)
;;	no = 2
(defun ins_befor ($obj $no $li / $i $temp)
  (set
    $no
    (cond
      ((< (eval $no) 0) 0)
      ((and (>= (eval $no) 0) (<= (eval $no) (length (eval $li))))
       (eval $no)
      )
      ((> (eval $no) (length (eval $li))) (length (eval $li)))
      (T 0)
    )
  )
  (setq $i 0)
  (mapcar
    (function
      (lambda (el)
	(if (= $i (eval $no))
	  (setq $temp (cons (eval $obj) $temp))
	)
	(setq
	  $temp	(cons el $temp)
	  $i	(1+ $i)
	)
      )
    )
    (eval $li)
  )
  (if (= $i (eval $no))
    (setq $temp (cons (eval $obj) $temp))
  )
  (set $no (1+ (eval $no)))
  (set $li (reverse $temp))
)

;;ins_after  ($obj $no $li) 
;;	������� ������� $obj � ������ $li ����� ������� c ������� $no
;;	����� ������� $no ����������.
;;	��� ��������� ���������� �� ������.
;;	��������:
;;	(setq ob 45.0 no 1 li '(60. 70. 80. 90.))
;;	(ins_after 'ob  'no 'li)
;;
;;	li = (60.0 70.0 45.0 80.0 90.0)
;;	no = 2
(defun ins_after ($obj $no $li / $i $temp)
  (set
    $no
    (cond
      ((< (eval $no) 0) 0)
      ((and (>= (eval $no) 0) (<= (eval $no) (length (eval $li))))
       (eval $no)
      )
      ((> (eval $no) (length (eval $li))) (length (eval $li)))
      (T 0)
    )
  )
  (setq $i 0)
  (mapcar
    (function
      (lambda (el)
	(setq $temp (cons el $temp))
	(if (= $i (eval $no))
	  (setq $temp (cons (eval $obj) $temp))
	)
	(setq $i (1+ $i))
      )
    )
    (eval $li)
  )
  (if (= $i (eval $no))
    (setq $temp (cons (eval $obj) $temp))
  )
  (set $no (1+ (eval $no)))
  (set $li (reverse $temp))
)

;;	del($no $li)	- �������� ������� ��� ������� $no �� ������ $li.
(defun del ($no $li / $i $temp)
  (setq $i 0)
  (mapcar
    (function
      (lambda (el)
	(if (/= $i (eval $no))
	  (setq $temp (cons el $temp))
	)
	(setq $i (1+ $i))
      )
    )
    (eval $li)
  )

  (set
    $no
    (cond
      ((< (eval $no) 0) 0)
      ((and (> (eval $no) 0) (< (eval $no) (length (eval $li))))
       (1- (eval $no))
      )
      ((>= (eval $no) (length (eval $li))) (length (eval $li)))
      ((null $temp) nil)
      (T 0)
    )
  )
  (set $li (reverse $temp))
)

;;	upd($obj $no $li)	- ������ ������� ��� ������� $no �� ������ $li �������� $obj.
(defun upd ($obj $no $li / $i $temp)
  (setq $i 0)
  (mapcar
    (function
      (lambda (el)
	(if (= $i (eval $no))
	  (setq $temp (cons (eval $obj) $temp))
	  (setq $temp (cons el $temp))
	)
	(setq $i (1+ $i))
      )
    )
    (eval $li)
  )
  (set $li (reverse $temp))
)

(princ "\t...��������.\n")
 ;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
