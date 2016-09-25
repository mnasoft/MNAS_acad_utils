dcl_settings : default_dcl_settings { audit_level = 3; }

@include "../../acad.dcl/ok_cancel_help_info_errtile.dcl"

chgtextt : dialog
{
  aspect_ratio = 0;
  label = "Change Text";
  is_bold = true;
  initial_focus = "dim_string";
  :row
  {
    : boxed_column
    {
      label = "Add";
      :row
      {
        : button {key = "add-big-round-brackets"; label = "((<>))" ;}
        : button {key = "add-round-brackets"; label = "(<>)" ;}
      }
      :row
      {
        : button {key = "add-big-square-brackets"; label = "[[<>]]" ;}
        : button {key = "add-square-brackets"; label = "[<>]" ;} 
        
      }
    }
    : edit_box { key = "dim_string"; edit_width = 30; fixed_width = true; allow_accept = true; }
    : boxed_column 
    { 
      label = "Tol";
      : edit_box { key = "upper_tolerance"; edit_width = 5; fixed_width = true; allow_accept = true; }
      : edit_box { key = "lower_tolerance"; edit_width = 5; fixed_width = true; allow_accept = true; }
    }
    : boxed_column
    {
      label = "Delete";
      : button {key = "delete-round-brackets"; label = "(<>)" ;}
      : button {key = "delete-square-brackets"; label = "[<>]" ;}
    }
  }
  :row
  {
    : boxed_row
    {
    label = "Add";
    : button {key = "add-diameter-sign"; label = "Ø<>" ;}
    : button {key = "add-x45-degrees"; label = "<>x45°" ;}
    : button {key = "add-tolerance"; label = "+/-" ;}
    }
    : boxed_row
    {
    label = "Delete";
    : button {key = "delete-diameter-sign"; label = "Ø<>" ;}
    : button {key = "delete-x45-degrees"; label = "<>x45°" ;}
    }
  }
  ok_cancel_help_info_errtile;
}

