;|
	culc_poly_func (var fun x fun_name)-	�������  ������� - ������� � ������	
						fun_name � ������ ����������		
						������������ � ������ var ����� 1.	
	var	-	������ ���������� � ���������� ������������ �������� �������;	
	fun	-	������ �������� �������� ���������� � ������� ��������,		
			��������� �� ������� �������������, ���������� ����� ����������,	
			������� ������������� � ��������, ��� ����������� �����������.	
	x	-	������� �������������;						
	fun_name-	���������� ���������� �������� �������������� �� ����		
			��� �������.							
|;

;|	��������: �������� ������� ������ ����������� ssaa.
(CULC_POLY_FUNC
	'(XX YY)
	'((XX XX) (XX) (1.0) (YY))
	'("Matr" 1 3 ((0 . 1.0) (1 . 2.0) (2 . 3.0)))
	'ssaa
)
ssaa
((XX) (+ (* 1.0 XX XX) (* 2.0 XX) (* 3.0 1.0)))
|;

(defun culc_poly_func (var fun x fun_name / li)
  (setq
    var	(reverse (cdr (reverse var)))
    fun	(reverse (cdr (reverse fun)))
    x	(matr:get_row x 0)
    li	(mapcar 'cons x fun)
    li	(mapcar
	  (function
	    (lambda (el)
	      (cons '* el)
	    )
	  )
	  li
	)
    li	(cons '+ li)
  )
  (defun-q-list-set fun_name (list var li))
)
;|
osr_func (var fun pnt func_name) - ��������� �������-������� ����������� �� ��� (������ ���������� ���������)
var - ������ ����������;
fun - ��� ����������� �����������;
pnt - ������ ����� �� ������� ���������� �����������;
fun_name - ���������� ���������� �������� �������������� �� ���� ��� �������.

������ 1: �������� ������� ������ ����������� ���� y=a*x*x+b*x+c
��������� ������� ������������� � �������
'((0.0 0.0) (1.0 1.0) (2.0 8.0) (3.0 27.0) (-1.0 -1.0)).

(osr_func
  '(XX YY)
  '((XX XX) (XX) (1.0) (YY))
  '((0.0 0.0) (1.0 1.0) (2.0 8.0) (3.0 27.0) (-1.0 -1.0))
  'ssaa
)

SSAA
((XX) (+ (* 1.0 XX XX) (* 2.0 XX) (* 3.0 1.0)))

������ 2: �������� ������� ���� ���������� ���� y=a*x1+b*x2+c*x1*x2+d
��������� ������� ������������� � �������

(osr_func
  '(X1 X2 YY)
  '((X1) (X2) (X1 X2) (1.0) (YY))
  '((0.0  0.0 0.0) (1.0 0.0 2.0) (2.0 0.0 4.0) (0.0 1.0 1.0) (1.0 1.0 6.0  ) (2.0 2.0 18.0 ))
  'ssaa
)
|;

(defun osr_func	(var fun pnt fn_nm / x)
  (setq x (matr:sys_lu (matr:mnk var fun pnt)))
  (culc_poly_func var fun x fn_nm)
)
;|�Visual LISP� Format Options�
(95 2 5 2 nil "end of" 85 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;