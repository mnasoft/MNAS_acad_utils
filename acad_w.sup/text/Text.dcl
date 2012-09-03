dcl_settings : default_dcl_settings { audit_level = 3; }

chgtextt : dialog
{
  aspect_ratio = 0;
  label = "Change Text";
  is_bold = true;
  initial_focus = "dim_string";
  : edit_box
  {
    key = "dim_string";
    label = "Разм. текст:";
    edit_width = 60;
    fixed_width = true;
    allow_accept = true;
  }
  ok_cancel;
  errtile;
}


