dcl_settings : default_dcl_settings { audit_level = 3; }
dopprop : dialog
{label = "��������� ������� ��������"; aspect_ratio = 0;
: row
{
  : boxed_row
  { label="�����_�����";
  : toggle { key = "tgl_text_bef";}
  : edit_box{ key = "ed_text_bef"; width=12;}
  }
  : popup_list  { key = "pl_kvalitet";}
  : popup_list  { key = "pl_kv_val";}
  : boxed_row
  { label="�����_�����";
  : toggle { key = "tgl_text_past";}
  : edit_box { key = "ed_text_past"; width=12;}
  }
  : column
  {
    : boxed_row
    { label="+������";
    : toggle { key = "tgl_+dop";}
    : edit_box { key = "ed_+dop"; width=6;}
    }
    : boxed_row
    { label="-������";
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
{label = "������ �������� "; aspect_ratio = 0;
  : boxed_column
  { label ="��������";
  : toggle  { label="�����������"; key="tgl_kv_show";}
  : toggle  { label="��������"; key="tgl_kv_val";}
  : toggle  { label="� �������"; key="tgl_()";}
  }

  : edit_box{ label="������� ���������"; key = "ed_scale_kv";}
  : edit_box{ label="������� �������� ���������"; key = "ed_scale_val_kv";}
  : edit_box{ label="������� () ���������"; key = "ed_scale_()_kv";}
  : edit_box{ label="������� ()"; key = "ed_scale_()";}
  ok_cancel; errtile;
}

kv_setup_size : dialog
{label = "������ �������� "; aspect_ratio=0;
  : radio_row
  {
  : radio_button {key="rb_none"; label="������";}
  : radio_button {key="rb_kv"; label="��������";}
  : radio_button {key="rb_dop"; label="������";}
  }
  ok_cancel; errtile;
}
