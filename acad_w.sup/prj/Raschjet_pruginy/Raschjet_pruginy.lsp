(setq
  G_list
   
;;;- ������ ������ [��],
;;;- ������������ ����������� [C],
;;;- ���������� ����������� [C],
;;;- ����������� ���������� ������ ������ ��� ����������
;;;����������� �� ���������� �� ������������
   '
    (
     ("1 �����" 78500.0e6 50. 20. 0.0)
     ("60�2�" 78500.0e6 250. 20. 0.1)
     ("65�" 78500.0e6 50. 20. 0.0)
     ("51���" 81400.0e6 250. 20. 0.1)
     ("10�11�23�3��-��" 72600.0e6 600. 20. 0.3)
     ("10�15�27�3��-��" 72600.0e6 600. 20. 0.3)
     ("12�18�10�" 68600.0e6 250. 20. 0.1)
    )
)

(defun G[�-�,t-�] (�-� t-� / G_nor data t_max t_nor koeff)
  (setq
    data  (assoc �-� G_list)
    G_nor (cadr data)
    t_max (caddr data)
    t_nor (cadddr data)
    koeff (car (cddddr data))
  )
  (* G_nor
     (- 1.0 (* koeff (/ (- t-� t_nor) (- t_max t_nor))))
  )
)

(defun ������_�������()
 (setq
   G 78500.0e10
    ) 
)
;|�Visual LISP� Format Options�
(72 2 5 2 nil "end of" 60 9 0 0 0 T T nil T)
;*** DO NOT add text below the comment! ***|;
