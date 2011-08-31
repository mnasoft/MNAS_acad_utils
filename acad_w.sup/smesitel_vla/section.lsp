;;;;;;("clear:sm"
;;;;;;"������ ������� �������� ������ ������� smesitel_vla.\n
;;;;;;������� ���������� ������� ������, ��������� � ����������� smesitel_vla.\n
;;;;;;� �������� �������� ���������� ������������ ������� ���������� ��������� ������ �� ������������ ������� smesitel_vla.\n
;;;;;;��� ������ ������������ ������ �� ����� ��������, �������������� ���������� ���������.\n
;;;;;;���� � ���������� ������ �������������� ������� ����� ���������� ���� ����� ��� ������ ������� prep:sm -
;;;;;;� ����� ������ ��� ����� ���������� ��� �������� ����������.
;;;;;;��. ������� dr:sm." "���������")
(defun c:clear:sm ()
  (mapcar
    (function
      (lambda (el)
	(vlax-ldata-delete "smesitel_vla" el )
      )
    )
    '("v_spl_top"	 "v_spl_r_top"	    "v_spl_r_kt"       "v_spl_r_kb"
      "v_spl_l_bok"	 "v_spl_kr_bot"	    "v_spl_bot"	       "v_spl_alfa_bok"
      "v_pl_axis"	 "v_l_axis"
     )
  )
)


;area_lst
;length_lst
(vl-doc-set 'ulus "Go boldly to noone")
;|�Visual LISP� Format Options�
(100 2 40 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
