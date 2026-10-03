dcl_settings : default_dcl_settings { audit_level = 3;}

edit_box_35_10 : edit_box {fixed_width=true; width=35; edit_width=10;}

popup_list_14 : popup_list {fixed_width = true; edit_width=14;}

roughness : dialog
{ fixed_width_font = true;
  label = "Surface roughness notation (GOST 2789-73)";
  aspect_ratio = 0;
  : boxed_row
  { label="Parameter and series";
    : radio_row
    { : radio_button {key="rb_1_Ra"; label="Ra";}
      : radio_button {key="rb_1_Rz"; label="Rz";}}
    : popup_list_14 {key ="pl_1_RaRz"; label="Series";}}
  : boxed_column
  { label="Parameter value";
    : row
    {: toggle{key="tgl_1_max_val";}
     : edit_box_35_10 {label="Maximum"; key="eb_1_max_val";}
     : popup_list_14 {key ="pl_1_max_val";}}
  : row
  {: toggle{key="tgl_1_min_val";}
   : edit_box_35_10
   { label="Minimum"; key="eb_1_min_val";}
   : popup_list_14 {key ="pl_1_min_val";}}
  : row
  {: toggle{key="tgl_1_spos_pol";}
   : edit_box_35_10 {label="Method of obtaining"; key="eb_1_spos_pol";}
   : popup_list_14 {key ="pl_1_spos_pol";}}}
  : row
  { : boxed_radio_column
    { label="Removal of base material";
      : radio_button   { key="rb_1_osn_ml_sn";label="Yes";}
      : radio_button   { key="rb_1_osn_ml_nesn";label="No";}
      : radio_button   { key="rb_1_osn_ml_neobr";label="No processing";}}
    : boxed_radio_column
    { label="Brackets around";
      : radio_button {key="rb_1_bez_sk"; label="No brackets";}
      : radio_button {key="rb_1_kr_sk"; label="Round ()";}
      : radio_button {key="rb_1_kv_sk"; label="Square []";}}}
  : row
  { : boxed_column
    { : toggle{key="tgl_1_po_konturu"; label="Along contour";}
      : toggle{key="tgl_1_perevern"; label="Upside down";}}
    : boxed_row
    { label="Irregularity direction";
      : toggle{key="tgl_1_napr_miko_ner";}
      : popup_list {key ="pl_1_napr_miko_ner";}}}
  : boxed_row
  { label="Scale";
    : edit_box {key="eb_1_masht";}
    : button {key="bt_1_masht"; label="By dim style";}
    : popup_list {key ="pl_1_masht";}}
    : row
    { : button {key="bt_1_1"; label="Apply";}
      : button {key="bt_1_2"; label="Select";}
      : button {key="bt_1_3"; label="Refresh";}}
  ok_cancel_help;
  errtile;}
