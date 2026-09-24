dcl_settings : default_dcl_settings { audit_level = 3; }

ok_cancel_help_info_errtile : column { ok_cancel_help_info; errtile; }

form : dialog
{
  label = "Вибір формату";
  aspect_ratio = 0;
  : row
  {
	  : cluster
    { : boxed_column
      { label = "Формат";
        : list_box { key = "for_list"; }
        : text { key = "for_edit"; width = 5; fixed_width = true; }
			}
		}
		: cluster
    { : boxed_column
      { label = "Кратність";
        : list_box { key = "kr_list"; }
        : text { key = "kr_edit"; width = 5; }
		  }
  	}
  }
  : boxed_radio_row
  { label = "Розташування";
    : radio_button {label ="Альбомне"; key = "long_side"; is_tab_stop = false; }
    : radio_button {label ="Портретне";key = "short_side";is_tab_stop = false; }
  }
  : cluster{: boxed_row {label = "Розмір "; : text { key="razmer"; width = 5;}}}
  ok_cancel;
  errtile;
}

sht1 : dialog
{
	aspect_ratio = 0;
	label = "Заповнення штампу";
	: column
	{
		: boxed_column
		{
	 		label = "Основна графа";
      : edit_box { key = "sht1_1"; label = "Найменування"; }
      : edit_box { key = "sht1_2"; label = "Познака "; }
      : edit_box { key = "sht1_3"; label = "Матеріал    "; }
		}
		: boxed_row
		{
			label = "Довід. № та Перв. застос.";
      : edit_box { key = "sht1_24"; label = "Довід. №"; }
      : edit_box { key = "sht1_25"; label = "Перв. застос."; }
		}
		: row
		{
			: boxed_column
			{
				label = "Виконавці";
        : edit_box { key = "sht1_11_1"; label = "Розроб."; width = 20; }
        : edit_box { key = "sht1_11_2"; label = "Перев."; width = 20; }
        : edit_box { key = "sht1_11_3"; label = "Т.контр."; width = 20; }
				: row
				{
          : edit_box { key = "sht1_10"; width = 8; }
          : edit_box { key = "sht1_11_4"; width = 12; }
				}
        : edit_box { key = "sht1_11_5"; label = "Н.контр."; }
        : edit_box { key = "sht1_11_6"; label = "Затвердив"; }
			}
			: boxed_column
      { label = "Інші графи";
				: boxed_row
        { label = "Літера";
          : edit_box { key = "sht1_4_1"; width=5; fixed_width = true; }
          : edit_box { key = "sht1_4_2"; width=5; fixed_width = true; }
          : edit_box { key = "sht1_4_3"; width=5; fixed_width = true; }
				}
				: row
				{
          : edit_box { key = "sht1_5"; label = "Маса"; }
          : edit_box { key = "sht1_6"; label = "Масшт."; }
				}
				: boxed_row
				{
          : edit_box { key = "sht1_7"; label = "Аркуш"; }
          : edit_box { key = "sht1_8"; label = "Аркушів";}
				}
        : edit_box { key = "sht1_9"; label = "Індекс підприємства"; }
			}
		}
	}
	ok_cancel;
	errtile;
}

forma : dialog
{
  aspect_ratio = 0;
  label = "Вибір основного надпису";
  : boxed_column
  {
    label = "Форма - для чого прим.    | аркуш";
    : list_box { key = "f_list"; width = 40; }
  }
  ok_cancel;
  errtile;
}

dop_dlg : dialog
{
  aspect_ratio = 0;
  label = "Вибір додаткових штампів";
  : row
  {
    : boxed_column
    { label = "Вибрані";
    : list_box { key = "dop_dlg_2"; width = 20; }
    }
    : column
    {
      spacer_1;
      : button { label ="<"; key = "dop_dlg_3"; }
      : button { label =">"; key = "dop_dlg_4"; }
      spacer_1;    
    }
    : boxed_column
    { label = "Наявні";
      : list_box { key = "dop_dlg_1"; width = 20; }
    }
  }
  :row
  {
    : button { label ="Додати"; key = "dop_dlg_5"; }
    : button { label ="Видалити"; key = "dop_dlg_6"; }
    : button { label ="Редагувати"; key = "dop_dlg_7"; }
  }
  ok_cancel;
  errtile;
}

add_dop_sht_dlg : dialog
{
	aspect_ratio = 0;
	label = "Вибір додаткових штампів";
  : edit_box { key = "add_dop_sht_dlg_1"; label = "Ім'я штампа"; }
  : edit_box { key = "add_dop_sht_dlg_2"; label = "Ім'я файлу"; }
  : radio_column
  {
    : radio_button {label = "Правий нижній"; key = "add_dop_sht_dlg_3";}
    : radio_button {label = "Правий верхній"; key = "add_dop_sht_dlg_4";}
    : radio_button {label = "Лівий верхній"; key = "add_dop_sht_dlg_5";}
    : radio_button {label = "Лівий нижній"; key = "add_dop_sht_dlg_6";}
  }
	ok_cancel;
	errtile;
}

sht_main : dialog
{
  aspect_ratio = 0;
  label = "Заповнення штампу";
  : row
  {
    : column
    {
    : row
    {
    : boxed_column
    {
      label = "Формат і кратність";
    :text { key = "format_text"; width = 25; }
          :text { key = "dir_sht"; width = 5; }
          : button { label = "Вибір формату..."; mnemonic = "B"; key = "format"; }
				}
				: column
				{

				: button
          { key = "ed_1"; label = "Заповнення..."; }
          : button { key = "ed_3"; label = "Зберегти налашт."; }
          : button { key = "ed_4"; label = "Вибрати"; }
				}
			}
			: boxed_row
      { label = "Поділ на зони";
				: radio_column
					{
            : radio_button { label ="Є"; key = "Dz_y"; is_tab_stop = false; }
            : radio_button { label ="Нема"; key = "Dz_n"; is_tab_stop = false; }
				}
				: column
				{
          : edit_box { key = "z_1"; label = "Поч. цифра"; }
          : edit_box { key = "z_A"; label = "Поч. буква"; }
				}
			}
      : boxed_column
      { label = "Номер форми (тип штампа)";
        : popup_list {label = "";
          tabs = "5 22 45"; 
          key = "sht_list";}
      }
      : boxed_row
      { label = "Лівий нижній кут формату";
        : button { label = "Вказати..."; key = "pick"; }
        : edit_box { key = "X0"; label = "X="; }
        : edit_box { key = "Y0"; label = "Y="; }
			}
		}
		: boxed_column
    { label = "Додаткові графи";
      : list_box { key = "dop_list"; }
      : button { key = "dop_edit"; label = "Редагування..."; }
		}
	}
  : row
  {
    : button { label ="Заповнити"; key = "for_zap";}
    ok_cancel_help_info_errtile;
  }
  
}