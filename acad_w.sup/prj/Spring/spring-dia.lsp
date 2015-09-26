(setq spring_1 '(("d_provoloka" 2.5)    ; Диаметр проволоки пружины, мм.
                 ("D_sredn" 24.5)       ; Средний диаметр пружины, мм.
                 ("l0_svobodn" 39.75)   ; Длина пружины в свободном состоянии.мм.
                 ("n_vitkov" 4.0)       ; Количество полных витков пружины.
                 ("G_sdviga" 76200.0)   ; Модуль Юнга второго рода, МПа.
                 ))
(setq setup_lst '(("wire_dia" "2.5")
                  ("spring_mid_dia" "24.5")
                  ("spring_length_wo_weighting" "39.75")
                  ("spring_full_coil_number" "4.0")
                  ("matirial_Ung_modulus_2type" "76200.0")
                  ("matirial_tau_dop" "1000.0")
                  ("L1" "33.0")
                  ("L2" "30.0")
                  ("L3" "27.0")
                  ("working_temperature" "20.0")))


(defun acad_sup_new  ()
  "D:\Developer\MNAS_acad_db17_utils"
  "C:\Program Files\MNASoft\MNAS_acad_utils")


(defun spring_dlg  ()
  (load_dcl "/prj/Spring/Spring.dcl")
  (setq do_dialog t)
  (while do_dialog
    (if (not (new_dialog "spring" dcl_id))
      (exit))
    (init_dlg setup_lst)
    (action-tile_dlg "setup_lst" "setup_lst") ;    (action_tile "dop_dlg_1" "(dop_ac_1 $value)")
                                        ;    (action_tile "dop_dlg_7" "(done_dialog 7)")
    (setq action (start_dialog))
    (cond ((= action 0)                 ;cancel
           (setq do_dialog nil))
          ((= action 1)                 ;ok
           (setq do_dialog nil))))
  (unload_dialog dcl_id)
  (princ))