dcl_settings : default_dcl_settings { audit_level = 3; }

dchprop : dialog
{	label = "Изменение свойств объектов";aspect_ratio = 0;
	: row
	{
		: button { key ="a1";label= "Выбор объектов";width=20;}
		: button { key="a16";label="Установить свойства";width=20;}
	}
	: boxed_row
	{ : column
		{ : row
			{ : toggle {key = "a7";}
				: button { key = "a4";label ="Слой"; width=12; }
				: edit_box { key = "a10";width=15;}
			}
			: row
			{ : toggle { key = "a8";}
				: button { key = "a5";label = "Тип линии";width=12;}
				: edit_box { key = "a11"; width=15;}
			}
			: row
			{	: toggle { key = "a9";}
				: button { key = "a6";label ="Цвет";width=12;}
				: edit_box { key = "a12";width=15;}
			}
		}
		: column
		{ : button { key = "a13";label = "По объекту";width=15;}
			: button { key = "a14";label = "По генерации";width=15;}
			: button { key = "a15";label = "Уст. св-ва";width=15;}
		}
	}
  : row
  { : button { key = "a17";label ="Осевая";width=12;}
    : button { key = "a18";label ="Белая";width=12;}
    : button { key = "a19";label ="ПОСЛОЮ";width=12;}
  }
  : row { ok_cancel; : button { key = "a20";label ="О программе"; } }
  errtile;
}

linetype : dialog
{	label = "Выбор типа линии";aspect_ratio = 0;
	: list_box { key="b4";}
	: boxed_row
	{
		label = "Тип линии";
		: text {key="b7";width = 15;fixed_width = true;}
	}
	ok_cancel_help; errtile;
}

layertype : dialog
{	label = "Выбор слоя";aspect_ratio = 0;
	: list_box { key="c4";}
	: boxed_row
	{	label = "Слой";
		: text {key="c5";width = 15;fixed_width = true;}
	}
	ok_cancel; errtile;
}

