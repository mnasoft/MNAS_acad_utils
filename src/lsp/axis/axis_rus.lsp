(setq *axis-command-list* '("a1" "an" "a2" "a2t" "a2xyn_t" "a2xy_t" "a3" "a4" "a5" "a6" "an" "ax" "c1" "c2" "c3" "c4" "ea" "epr" "im"))

;;;;(opech_cmds-str  *axis-command-list*)

(defun c:�1() (c:a1))
(defun c:��() (c:an))
(defun c:�2() (c:a2))
(defun c:�2�() (c:a2t))
(defun c:�2���_�() (c:a2xyn_t))
(defun c:�2��_�() (c:a2xy_t))
(defun c:�3() (c:a3))
(defun c:�4() (c:a4))
(defun c:�5() (c:a5))
(defun c:�6() (c:a6))
(defun c:��() (c:an))
(defun c:��() (c:ax))
(defun c:�1() (c:c1))
(defun c:�2() (c:c2))
(defun c:�3() (c:c3))
(defun c:�4() (c:c4))
(defun c:��() (c:ea))
;(defun c:���() (c:epr))
(defun c:��() (c:im))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun c:mnas-menu-delete-toolbar-axis  ()
  (vlax-invoke-method
    (mnas-vlax-utils-search-toolbar-by-name
      (mnas-vlax-utils-search-menu-by-name "MNAS_CLEAN")
      "MNAS_Clean_Axis")
    'Delete))

(defun mnas-axis-Add-Toolbar-Button  (c-n-h)
  (setq	menu-name    "MNAS_CLEAN"
	toolbar-name "MNAS_Clean_Axis"
	command-name (car c-n-h)
	command-help (cadr c-n-h)
	button-name  (STRCASE (VL-STRING-TRANSLATE "-" "_" command-name) nil)
	icon-path    "./menus/Acad_mnu_icon/axis/"
	icon-name    (VL-STRING-TRANSLATE "-" "_" command-name)
	icon-name-16 (strcat icon-path icon-name "_16.bmp")
	icon-name-32 (strcat icon-path icon-name "_32.bmp"))
  (mnas-vlax-utils-add-Toolbar-name-Button
    menu-name toolbar-name button-name command-name command-help icon-name-16 icon-name-32))



(defun c:mnas-menu-add-toolbar-axis  ()
  (mapcar (function mnas-axis-Add-Toolbar-Button)
	  '(("mnas-axis-mode-setup" "��������� ������ ����������� � �����������")
	    ("mnas-axis-edit" "�������������� ������� � ��� & �������������� ���")
	    ("mnas-axis-graph-xy" "���������� ��������� � ����������� ���� ����.")
	    ("mnas-axis-graph-xy-n" "���������� ��������� ��������� � ����������� ���� ����")
	    ("mnas-axis-point" "���������� ����� � ����������� �����")
	    ("mnas-axis-point-text" "���������� ����� � ����������� ����� � ��������� ������")
	    ("mnas-axis-tick" "���������� ����� ����� � ����������� 2-� ���� � ��������� ������")
	    ("mnas-axis-ticks" "���������� ����� ����� � ����������� 2-� ���� � ��������� ������")
	    ("mnas-axis-draw-xy" "���������� ����� � ����������� ���� ���� �� �� �����������")
	    ("mnas-axis-draw-point" "���������� ����� � ����������� ���� ���� �� ������")
	    ("mnas-axis-point-to-screen" "������� ����� �� ��������� ���� ���� � ���������� ������")
	    ("mnas-axis-point-to-another-axis" "������� ����� �� ��������� ����� ���� ���� � ���������� ������ ���� ����.")
	    ("mnas-axis-point-value" "����������� �������� �� ����� �� �����")
	    ("mnas-axis-point-value-xy" "������� ���������� ���������� �����"))))

(princ "Loaded project axis.\n")