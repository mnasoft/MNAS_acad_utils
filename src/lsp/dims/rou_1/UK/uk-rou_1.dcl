dcl_settings : default_dcl_settings { audit_level = 3;}

edit_box_35_10 : edit_box {fixed_width=true; width=35; edit_width=10;}

popup_list_14 : popup_list {fixed_width = true; edit_width=14;}

roughness : dialog
{ fixed_width_font = true;
  label = "Проставлення шорсткостей (ГОСТ 2789-73)";
  aspect_ratio = 0;
  : boxed_row
  { label="Параметр і ряд";
    : radio_row
    { : radio_button {key="rb_1_Ra"; label="Ra";}
      : radio_button {key="rb_1_Rz"; label="Rz";}}
    : popup_list_14 {key ="pl_1_RaRz"; label="Ряд";}}
  : boxed_column
  { label="Значення параметра";
    : row
    {: toggle{key="tgl_1_max_val";}
     : edit_box_35_10 {label="Максимальне"; key="eb_1_max_val";}
     : popup_list_14 {key ="pl_1_max_val";}}
  : row
  {: toggle{key="tgl_1_min_val";}
   : edit_box_35_10
   { label="Мінімальне"; key="eb_1_min_val";}
   : popup_list_14 {key ="pl_1_min_val";}}
  : row
  {: toggle{key="tgl_1_spos_pol";}
   : edit_box_35_10 {label="Спосіб отримання"; key="eb_1_spos_pol";}
   : popup_list_14 {key ="pl_1_spos_pol";}}}
  : row
  { : boxed_radio_column
    { label="Зняття осн. м-ла";
      : radio_button   { key="rb_1_osn_ml_sn";label="Так";}
      : radio_button   { key="rb_1_osn_ml_nesn";label="Ні";}
      : radio_button   { key="rb_1_osn_ml_neobr";label="Необробка";}}
    : boxed_radio_column
    { label="Дужки навколо";
      : radio_button {key="rb_1_bez_sk"; label="Без дужок";}
      : radio_button {key="rb_1_kr_sk"; label="Круглі ()";}
      : radio_button {key="rb_1_kv_sk"; label="Квадратні []";}}}
  : row
  { : boxed_column
    { : toggle{key="tgl_1_po_konturu"; label="За контуром";}
      : toggle{key="tgl_1_perevern"; label="Перевернутий";}}
    : boxed_row
    { label="Напр. нерівностей";
      : toggle{key="tgl_1_napr_miko_ner";}
      : popup_list {key ="pl_1_napr_miko_ner";}}}
  : boxed_row
  { label="Масштаб";
    : edit_box {key="eb_1_masht";}
    : button {key="bt_1_masht"; label="За розм. стилем";}
    : popup_list {key ="pl_1_masht";}}
    : row
    { : button {key="bt_1_1"; label="Проставити";}
      : button {key="bt_1_2"; label="Вибрати";}
      : button {key="bt_1_3"; label="Оновити";}}
  ok_cancel_help;
  errtile;}
