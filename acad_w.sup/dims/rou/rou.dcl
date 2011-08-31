dcl_settings : default_dcl_settings { audit_level = 3; }

шероховатость_bak : dialog
{
 label = "Простановка шероховатостей";
 aspect_ratio = 0;
 : column
 {
  : radio_row
  {  
   : radio_button
   { key="rb_1_7"; label="Ra";}
   : radio_button
   { key="rb_1_8"; label="Rz";}
  }
  : row
  {
   : toggle{key="tgl_1_11";}
   : edit_box   {label="Значение";fixed_width = true ;edit_width = 20; width = 36; key="eb_1_1";}
   : popup_list {key ="pl_1_1"; fixed_width = true ; width = 20;}
  } 
  
  : row
  {
   : toggle{key="tgl_1_12";}
   : edit_box {label="Способ получения";fixed_width = true ;edit_width = 20; width = 36; key="eb_1_2";}
   : popup_list {key ="pl_1_2"; fixed_width = true ;width = 20; }
  }
  : edit_box {label="Масштаб";key="eb_1_3";}
 }
 : row
 {
  : radio_column
  {  
   boxed=true;
   : radio_button   { key="rb_1_1";label="Со снятием м-ла";}
   : radio_button   { key="rb_1_2";label="Без снятия м-ла";}
   : radio_button   { key="rb_1_3";label="Необработка";}
  }
  : column
  {
   boxed=true;
  	: radio_column
  	{
  	: radio_button {key="rb_1_4"; label="Без скобках";}
  	: radio_button {key="rb_1_5"; label="В круглых скобках";}
  	: radio_button {key="rb_1_6"; label="В квадратных скобках";}
	}
   : toggle{key="tgl_1_2"; label="По контуру";}
   : toggle{key="tgl_1_3"; label="Перевернутый";}
  }
  : list_box {key="ppl_1_3";label="Тип микр."; height=4; width=12;}
 }
 : row
 {
  : button {key="bt_1_1"; label="Проставить";}
  : button {key="bt_1_2"; label="Выбрать";}
  : button {key="bt_1_3"; label="Обновить";}
 }
 ok_cancel;
 errtile;
}

edit_box_35_10 : edit_box {fixed_width=true; width=35; edit_width=10;}

popup_list_14 : popup_list {fixed_width = true; edit_width=14;}

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




/*
image_gold : image
{
 height=10;
 aspect_ratio=1.62;
 fiexd_width=true;
 fixed_height=true;
 color=0;
}
*/

/*
test_window: dialog
{
 label="Окно тестирования";
 :row
 {
  : image_gold
  { key="i_3_1";}
  : column
  {
   : button
   { key="b_3_1";
    label="Выбрать объекты";
   }
   : button
   { key="b_3_2";
    label="Отрисовать";
   }
  }
 }
 ok_only;
}
*/