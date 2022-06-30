(defun init-vars  ()
  (setq div 90)
  (setq	area_lst nil
	length_lst nil))

;;;f;;;("(init-profile-const)"
;;;f;;; "������������� ���������, ������������ ��� ���������� ���������-������. \n")
(defun init-profile-const  ()
  (setq	p-0  '(0.0 0.0 0.0)
	pi/2 (/ pi 2)
	)
  (setq	R-in	(/ 523.0 2.0)
	L-1	-26.0
	L-2	42.5
	R-1	64.8
	R-2	47.0
	R-3	18.5
	R-4	(/ 636.0 2.0)
	R-5	58.4
	alpha-2	(dtr (+ 90.0 30.0))
	alpha-1	(dtr 15.0)
	delta	10.0))

(defun draw-points  ()
  (dr:point p-0 1)
  (dr:point p-1 2)
  (dr:point p-2 3)
  (dr:point p-3 6)
  (dr:point p-4 10)
  (dr:point p-5 20)
  (dr:point p-6 30)
  (dr:point p-7 40)
  (dr:point p-7-1 50)
  (dr:point p-8 60)
  (dr:point p-8-b 70)
  (dr:point p-8-e 80)
  (dr:point p-10 90)
  (dr:point p-11 100)
  (dr:point p-R1 4)
  (dr:point p-R2 5))

