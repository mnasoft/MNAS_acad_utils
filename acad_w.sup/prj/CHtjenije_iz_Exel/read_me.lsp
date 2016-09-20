(defun make_ssaa_list (li)
  (mapcar 'list li (mapcar 'ssaa li))
)

(select_column nm '(0 3))

(osr_func '(XX YY) '( (XX XX) (XX) (1.0) (YY)) br2 'ssaa)
(setq aaa(make_ssaa_list '( 25. 50. 100. 125. 150. 175. 200. 225. 250. 275. 300. 325. 350. 375. )))