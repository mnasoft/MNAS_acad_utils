;;; ���������� ������� �� �������.
(defun % (val base / temp)
  (setq temp (/ val base))
  (- val (* temp base))
)

;;;������������� ������ ����� val � ���� ������,
;;;���������� �������� �������� �������� �������� ����� val � ������� ��������� � ���������� base.
;;;
;;;_$ (����������_��_��������� 123 10)
;;;(1 2 3)
;;;_$ (����������_��_��������� 123 8)
;;;(1 7 3)
;;;_$ (����������_��_��������� 123 2)
;;;(1 1 1 1 0 1 1)
;;;_$ (����������_��_��������� 123 16)
;;;(7 11)
(defun ����������_��_��������� (val						;����� ������������� �����
				base						;��������� ������� ���������
				/ ost lst)
  (setq	val  (fix val)
	base (fix base)
  )
  (cond
    ((= val 0)
     (setq lst '(0))
    )
    ((> val 0)
     (while (> val 0)
       (setq ost (% val base)
	     val (/ val base)
	     lst (cons ost lst)
       )
     )
    )
  )
)




;;;���������� ���������� ������ ����� �� ��������������� ��� ������ ��������.
;;;_$ (����������_��_��������� '(1 2 3 6 5 2 0 4) 10)
;;;12365204
(defun ����������_��_��������� (lst						;������ �����l��
				base						;��������� ������� ���������
				/ ln sc	sum)
  (setq
    ln	(length lst)
    sc	1
    sum	0
  )
  (while (> ln 0)
    (setq
      ln  (1- ln)
      sum (+ sum (* sc (nth ln lst)))
      sc  (* sc base)
    )
  )
  sum
)

;;;����������� ������ �������� str, �������������� ����� �����,
;;;�������������� � ������� ��������� � ���������� base,
;;;� ����� �����.
;;;
;;;_$ (������->����� "123" "0" 4)
;;;27
;;;_$ (������->����� "123" "0" 10)
;;;123
(defun ������->�����  (str              ;������������� ������
                       base_chr         ;���������� ������ � ������� ���������
                       base             ;��������� ������� ���������
                       / delta el lst lst-i lst-len lst-rez)
  (setq delta (ascii base_chr))
  (����������_��_���������
    (progn (setq lst     (vl-string->list str)
                 lst-len (length lst)
                 lst-i   -1)
           (while (< (setq lst-i (1+ lst-i)) lst-len)
             (setq el      (nth lst-i lst)
                   lst-rez (cons (progn (- el delta)) lst-rez)))
           (setq lst-rez (reverse lst-rez)))
    base))

;;;���������� �������������� ������ ����� � ������ ��������
;;;_$ (�����_������ 123 "0" 10)
;;;"123"
(defun �����->������  (i                ;������������� ����� ������������� �����
                       base_chr         ;���������� ������ � ������� ���������
                       base             ;��������� ������� ���������
                       / el lst lst-i lst-len lst-rez)
  (apply (function strcat)
         (progn (setq lst     (����������_��_��������� i base)
                      lst-len (length lst)
                      lst-i   -1)
                (while (< (setq lst-i (1+ lst-i)) lst-len)
                  (setq el      (nth lst-i lst)
                        lst-rez (cons (progn (�����->������ el base_chr)) lst-rez)))
                (setq lst-rez (reverse lst-rez)))))

;(macro-mapcar '(mapcar (function (lambda (el) (�����->������ el base_chr))) (����������_��_��������� i base)))

;;;������������ ��������� �������� �����->������.
;;;_$ (�����->������ 0 "A")
;;;"A"
;;;_$ (�����->������ 5 "A")
;;;"F"
(defun �����->������ (i base_chr)
  (chr (+ (ascii base_chr) i))
)
