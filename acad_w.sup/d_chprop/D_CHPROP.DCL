dcl_settings : default_dcl_settings { audit_level = 3; }

dchprop : dialog
{	label = "��������� ������� ��������";aspect_ratio = 0;
	: row
	{
		: button { key ="a1";label= "����� ��������";width=20;}
		: button { key="a16";label="���������� ��������";width=20;}
	}
	: boxed_row
	{ : column
		{ : row
			{ : toggle {key = "a7";}
				: button { key = "a4";label ="����"; width=12; }
				: edit_box { key = "a10";width=15;}
			}
			: row
			{ : toggle { key = "a8";}
				: button { key = "a5";label = "��� �����";width=12;}
				: edit_box { key = "a11"; width=15;}
			}
			: row
			{	: toggle { key = "a9";}
				: button { key = "a6";label ="����";width=12;}
				: edit_box { key = "a12";width=15;}
			}
		}
		: column
		{ : button { key = "a13";label = "�� �������";width=15;}
			: button { key = "a14";label = "�� ���������";width=15;}
			: button { key = "a15";label = "���. ��-��";width=15;}
		}
	}
  : row
  { : button { key = "a17";label ="������";width=12;}
    : button { key = "a18";label ="�����";width=12;}
    : button { key = "a19";label ="������";width=12;}
  }
  : row { ok_cancel; : button { key = "a20";label ="� ���������"; } }
  errtile;
}

linetype : dialog
{	label = "����� ���� �����";aspect_ratio = 0;
	: list_box { key="b4";}
	: boxed_row
	{
		label = "��� �����";
		: text {key="b7";width = 15;fixed_width = true;}
	}
	ok_cancel_help; errtile;
}

layertype : dialog
{	label = "����� ����";aspect_ratio = 0;
	: list_box { key="c4";}
	: boxed_row
	{	label = "����";
		: text {key="c5";width = 15;fixed_width = true;}
	}
	ok_cancel; errtile;
}

