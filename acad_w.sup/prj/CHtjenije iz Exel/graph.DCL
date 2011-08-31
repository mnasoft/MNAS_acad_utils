dcl_settings : default_dcl_settings { audit_level = 3;}

edit_box_35_10 : edit_box {fixed_width=true; width=35; edit_width=10;}
popup_list_14 : popup_list {fixed_width = true; edit_width=14;}

exelread : dialog
{
 fixed_width_font = true;
 label = "Чтение данных из таблицы Exel";
 : row 
 {
  : edit_box {key="xsl_file_name"; label="FileName";}
  : button {key="..."; label="..."; fixed_width=true; width=3;}
 }
 : row 
 {
  : button {key="open"; label="Open";}
  : button {key="read"; label="Read";}
  : button {key="close"; label="Close";}
 }
 : boxed_row
 {
  label="Read Sheet";
  : popup_list{key="sheets"; label="Sheets";}
  : button {key="bt_read"; label="Read";}
 }
 : boxed_column 
 {
  label="Reading Direction and Range";
  : radio_row
  {
   : radio_button{key="ByRow"; label="ByRow";}
   : radio_button{key="ByColumn"; label="ByColumn";}
  }
  : row 
  {
  : edit_box {key="start_cell"; label="Start Cell";}
  : edit_box {key="end_cell"; label="End Cell";}
  }
 }
 
 : edit_box {key="autolisp_name"; label="AutolispName";}
 
 ok_cancel;
 errtile;
}

шероховатость : dialog
{
 fixed_width_font = true;
 label = "Простановка шероховатостей (ГОСТ 2789-73)";
 aspect_ratio = 0;
 : boxed_row
 {
  label="Параметр и ряд";
  : radio_row
  {: radio_button {key="rb_1_Ra"; label="Ra";}
   : radio_button {key="rb_1_Rz"; label="Rz";}
  }
  : popup_list_14 {key ="pl_1_RaRz"; label="Ряд";}
 }
 :  boxed_column
 {label="Значение параметра";
  : row
  {: toggle{key="tgl_1_max_val";}
   : edit_box_35_10 {label="Максимальное"; key="eb_1_max_val";}
   : popup_list_14 {key ="pl_1_max_val"; }
  }
  : row
  {: toggle{key="tgl_1_min_val";}
   : edit_box_35_10 {label="Минимальное"; key="eb_1_min_val";}
   : popup_list_14 {key ="pl_1_min_val"; }
  }
  : row
  {: toggle{key="tgl_1_spos_pol";}
   : edit_box_35_10 {label="Способ получения"; key="eb_1_spos_pol";}
   : popup_list_14 {key ="pl_1_spos_pol";}
  }
 }
 : row
 {
 : boxed_radio_column
  {label="Снятие осн. м-ла";
   : radio_button   { key="rb_1_osn_ml_sn";label="Есть";}
   : radio_button   { key="rb_1_osn_ml_nesn";label="Нет";}
   : radio_button   { key="rb_1_osn_ml_neobr";label="Необработка";}
  }
 : boxed_radio_column
 {label="Скобки вокруг ";
  : radio_button {key="rb_1_bez_sk"; label="Без  скобок";}
  : radio_button {key="rb_1_kr_sk"; label="Круглые ()";}
  : radio_button {key="rb_1_kv_sk"; label="Квадратные []";}
  }
 }
 : row
 {: boxed_column
  {: toggle{key="tgl_1_po_konturu"; label="По контуру"; }
   : toggle{key="tgl_1_perevern"; label="Перевернутый";}
  }
  : boxed_row
  {label="Напр. неровностей";
   : toggle{key="tgl_1_napr_miko_ner"; }
   : popup_list {key ="pl_1_napr_miko_ner"; }
  }
 }
 : boxed_row
 {label="Масштаб";
 : edit_box {key="eb_1_masht";}
 : button {key="bt_1_masht"; label="По разм.стилю";}
 : popup_list {key ="pl_1_masht"; }
 }
 : row
 {: button {key="bt_1_1"; label="Проставить";}
  : button {key="bt_1_2"; label="Выбрать";}
  : button {key="bt_1_3"; label="Обновить";}
 }
 ok_cancel;
 errtile;
}




