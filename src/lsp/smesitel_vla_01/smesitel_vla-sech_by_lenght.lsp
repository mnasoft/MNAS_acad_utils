;;;;;;("dr:sech"
;;;;;; "��������� ��������� ���������� ������� �� ���� ��� ������������."
;;;;;; "���������")
(defun c:dr:sech  (/			; area_lst - ������� ������� ��������� (��������);
					; length_lst - ��������� ������� ��������� (��������);
					; div - ���������� ����������� ����� ���������
		     delta_pl_axis-length
					; ���������� ����� ��� ���������
		     delta_l_axis-length; ���������� ����� ��� ������������
		     i			; ������� �������
		     dist_pl		; ������� ���������� ����� ��� ���������
		     par_pl		; �������� ��������� � ������� ����� �� ��� ���������
		     par_pnt		;
		     par_pntFD		; ������ ����������� �� ��� ������� ���������
		     pl-dist		;
		     param_l-b		; �������� ��������� L-b
		     param_l-s		; �������� ��������� L-s
		     pnt_1		;
		     lst		; ������ ename ����������, �������� � �������
		     ang-sech		; ���� ������������ �������
		     )
  (init-vars)
  (if (not (and v-pl-axis v-l-axis v_l-b v-l-s))
    (c:prep:sm))
  (setq ang-sech (GETANGLE "������� ���� ������������ �������:"))
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq	dist_pl	  (* R-in (- ang-sech pi/2))
	par_pl	  (vlax-curve-getParamAtDist v-pl-axis dist_pl)
	par_pnt	  (vlax-curve-getPointAtParam v-pl-axis par_pl)
	par_pntFD (vlax-curve-getFirstDeriv v-pl-axis par_pl)
	pl-dist	  (vlax-curve-getDistAtParam v-pl-axis par_pl))
  (setq	param_l-b (distance-from-curve-by-param-to-curve
		    v-l-axis
		    pl-dist
		    v_l-b))
  (setq	param_l-s (distance-from-curve-by-param-to-curve
		    v-l-axis
		    pl-dist
		    v-l-s))
  (setq pnt_1 (list 0.0 261.5 0.0))
  (setq lst (draw-sech-4 param_l-b param_l-s))
  (err-handle ""))

