;;;;;;("sl_on" "��������� ����� �� �������." "����")
(defun c:sl_on  (/ str)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq str (getstring (strcat "�������� ���� <" la_shabl_on_off ">:")))
  (command-s "_.-layer"
           "_on"
           (if (= "" str)
             la_shabl_on_off
             (setq la_shabl_on_off str)))
  (if_cmd_active)
  (err-handle ""))

;;;;;;("sl_off" "���������� ����� �� �������." "����")
(defun c:sl_off  (/ str)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq str (getstring (strcat "��������� ���� <" la_shabl_on_off ">:")))
  (command-s "_.-layer"
           "_off"
           (if (= "" str)
             la_shabl_on_off
             (setq la_shabl_on_off str)))
  (if_cmd_active)
  (err-handle ""))

;;;;;;("sl_th" "�������������� ����� �� �������." "����")
(defun c:sl_th  (/ str)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq str (getstring (strcat "����������� ���� <" la_shabl_th_fr ">:")))
  (command-s "_.-layer"
           "_thaw"
           (if (= "" str)
             la_shabl_th_fr
             (setq la_shabl_th_fr str)))
  (if_cmd_active)
  (err-handle ""))

;;;;;;("sl_fr" "������������� ����� �� �������." "����")
(defun c:sl_fr  (/ str)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq str (getstring (strcat "���������� ���� <" la_shabl_th_fr ">:")))
  (command-s "_.-layer"
           "_freeze"
           (if (= "" str)
             la_shabl_th_fr
             (setq la_shabl_th_fr str)))
  (if_cmd_active)
  (err-handle ""))

;;;;;;("sl_lo" "���������� ����� �� �������." "����")
(defun c:sl_lo  (/ str)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq str (getstring (strcat "����������� ���� <" la_shabl_lo_un ">:")))
  (command-s "_.-layer"
           "_lock"
           (if (= "" str)
             la_shabl_lo_un
             (setq la_shabl_lo_un str)))
  (if_cmd_active)
  (err-handle ""))

;;;;;;("sl_un" "���������� ����� �� �������." "����")
(defun c:sl_un  (/ str)
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (setq str (getstring (strcat "�������������� ���� <" la_shabl_lo_un ">:")))
  (command-s "_.-layer"
           "_unlock"
           (if (= "" srt)
             la_shabl_lo_un
             (setq la_shabl_lo_un str)))
  (if_cmd_active)
  (err-handle ""))

;;;;;;("svl_th" "�������������� ����� �� ������� ��� ������� ����� ���������." "����")
(defun c:svl_th  ()
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (if (= 1 (getvar "tilemode"))
    (setvar "tilemode" 0))
  (command-s "_mspace")
  (if_cmd_active)
  (command-s "_vplayer"
           "_thaw"
           (if (= "" (setq str (getstring (strcat "������������ ���� <" vp_la_shabl_th_fr ">:"))))
             vp_la_shabl_th_fr
             (setq vp_la_shabl_th_fr str)))
  (if_cmd_active)
  (err-handle ""))

;;;;;;("svl_fr" "������������� ����� �� ������� ��� ������� ����� ���������." "����")
(defun c:svl_fr  ()
  (err-init '("cmdecho"))
  (set-sys-var-lst '(("cmdecho" 0)))
  (if (= 1 (getvar "tilemode"))
    (setvar "tilemode" 0))
  (command-s "_mspace")
  (if_cmd_active)
  (command-s "_vplayer"
           "_freeze"
           (if (= "" (setq str (getstring (strcat "������������ ���� <" vp_la_shabl_th_fr ">:"))))
             vp_la_shabl_th_fr
             (setq vp_la_shabl_th_fr str)))
  (if_cmd_active)
  (err-handle ""))

(setq la_shabl_on_off "*_d"
      la_shabl_th_fr "*_d"
      la_shabl_lo_un "*_d"
      vp_la_shabl_th_fr "*_d")
