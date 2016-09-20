dcl_settings : default_dcl_settings { audit_level = 3; }

mnas_pos_main : dialog
{
	label = "Редактирование позиций";
	initial_focus = "text" ;
	: row
	{
		: toggle { key = "text_toggle"; }
		: edit_box { key = "text"; label = "Te&xt"; mnemonic = "X";}
	}
	: row
	{
		: toggle { key = "arrow_type_toggle"; }
		: popup_list { key = "arrow_type"; label = "Arro&w"; mnemonic = "W";}
	}
	: row
	{
		: toggle { key = "dim_style_toggle"; }
		: popup_list { key = "dim_style"; label ="Dim-st&yle"; mnemonic = "Y";}
	}
	: row
	{
		: toggle { key = "text_color_toggle"; }
		: image_button {aspect_ratio=1; width=1;  key = "text_color_image";} 
		: button { key = "text_color"; label ="Text color..."; fixed_width = true;}
	}
	: row
	{
		: toggle { key = "text-scale_toggle" ; }
		: column
		{
		: edit_box { key = "text-scale" ; label = "Text-scale";}
		: edit_box { key = "text-size" ; label = "Text-size";}
		}
		: column
		{
		: button { label ="&+"; key = "text_scale_+" ; mnemonic = "+";}
		: button { label ="&-"; key = "text_scale_-" ; mnemonic = "-";}
		}
	}
	: row
	{
		: toggle { key = "line-offset_toggle"; }
		: edit_box { key = "line-offset"; label = "Line-offset"; }
	}
	: boxed_row
	{
	label = "All Math Prop";
		: button { label ="&Mapply"; key = "match_apply"; mnemonic = "M";}
		: button { label ="&On"; key = "match_all_on" ; mnemonic = "O";}
		: button { label ="Of&f"; key = "match_all_off" ; mnemonic = "f";}
	}
	: row
	{
		: button { label ="&Select"; key = "select" ; mnemonic = "S";}
		: button { label ="A&pply"; key = "apply_btn" ; mnemonic = "P";}
		: button { label ="Default"; key = "default_settings" ; mnemonic = "D";}
	}
	: row
	{
		ok_cancel;
		: button { label ="About"; key = "about" ; }}
	errtile;
}
