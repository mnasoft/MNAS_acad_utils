dcl_settings : default_dcl_settings { audit_level = 3; }
dopprop : dialog
{label = "Изменение свойств объектов"; aspect_ratio = 0;
: row
{
  : boxed_row
  { label="текст_перед";
  : toggle { key = "tgl_text_bef";}
  : edit_box{ key = "ed_text_bef"; width=12;}
  }
  : popup_list  { key = "pl_kvalitet";}
  : popup_list  { key = "pl_kv_val";}
  : boxed_row
  { label="текст_после";
  : toggle { key = "tgl_text_past";}
  : edit_box { key = "ed_text_past"; width=12;}
  }
  : column
  {
    : boxed_row
    { label="+допуск";
    : toggle { key = "tgl_+dop";}
    : edit_box { key = "ed_+dop"; width=6;}
    }
    : boxed_row
    { label="-допуск";
    : toggle { key = "tgl_-dop";}
    : edit_box { key = "ed_-dop"; width=6;}
    }
  }
}  
  : edit_box{ key = "ed_dia";label ="ed_dia";width=3;}
  : edit_box{ key = "ed_text";label ="text_befor";width=12;}
  ok_cancel; errtile;
}

dop_setup_size : dialog
{label = "Размер символов "; aspect_ratio = 0;
  : boxed_column
  { label ="Квалитет";
  : toggle  { label="Обозначение"; key="tgl_kv_show";}
  : toggle  { label="Значение"; key="tgl_kv_val";}
  : toggle  { label="В скобках"; key="tgl_()";}
  }

  : edit_box{ label="Масштаб квалитета"; key = "ed_scale_kv";}
  : edit_box{ label="Масштаб значения квалитета"; key = "ed_scale_val_kv";}
  : edit_box{ label="Масштаб () квалитета"; key = "ed_scale_()_kv";}
  : edit_box{ label="Масштаб ()"; key = "ed_scale_()";}
  ok_cancel; errtile;
}

kv_setup_size : dialog
{label = "Размер символов "; aspect_ratio=0;
  : radio_row
  {
  : radio_button {key="rb_none"; label="Ничего";}
  : radio_button {key="rb_kv"; label="Квалитет";}
  : radio_button {key="rb_dop"; label="Допуск";}
  }
  ok_cancel; errtile;
}
