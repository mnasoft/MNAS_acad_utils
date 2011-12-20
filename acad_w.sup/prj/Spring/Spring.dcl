dcl_settings : default_dcl_settings { audit_level = 3; }

spring : dialog
{
  aspect_ratio = 0;
  label = "Расчет цилиндричекой пружины сжатия";
  initial_focus = "accept";
  : boxed_column
  {
    label = "Геометрические характеристики пружины";
    : edit_box  {key ="wire_dia";label= "Диаметр проволоки пружины, мм"; }
    : edit_box  {key ="spring_mid_dia";label= "Средний диаметр пружины, мм"; }
    : edit_box  {key ="spring_length_wo_weighting";label= "Длина пружины в свободном состоянии, мм"; }
    : edit_box  {key ="spring_full_coil_number";label= "Длина пружины в свободном состоянии, мм"; }
  }
  : boxed_column
  {
    label = "Характеристики материала";
    : edit_box  {key ="matirial_Ung_modulus_2type";label= "Модуль Юнга второго рода, МПа"; }
    : edit_box  {key ="matirial_tau_dop";label= "Допустимые напряжения при кручении, МПа"; }
  }
  : boxed_column
  {
     label = "Рабочие условия";
     : edit_box  {key ="L1"; label= "L1, мм"; }
     : edit_box  {key ="L2"; label= "L2, мм"; }
     : edit_box  {key ="L3"; label= "L3, мм"; }
     : edit_box  {key ="working_temperature";label= "Рабочая температура, град. Ц"; }
  }
  : row
  { ok_cancel_help;
    : button  {key = "about"; label = "О программе"; }
  }
  errtile;
}