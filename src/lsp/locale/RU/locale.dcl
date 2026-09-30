dcl_settings : default_dcl_settings { audit_level = 3;}

utils_locale : dialog
{ label = "Выбор локали";
  : boxed_radio_column
  { : radio_button { key = "rb_ru"; label = "Русский";}
    : radio_button { key = "rb_uk"; label = "Українська";}
    : radio_button { key = "rb_en"; label = "English";}}
  : row
  { ok_button;
    : spacer { width = 2;}
    info_button;}}
