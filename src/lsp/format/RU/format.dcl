dcl_settings : default_dcl_settings { audit_level = 3; }

ok_cancel_help_info_errtile : column { ok_cancel_help_info; errtile; }

form : dialog
{
  label = "Выбор формата";
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
      { label = "Кратность";
        : list_box { key = "kr_list"; }
        : text { key = "kr_edit"; width = 5; }
		  }
  	}
  }
  : boxed_radio_row
  { label = "Расположение вдоль стороны";
    : radio_button {label ="длинной"; key = "long_side"; is_tab_stop = false; }
    : radio_button {label ="короткой";key = "short_side";is_tab_stop = false; }
  }
  : cluster{: boxed_row {label = "Размер "; : text { key="razmer"; width = 5;}}}
  ok_cancel;
  errtile;
}

sht1 : dialog
{
	aspect_ratio = 0;
	label = "Заполнение штампа";
	: column
	{
		: boxed_column
		{
	 		label = "Основная графа";
      : edit_box { key = "sht1_1"; label = "Наименование"; }
      : edit_box { key = "sht1_2"; label = "Обозначение "; }
      : edit_box { key = "sht1_3"; label = "Материал    "; }
		}
		: boxed_row
		{
			label = "Справ No и Перв. прим.";
      : edit_box { key = "sht1_24"; label = "Справ No"; }
      : edit_box { key = "sht1_25"; label = "Перв. прим."; }
		}
		: row
		{
			: boxed_column
			{
				label = "Исполнители";
        : edit_box { key = "sht1_11_1"; label = "Разраб. "; width = 20; }
        : edit_box { key = "sht1_11_2"; label = "Провер. "; width = 20; }
        : edit_box { key = "sht1_11_3"; label = "Т.контр."; width = 20; }
				: row
				{
          : edit_box { key = "sht1_10"; width = 8; }
          : edit_box { key = "sht1_11_4"; width = 12; }
				}
        : edit_box { key = "sht1_11_5"; label = "Н.контр."; }
        : edit_box { key = "sht1_11_6"; label = "Утвердил"; }
			}
			: boxed_column
      { label = "Прочие графы";
				: boxed_row
        { label = "Литера";
          : edit_box { key = "sht1_4_1"; width=5; fixed_width = true; }
          : edit_box { key = "sht1_4_2"; width=5; fixed_width = true; }
          : edit_box { key = "sht1_4_3"; width=5; fixed_width = true; }
				}
				: row
				{
          : edit_box { key = "sht1_5"; label = "Масса"; }
          : edit_box { key = "sht1_6"; label = "Масшт"; }
				}
				: boxed_row
				{
          : edit_box { key = "sht1_7"; label = "Лист"; }
          : edit_box { key = "sht1_8"; label = "Листов";}
				}
        : edit_box { key = "sht1_9"; label = "Индекс предпр."; }
			}
		}
	}
	ok_cancel;
	errtile;
}

forma : dialog
{
  aspect_ratio = 0;
  label = "Выбор основной надписи";
  : boxed_column
  {
    label = "Форма - для чего прим.    | лист";
    : list_box { key = "f_list"; width = 40; }
  }
  ok_cancel;
  errtile;
}

dop_dlg : dialog
{
  aspect_ratio = 0;
  label = "Выбор дополнительных штампов";
  : row
  {
    : boxed_column
    { label = "Выбраны";
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
    { label = "Имеются в наличии";
      : list_box { key = "dop_dlg_1"; width = 20; }
    }
  }
  :row
  {
    : button { label ="Добавить"; key = "dop_dlg_5"; }
    : button { label ="Удалить"; key = "dop_dlg_6"; }
    : button { label ="Редактировать"; key = "dop_dlg_7"; }
  }
  ok_cancel;
  errtile;
}

add_dop_sht_dlg : dialog
{
	aspect_ratio = 0;
	label = "Выбор дополнительных штампов";
  : edit_box { key = "add_dop_sht_dlg_1"; label = "Имя штампа"; }
  : edit_box { key = "add_dop_sht_dlg_2"; label = "Имя файла"; }
  : radio_column
  {
    : radio_button {label = "Право_низ"; key = "add_dop_sht_dlg_3";}
    : radio_button {label = "Право_верх"; key = "add_dop_sht_dlg_4";}
    : radio_button {label = "Лево_верх"; key = "add_dop_sht_dlg_5";}
    : radio_button {label = "Лево_низ"; key = "add_dop_sht_dlg_6";}
  }
	ok_cancel;
	errtile;
}

sht_main : dialog
{
  aspect_ratio = 0;
  label = "Заполнение штампа";
  : row
  {
    : column
    {
    : row
    {
    : boxed_column
    {
      label = "Формат и кратность";
    :text { key = "format_text"; width = 25; }
          :text { key = "dir_sht"; width = 5; }
          : button { label = "Выбор формта..."; mnemonic = "B"; key = "format"; }
				}
				: column
				{

				: button
          { key = "ed_1"; label = "Заполнение..."; }
          : button { key = "ed_3"; label = "Сохранить настр."; }
          : button { key = "ed_4"; label = "Выбрать"; }
				}
			}
			: boxed_row
      { label = "Деление на зоны";
				: radio_column
					{
            : radio_button { label ="Есть"; key = "Dz_y"; is_tab_stop = false; }
            : radio_button { label ="Нет "; key = "Dz_n"; is_tab_stop = false; }
				}
				: column
				{
          : edit_box { key = "z_1"; label = "Нач. цифра"; }
          : edit_box { key = "z_A"; label = "Нач. буква"; }
				}
			}
      : boxed_column
      { label = "Номер формы (тип штампа)";
        : popup_list {label = "";
          tabs = "5 22 45"; 
          key = "sht_list";}
      }
      : boxed_row
      { label = "Начало штампа";
        : button { label = "Указание..."; key = "pick"; }
        : edit_box { key = "X0"; label = "X="; }
        : edit_box { key = "Y0"; label = "Y="; }
			}
		}
		: boxed_column
    { label = "Дополнительные графы";
      : list_box { key = "dop_list"; }
      : button { key = "dop_edit"; label = "Редактирование..."; }
		}
	}
  : row
  {
    : button { label ="Заполнить"; key = "for_zap";}
    ok_cancel_help_info_errtile;
  }
  
}