dcl_settings : default_dcl_settings { audit_level = 3; }

mnas_weld_main : dialog
{
	label = "Редактирование швов сварных";
	initial_focus = "top_text" ;
	: row
	{
		: column
		{
			: edit_box { key = "top_text"; label = "Обозначение"; }
			: edit_box { key = "bot_text"; label = "Категория и комплекс"; }
		}
		: column
		{
			: edit_box { key = "nomer"; label = "Номер"; }
			: edit_box { key = "kolichestvo"; label = "Кол-во"; }
		}
		: column
		{
			: popup_list { key = "dim_style"; label = "Стиль"; }
			: toggle  { key = "tgl_ob_side"; label = "С обратной стороны"; }
		}
	}
	: row
	{
		: boxed_column
		{
		label = "Обозначение, категория и комплекс";
			: row
			{
				: popup_list { key = "wedl_standard"; width=16;}
				: popup_list { key = "weld_type";}
				: popup_list { key = "weld_sposob";}
			}
			: row
			{
				: spacer {width=4; }
				: popup_list { key = "weld_kategory"; }
				: popup_list { key = "weld_kontrol_group";}
				: spacer {width=4; }
			}
		}
		: boxed_row
		{
			label="Катет";
			: toggle { key = "tgl_katet" ; }
			: image {aspect_ratio=1; width=8;  key = "img_katet";}
			: edit_box { key = "str_katet" ; }
		
		}
		: boxed_row
		{
			label="Прерывистый";
			: edit_box { key = "str_provar" ; }
			: column
			{
				: row
				{
					: toggle { key = "tgl_linear" ; }
					: text {label= "/";}
				}
				: row
				{
					: toggle { key = "tgl_shahm" ; }
					: text {label= "Z";}
				}
			}
			: edit_box { key = "str_provar_neprovar" ; }
		}
	}
	:row
	{
		: boxed_row
		{
		label="Вспомогательные знаки";
			: column
			{
				: row
				{
					: toggle { key = "tgl_close_contur" ; }
					: image {aspect_ratio=1; width=5; fixed_width= true; key = "img_close_contur";}
					: toggle { key = "tgl_open_contur" ; }
					: image {aspect_ratio=1; width=5; fixed_width= true; key = "img_open_contur";}
					: toggle { key = "tgl_usilenie_top" ; }
					: image {aspect_ratio=1; width=5; fixed_width= true; key = "img_usilenie_top";}
					: toggle { key = "tgl_plavn_top" ; }
					: image {aspect_ratio=1; width=5; fixed_width= true; key = "img_plavn_top";}
				}
				: row
				{
					: toggle { key = "tgl_montaz" ; }
					: image {aspect_ratio=1; width=5; fixed_width= true; key = "img_montaz";}
					: toggle { key = "tgl_usilenie_bot" ; }
					: image {aspect_ratio=1; width=5; fixed_width= true; key = "img_usilenie_bot";}
					: toggle { key = "tgl_plavn_bot" ; }
					: image {aspect_ratio=1; width=5; fixed_width= true; key = "img_plavn_bot";}
				}
			}
		
		}
		: boxed_row
		{
			label="Стрелка";
			: radio_column
			{
				: radio_button { key = "rb_clock" ; label = "По часовой"; }
				: radio_button { key = "rb_unclock" ; label = "Против часовой";}
			}
		}
		: boxed_row
		{
			label="Присоединение";
			: radio_column
			{

				: radio_button { key = "rb_prisoed_left" ; label = "Слева"; }
				: radio_button { key = "rb_prisoed_right" ; label = "Справа"; }
			}
		}
		: column
		{
			: button { label ="Default"; key = "default_settings" ; mnemonic = "D";}
			: button { label ="T home"; key = "text_home" ;}
			: button { label ="T color"; key = "text_color" ;}
			: button { label ="About"; key = "about" ; }
		}
	}
	: row
	{
		: button { label ="&Select"; key = "select" ; mnemonic = "S";}
		: button { label ="A&pply"; key = "apply_btn" ; mnemonic = "P";}
		ok_cancel;
	}
	errtile;
}

mnas_weld_setup : dialog
{
	label = "Редактирование швов сварных";
	initial_focus = "top_text" ;
	: edit_box { key = "m_PntTxtTop"; label = "m_PntTxtTop"; } // Координата y
	: edit_box { key = "m_PntTxtBot"; label = "m_PntTxtBot"; } // Координата y
	
	: edit_box { key = "m_AngArrowFront"; label = "m_AngArrowFront"; }
	: edit_box { key = "m_AngArrowBack"; label = "m_AngArrowBack"; }
	: edit_box { key = "m_LenAarrow"; label = "m_LenAarrow"; }
	: edit_box { key = "m_RadContourClosed"; label = "m_RadContourClosed"; }
	: edit_box { key = "m_TextSizeScale"; label = "m_TextSizeScale"; }
	
	ok_cancel;
	errtile;
}


mnas_weld_ch_text : dialog
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
  : edit_box
  {
    key = "dim_string_1";
    label = "Разм. текст:";
    edit_width = 60;
    fixed_width = true;
  }
  ok_cancel;
  errtile;
}
