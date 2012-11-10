dcl_settings : default_dcl_settings { audit_level = 3; }

line_concat : dialog
{
  label = "Line Concatenation Filter";
  aspect_ratio = 0;
  : boxed_column
  {
  label="Join lines thay ... same";
    : toggle { key = "tgl_Layer" ; label = "Layer"; }
    : toggle { key = "tgl_TrueColor" ; label = "TrueColor";}
    : toggle { key = "tgl_LineType" ; label = "LineType";}
  }
  ok_cancel_help_errtile; 
}