dcl_settings : default_dcl_settings { audit_level = 3; }

fors_gas : dialog
{
  aspect_ratio = 0;
  label = "Построение расходной характеристики газовой форсунки";
  initial_focus = "accept";
  
  : edit_box  {key ="fors_gas:f_fors";label= "Эффективная площадь форсунки, мм^2";}
  : edit_box  {key ="fors_gas:ro*dp_min";label= "Нач. знач. парам. ro*dp, (кг/м^3)*бар";}
  : edit_box  {key ="fors_gas:ro*dp_max";label= "Кон. знач. парам. ro*dp, (кг/м^3)*бар";}
  : edit_box  {key ="fors_gas:var_name";label= "Переменная для вывода точек графика";}
  : edit_box  {key ="fors_gas:n_div";label= "Количество делений";}
  : radio_column
  {
    : radio_button {label = "Пропорциональная шкала"; key = "fors_gas:fl_pr";}
    : radio_button {label = "Логарифмическая шкала"; key = "fors_gas:fl_log";}
  }
  ok_cancel_help;
  errtile;
}

fors_lic : dialog
{
  aspect_ratio = 0;
  label = "Построение расходной характеристики жидкостной форсунки";
  initial_focus = "accept";
  
  : edit_box  {key ="fors_lic:P_kontr";label= "Давление в контрольной точке P_kontr, [МПа]";}
  : edit_box  {key ="fors_lic:G_kontr";label= "Расход в контрольной точке G_kontr, [кг/ч]";}
  : edit_box  {key ="fors_lic:Ro_kontr";label= "Плотность топлива в контрольной точке Ro_kontr, (кг/м^3)";}
  : edit_box  {key ="fors_lic:Ro";label= "Плотность топлива при поливке Ro, (кг/м^3)";}
  : edit_box  {key ="fors_lic:dP_min";label= "Нач. знач. парам. dP_min, [МПа]";}
  : edit_box  {key ="fors_lic:dP_max";label= "Кон. знач. парам. dP_max, [МПа]";}
  : edit_box  {key ="fors_lic:var_name";label= "Переменная для вывода точек графика";}
  : edit_box  {key ="fors_lic:n_div";label= "Количество делений";}
  : radio_column
  {
    : radio_button {label = "Пропорциональная шкала"; key = "fors_lic:fl_pr";}
    : radio_button {label = "Логарифмическая шкала"; key = "fors_lic:fl_log";}
  }
  
  ok_cancel_help;
  errtile;
}