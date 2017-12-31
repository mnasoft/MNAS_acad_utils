(setq метод_покоординатного_спуска_lsp t)
					;Производит поиск максимума функции f, зависящей от списка параметров

(defun spusk  (f			;	- имя функции, максимальное значение которой отыскивается 
	       x			;	- список параметров в текущей точке
	       h			;	- список приращений для шагов по каждому из параметров
	       k_u			;	- список коэффициентов усиления для каждого из приращений (дб > 1.0)
	       k_o			;	- список коэффициентов ослабления для каждого из приращений (дб < 1.0)
	       n_iter			;	- количество итрераций
	       /     y			;	- значение функции при параметрах x
	       x_temp			;	- пробные параметры
	       y_temp			;	- значение функции при параметрах x_temp
	       iter			;	- итерация
	       i			;	- номер координаты по которой производится спуск (изменяется от 0 до n-1)
	       n			;	- количество параметров
	       x+			;	- функция производит расчет x_temp при шаге из x по i-тому папараметру в +
	       x-			;	- функция производит расчет x_temp при шаге из x по i-тому папараметру в -
	       apl			;	- выполняет нахождение зачения функции f при параметрах x_temp
	       h+			;	- производит увеличение шага для i-того параметра
	       h-			;	- производит уменьшение шага для i-того параметра
	       y+			;	- значение функции в при параметрах x+
	       y-			;	- значение функции в при параметрах x-
	       )
  (defun apl () (setq y_temp (apply 'f x_temp)))
  (defun x+  (/
	      xx			;	- значение i-того параметра
	      hh			;	- шаг по i-тому параметру
	      )
    (setq xx	 (nth i x)
	  hh	 (nth i h)
	  xx	 (+ xx hh)
	  x_temp x)
    (upd 'xx 'i 'x_temp))
  (defun x-  (/
	      xx			;	- значение i-того параметра
	      hh			;	- шаг по i-тому параметру
	      )
    (setq xx	 (nth i x)
	  hh	 (nth i h)
	  xx	 (- xx hh)
	  x_temp x)
    (upd 'xx 'i 'x_temp))
  (defun h+  (/
	      hh			;	- шаг по i-тому параметру
	      kk			;	- коэффициент усиления по i-тому параметру
	      )
    (setq hh (nth i h)
	  kk (nth i k_u)
	  hh (* hh kk))
    (upd 'hh 'i 'h))
  (defun h-  (/
	      hh			;	- шаг по i-тому параметру
	      kk			;	- коэффициент ослабления по i-тому параметру
	      )
    (setq hh (nth i h)
	  kk (nth i k_o)
	  hh (* hh kk))
    (upd 'hh 'i 'h))
  (if (null red_list_lsp)
    (load (findfile (utils:path-src-lsp "UTILS/red_list.lsp"))))
  (setq	n      (length x)
	iter   0
	x_temp x
	y      (apl))
  (while (<= iter n_iter)
    (setq i 0)
    (while (< i n)
      (x+)
      (apl)
      (setq y+ y_temp)
      (x-)
      (apl)
      (setq y- y_temp)
      (cond ((<= y- y+)
	     (if (> y+ y)
	       (progn (x+)
		      (setq y y+
			    x x_temp)
		      (h+))
	       (h-))			;if 
	     )
	    ((> y- y+)
	     (if (> y- y)
	       (progn (x-)
		      (setq y y-
			    x x_temp)
		      (h+))
	       (h-))			;if
	     ))				;cond
      (setq i (1+ i)))			;while
    (setq iter (1+ iter)))		;while
  (princ "\niter= ")
  (prin1 iter)
  (princ " ")
  (princ "\ny= ")
  (prin1 y)
  (princ " ")
  (princ "\nx= ")
  (prin1 x)
  (princ " ")
  (princ "\nh= ")
  (prin1 h)
  (princ " ")
  x)
