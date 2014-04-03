;;; ��������� ������� ���� ������ ����� ������� ��� �������-��������� ��������.
;;;


(setq
  beta (dtr 11.5)					    ; ���� ��������� ���������� ������.
  alfa (dtr 45.)					    ; ���� ������ � �����������.
)

(setq
  sin_alfa (sin alfa)
  sin_beta (sin beta)
  cos_beta (cos beta)
)


(setq
  sk   21.						    ; �������� ������� ���������� ������.
  n*sn 45.						    ; ������� ����������� �������
  rb   11.8						    ; ������ ����� �������� �����
  rm   6.9
)
(setq
  sk*rb/n*sn*rm*sin_alfa
   (/ (* sk rb sin_alfa) (* n*sn rm))
)

(setq gama
       (rtd
	 (atan
	   (/
	     (sqrt
	       (+ (* sin_beta sin_beta)
		  (* sk*rb/n*sn*rm*sin_alfa sk*rb/n*sn*rm*sin_alfa)
	       )
	     )
	     cos_beta
	   )
	 )
       )
)