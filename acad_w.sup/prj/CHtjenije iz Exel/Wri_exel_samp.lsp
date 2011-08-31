; Н.Н. Полещук, 2003
;===================================================
; Программа COM-связи AutoCAD - Microsoft Excel 2002
;===================================================
; Занесение подготовленных данных в создаваемый файл книги Excel
;
; Аргументы:
; shname1, shname2 – имена листов;
; bname – имя создаваемого файла.
;
; Глобальные переменные:
; g_oex - VLA-объект приложения Excel 2002;
; g_wbs - VLA-объект семейства Workbooks;
; g_cb - VLA-объект текущей книги;
; g_csh - VLA-объект первого листа;
; g_sh2 - VLA-объект второго листа;
; g_shs - VLA-объект семейства Sheets;
; g_r1, g_r2, g_cr - VLA-объекты диапазонов ячеек.
;
; Примеры обращения к программе:
; (writeex10_com "Экспорт (набор 1)" "Секция 2" "d:\\r 16\\ExportBook")
; (writeex10_com "Старт" "Финиш" "d:\\r 16\\ExportBook1")
(defun writeex10_com (shname1 shname2 bname /)
  (vl-load-com)
					; Загружаем Excel без открытых книг
  ;(setq g_oex (vlax-get-or-create-object "Excel.Application.10"))
  (setq g_oex (vlax-get-or-create-object "Excel.Application"))
					; Задаем количество листов, которое создается в новой книге
					; (по умолчанию обычно 3)
  (vlax-put-property g_oex 'SheetsInNewWorkbook 2)
					; Делаем окно Excel видимым
  (vlax-put-property g_oex 'Visible :vlax-true)
					; Указатель семейства Workbooks
  (setq g_wbs (vlax-get-property g_oex 'Workbooks))
					; Добавлем новую книгу
  (setq g_cb (vlax-invoke-method g_wbs 'Add))
					; Указатель семейства Sheets
  (setq g_shs (vlax-get-property g_cb 'Sheets))
					;
					; С помощью свойства Item получаем указатель первого листа
  (setq g_csh (vlax-get-property g_shs 'Item 1))
					; Меняем имя первого листа (было Лист1)
  (vlax-put-property g_csh 'Name shname1)
					; Указатель второго листа
  (setq g_sh2 (vlax-get-property g_shs 'Item 2))
					; Имя второго листа
  (vlax-put-property g_sh2 'Name shname2)
					; Задаем первый диапазон ячеек B3:B3 (в первом листе)
  (setq g_r1 (vlax-get-property g_oex "Range" "B3:B3"))
					; Активация второго листа
  (vlax-invoke-method g_sh2 'Activate)
					; Задаем второй диапазон ячеек A2:C4 (во втором листе)
  (setq g_r2 (vlax-get-property g_oex "Range" "A2:C4"))
					; Активация первого листа
  (vlax-invoke-method g_csh 'Activate)
					; Запись в сформированные диапазоны
  (vlax-put-property g_r1 "value2" 1234)
  (vlax-put-property g_r2 "value2" "Пишу в тишине")
					; Задаем третий диапазон из ячейки E7 (в первом листе)
  (setq g_cr (vlax-get-property g_csh 'Range "E7")) ;
					; Запись в ячейку
  (vlax-put-property g_cr "value2" -17.873)
					; Сохраняем новую книгу (XLS-файл)
  (vlax-invoke-method
    g_cb 'SaveAs bname -4143 ""	"" :vlax-false :vlax-false nil)
					; Выходим из Excel
  (vlax-invoke-method g_oex "Quit")
					; Освобождение объектов и выгрузка Excel
  (if (and g_cr (not (vlax-object-released-p g_cr)))
    (vlax-release-object g_cr)
  )
  (if (and g_r2 (not (vlax-object-released-p g_r2)))
    (vlax-release-object g_r2)
  )
  (if (and g_r1 (not (vlax-object-released-p g_r1)))
    (vlax-release-object g_r1)
  )
  (if (and g_csh (not (vlax-object-released-p g_csh)))
    (vlax-release-object g_csh)
  )
  (if (and g_sh2 (not (vlax-object-released-p g_sh2)))
    (vlax-release-object g_sh2)
  )
  (if (and g_shs (not (vlax-object-released-p g_shs)))
    (vlax-release-object g_shs)
  )
  (if (and g_cb (not (vlax-object-released-p g_cb)))
    (vlax-release-object g_cb)
  )
  (if (and g_wbs (not (vlax-object-released-p g_wbs)))
    (vlax-release-object g_wbs)
  )
  (if (and g_oex (not (vlax-object-released-p g_oex)))
    (vlax-release-object g_oex)
  )
					; Обнуление использованных глобальных переменных
  (setq	g_cr nil
	g_r2 nil
	g_r1 nil
	g_csh nil
	g_sh2 nil
	g_shs nil
	g_cb nil
	g_wbs nil
	g_oex nil
  )
					; Сборка мусора
  (gc)
)
