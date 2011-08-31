dcl_settings : default_dcl_settings { audit_level = 3; }

rgb : dialog
{
label = "Изменение свойств объектов";aspect_ratio = 0;
//: button { key ="b_1_1";label= "Сохранить настройки";}
: toggle { key = "t_1_1"; label= "Все слои";}
: boxed_radio_column
  {
   : radio_button
   { key="rb_1_1"  ;label="Схема 1 (5  цветов)"; }
   : radio_button
   { key="rb_1_2"  ;label="Схема 2 (14 цветов)"; }
  }
  : edit_box { key = "eb_1_1"; label="Шаблон исключений"; allow_accept = true;}
  : edit_box { key = "eb_1_2"; label="начальный номер"; allow_accept = true;}
  : edit_box { key = "eb_1_3"; label="перемешивание"; allow_accept = true;}
  ok_cancel_help_errtile; 
}