;;;f;;;("(draw-profile)"
;;;f;;; "���������� ��������� �������. \n
;;;f;;;  ���������� ������ ename ����������, ���������� �������. \n")
(defun draw-profile (/ v-a-1 v-l-2 v-a-3 v-l-4 v-a-5 v-l-6 v-a-7)
  (setq v-a-1 (vlax-vla-object->ename (dr:arc p-3 r-5 (+ alpha-2 pi/2) (* 3.0 pi/2) 1)))
  (setq v-l-2 (vlax-vla-object->ename (dr:line p-4 p-8-e 2)))
  (setq v-a-3 (vlax-vla-object->ename (dr:arc p-R1 R-1 pi/2 (+ alpha-2 pi/2) 1)))
  (setq v-l-4 (vlax-vla-object->ename (dr:line p-7 p-13 3)))
  (setq v-a-5 (vlax-vla-object->ename (dr:arc p-R2 R-2 (- alpha-1 pi/2) pi/2 1)))
  (setq v-l-6 (vlax-vla-object->ename (dr:line p-10 p-12-e 4)))
  (setq v-a-7 (vlax-vla-object->ename (dr:arc p-2 R-3 (+ alpha-1 pi/2) pi 1)))
  (list v-a-1 v-l-2 v-a-3 v-l-4 v-a-5 v-l-6 v-a-7))

(mapcar (function (lambda (el) (eval (read el))))
	  (list	"v-a-1"	"v-l-2"	"v-a-3"	"v-l-4"	"v-a-5"	"v-l-6"	"v-a-7"))

;;;f;;;("(draw-sech-4 L-b L-s)"
;;;f;;; "���������� ��������� ������� �� ����� ��. ������ ���� \n
;;;f;;;  _$(draw-sech-4 161.0 78.0) \n
;;;f;;; \n
;;;f;;;  ���������� ������ �� 7-�� ��������� ���� �name: \n
;;;f;;; 1. ����, ����������� �� � ����� 2; \n
;;;f;;; 2. �����, ���������� ����� ������� ���������� ���������; \n
;;;f;;; 3. ���� ��������� ����� 1 � ������������ ���������� ���������; \n
;;;f;;; 4. �����, ���������� ������������ ���������� ���������; \n
;;;f;;; 5. ����, ����������� ����� 4 � ����� 6; \n
;;;f;;; 6. �����, ���������� ������ ������� ���������� ���������; \n
;;;f;;; 7. ����, ����������� �� � ����� 6. \n
;;;f;;;   \n
;;;f;;; ���������� ����������: \n
;;;f;;; area_lst   - ������������ ����-�������� ���������� �������; \n
;;;f;;; per-r_top  - ������������ ��������� r_top (������� ������); \n
;;;f;;; per-r_kt   - ������������ ��������� r_kt (������� �� �������� ������� � ������� �����������); \n
;;;f;;; per-l_bok  - ������������ ��������� l_bok (������� �����������); \n
;;;f;;; per-r_kb   - ������������ ��������� r_kb (������� �� ������� ����������� � ������� �������; \n
;;;f;;; per-r_bot  - ������������ ��������� r_bot (������ ������); \n
;;;f;;; length_lst - ������������ ����-���������� ���������� �������.")
(defun draw-sech-4 (L-b	L-s     /      p-1    p-2    p-3	   p-4
		    p-5	p-6    p-7    p-7-1  p-8    p-8-b  p-R1
		    R-1	p-8-e  p-10   p-11   p-12   p-12-b p-13
		    p-13-1	p-R2   R-2    p-12-e)
  (init-profile-const)
  (setq p-1 (polar p-0 pi/2 R-in))
  (setq p-2 (polar p-1 pi/2 L-2))
  (setq p-3 (polar p-1 pi/2 R-5))
  (setq p-4 (polar p-3 (+ alpha-2 pi/2) R-5))
  (setq p-5 (polar p-4 alpha-2 delta))
  (setq p-6 (polar p-1 pi/2 L-b))
  (setq p-7 (polar p-6 0.0 L-1))
  (setq p-7-1 (polar p-7 pi/2 delta))
  (setq p-8 (INTERS p-4 p-5 p-6 p-7 nil))
  (setq p-8-b (polar p-8 (/ (- alpha-2 pi) 2.0) delta))
  (setq p-R1 (INTERS p-7 p-7-1 p-8 p-8-b nil))
  (setq R-1 (distance p-7 p-R1))
  (setq p-8-e (polar p-R1 (+ alpha-2 pi/2) R-1))
  (setq p-10 (polar p-2 (+ alpha-1 pi/2) R-3))
  (setq p-11 (polar p-10 alpha-1 delta))
  (setq p-12 (INTERS p-6 p-7 p-10 p-11 nil))
  (setq p-12-b (polar p-12 (/ alpha-1 2.0) delta))
  (setq p-13 (polar p-7 0.0 L-s))
  (setq p-13-1 (polar p-13 pi/2 delta))
  (setq p-R2 (INTERS p-13 p-13-1 p-12 p-12-b nil))
  (setq R-2 (distance p-13 p-R2))
  (setq p-12-e (polar p-R2 (- alpha-1 pi/2) R-2))
  (draw-profile))


;;===================================================================================================


(defun smesitel_vla_put	 (v_name / handle)
  (setq handle (vlax-get-property (eval (read v_name)) "Handle"))
  (vlax-ldata-put "smesitel_vla" v_name handle))

(defun set_vla_name_handle_lst	(/ lst handle_lst vla_name_lst)
  (setq	lst	     (vlax-ldata-list "smesitel_vla")
	handle_lst   (mapcar (function cdr) lst)
	vla_name_lst (mapcar (function car) lst))
  (mapcar (function set_vla_name_handle)
	  handle_lst
	  vla_name_lst))

(defun set_vla_name_handle  (handle vla_name / ename)
  (setq ename (find_ename_whis_handle handle))
  (set (read vla_name) (vlax-ename->vla-object ename)))


(defun smesitel_vla_put_lst  ()
  (mapcar (function smesitel_vla_put)
	  '("v-pl-axis" "v-l-axis" "v_l-b" "v-l-s")))


;;;;;;("prep:sm" "���������� ������ ��� ���������� ���������. ��. ������� dr:sm." "���������")
(defun c:prep:sm  ()
  (prompt "�������� ��� ���������:")
  (vla-obj "v-pl-axis")
  (prompt
    "��� ������� ������������, ������������ ��������� ���������:")
  (vla-obj "v-l-axis")
  (prompt "����������� ��� ��������� L-b (������ ���������):")
  (vla-obj "v_l-b")
  (prompt
    "����������� ��� ��������� L-s (����� �������������� �������):")
  (vla-obj "v-l-s")
  (smesitel_vla_put_lst))

;;;;;;("dr:sm"
;;;;;;"������ Smesitel_vla_01. \n
;;;;;;	������ ������������ ��� �������������� ����������� ������� ��������� ������� �����. \n
;;;;;;	������ ���������� ��������� �������: \n
;;;;;;		prep:sm    - ���������� ������ ��� ���������� ��������; \n
;;;;;;		dr:sm      - ��������� ��������� �� �������������� ������; \n
;;;;;;		dr:sech    - ��������� ���������� ������� �� ����; \n
;;;;;;		clear:sm   - ������� ������ ����������, ����������� � ����������� �������; \n
;;;;;;		vla-obj    - ������������� ��� ������ ����� �� ���������� ���������. \n
;;;;;; \ n
;;;;;;	������ ���������� ��������� ����������, ������������ ��� \n
;;;;;;  �������� ���������� � �������������� ���������� ���������: \n
;;;;;;		v-pl-axis - ��� ���������; \n
;;;;;;		v-l-axis  - ��� ������� ��� ������������ ��������� ����; \n
;;;;;;		v_l-b     - ���������� �� ���������� ����� ��������� �� ������� ����������; \n
;;;;;;		v-l-s     - ����� ������� ����������; \n
;;;;;; \n
;;;;;; ��� ���������� �������� ������������ ����� ������������ ����������: \n
;;;;;;  - area_lst - ������� ��������� ������� ���������; \n
;;;;;;  - length_lst - ��������� ���������� ������� ���������, \n
;;;;;; � ��������� � �������� a1. \n"
;;;;;; "���������")
(defun c:dr:sm	(/			; area_lst - ������� ������� ��������� (��������);
					; length_lst - ��������� ������� ��������� (��������);
					; div - ���������� ����������� ����� ���������
		 delta_pl_axis-length	; ���������� ����� ��� ���������
		 delta_l_axis-length	; ���������� ����� ��� ������������
		 i			; ������� �������
		 dist_pl		; ������� ���������� ����� ��� ���������
		 par_pl			; �������� ��������� � ������� ����� �� ��� ���������
		 par_pnt		;
		 par_pntFD		; ������ ����������� �� ��� ������� ���������
		 pl-dist		;
		 param_l-b		; �������� ��������� L-b
		 param_l-s		; �������� ��������� L-s
		 pnt_1		lst	; ������ ename ����������, �������� � �������
		 )
  (init-vars)
  (if (not (and v-pl-axis v-l-axis v_l-b v-l-s))
    (c:prep:sm))
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq	delta_pl_axis-length
	 (/ (vlax-get-property v-pl-axis 'Length) div)
	delta_l_axis-length
	 (/ (vlax-get-property v-l-axis 'Length) div))
  (setq i (+ 1 div))
  (while (>= (setq i (1- i)) 0)
    (setq dist_pl   (* i delta_pl_axis-length)
	  par_pl    (vlax-curve-getParamAtDist v-pl-axis dist_pl)
	  par_pnt   (vlax-curve-getPointAtParam v-pl-axis par_pl)
	  par_pntFD (vlax-curve-getFirstDeriv v-pl-axis par_pl)
	  pl-dist   (vlax-curve-getDistAtParam v-pl-axis par_pl))
    (setq param_l-b (distance-from-curve-by-param-to-curve
		      v-l-axis
		      pl-dist
		      v_l-b))
    (setq param_l-s (distance-from-curve-by-param-to-curve
		      v-l-axis
		      pl-dist
		      v-l-s))
    (setq pnt_1 (list 0.0 261.5 0.0))
    (setq lst (draw-sech-4 param_l-b param_l-s))
    (mapcar
      (function
	(lambda	(el)			; ������� ������� � ����� ����������
	  (setq v-el (vlax-ename->vla-object el))
	  (vlax-invoke-method
	    v-el
	    'Move
	    (vlax-3D-point pnt_1)
	    (vlax-3D-point par_pnt))
	  (vlax-invoke-method
	    v-el
	    'Rotate
	    (vlax-3D-point par_pnt)
	    (angle par_pntFD '(0.0 0.0 0.0)))
	  (vlax-invoke-method
	    v-el
	    'Rotate3D
	    (vlax-3D-point par_pnt)
	    (vlax-3D-point
	      (polar par_pnt
		     (- (angle '(0.0 0.0 0.0) par_pntFD) (/ pi 2))
		     100.0))
	    (/ pi -2))))
      lst)
    ;;(setq area_lst   (cons (list dist_pl (vlax-get-property (nth 0 lst) 'Area))   area_lst))
    ;;(setq length_lst (cons (list dist_pl (vlax-get-property (nth 0 lst) 'Length)) length_lst))
    )
  ;; (smesitel_vla_put_lst)
  ;; (mapcar (function (lambda (el) (vl-doc-set el (eval el))))	  '(area_lst length_lst))
  (err-handle ""))




;;	���� ��������
;;_$ (digit 10.5564)
;;1.0
;;_$ (digit -10.5564)
;;-1.0
(defun digit (val) (/ val (abs val)))

(defun c:sm:help  ()
  (princ
    "
  ===================================================================================
  ������ Smesitel_vla_01
  ===================================================================================
    
  ������ ������������ ��� �������������� ����������� ������� ��������� ������� �����.
 
  ������ ���������� ��������� �������:
   prep:sm    - ���������� ������ ��� ���������� ��������;
   dr:sm      - ��������� ��������� �� �������������� ������;
   dr:sech    - ��������� ���������� ������� �� ����;
   clear:sm   - ������� ������ ����������, ����������� � ����������� �������;
   vla-obj    - ������������� ��� ������ ����� �� ���������� ���������.
   
 ������ ���������� ��������� ����������, ������������ ���
 �������� ���������� � �������������� ���������� ���������:
    v-pl-axis - ��� ���������;
    v-l-axis  - ��� ������� ��� ������������ ��������� ����;
    v_l-b     - ���������� �� ���������� ����� ��������� �� ������� ����������;
    v-l-s     - ����� ������� ����������;

  ��� ���������� �������� ������������ ����� ������������ ����������:
    - area_lst - ������� ��������� ������� ���������;
    - length_lst - ��������� ���������� ������� ���������,
  � ��������� � �������� a1.")
  (princ))


(set_vla_name_handle_lst)


