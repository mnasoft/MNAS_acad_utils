dcl_settings : default_dcl_settings { audit_level = 3; }

form : dialog
{
  label = "����� �������";
  aspect_ratio = 0;
  : row
  {
	  : cluster
    { : boxed_column
      { label = "������";
        : list_box { key = "for_list"; }
        : text { key = "for_edit"; width = 5; fixed_width = true; }
			}
		}
		: cluster
    { : boxed_column
      { label = "���������";
        : list_box { key = "kr_list"; }
        : text { key = "kr_edit"; width = 5; }
		  }
  	}
  }
  : boxed_radio_row
  { label = "������������ ����� �������";
    : radio_button {label ="�������"; key = "long_side"; is_tab_stop = false; }
    : radio_button {label ="��������";key = "short_side";is_tab_stop = false; }
  }
  : cluster{: boxed_row {label = "������ "; : text { key="razmer"; width = 5;}}}
  ok_cancel;
  errtile;
}

sht1 : dialog
{
	aspect_ratio = 0;
	label = "���������� ������";
	: column
	{
		: boxed_column
		{
	 		label = "�������� �����";
      : edit_box { key = "sht1_1"; label = "������������"; }
      : edit_box { key = "sht1_2"; label = "����������� "; }
      : edit_box { key = "sht1_3"; label = "��������    "; }
		}
		: boxed_row
		{
			label = "����� No � ����. ����.";
      : edit_box { key = "sht1_24"; label = "����� No"; }
      : edit_box { key = "sht1_25"; label = "����. ����."; }
		}
		: row
		{
			: boxed_column
			{
				label = "�����������";
        : edit_box { key = "sht1_11_1"; label = "������. "; width = 20; }
        : edit_box { key = "sht1_11_2"; label = "������. "; width = 20; }
        : edit_box { key = "sht1_11_3"; label = "�.�����."; width = 20; }
				: row
				{
          : edit_box { key = "sht1_10"; width = 8; }
          : edit_box { key = "sht1_11_4"; width = 12; }
				}
        : edit_box { key = "sht1_11_5"; label = "�.�����."; }
        : edit_box { key = "sht1_11_6"; label = "��������"; }
			}
			: boxed_column
      { label = "������ �����";
				: boxed_row
        { label = "������";
          : edit_box { key = "sht1_4_1"; width=5; fixed_width = true; }
          : edit_box { key = "sht1_4_2"; width=5; fixed_width = true; }
          : edit_box { key = "sht1_4_3"; width=5; fixed_width = true; }
				}
				: row
				{
          : edit_box { key = "sht1_5"; label = "�����"; }
          : edit_box { key = "sht1_6"; label = "�����"; }
				}
				: boxed_row
				{
          : edit_box { key = "sht1_7"; label = "����"; }
          : edit_box { key = "sht1_8"; label = "������";}
				}
        : edit_box { key = "sht1_9"; label = "������ ������."; }
			}
		}
	}
	ok_cancel;
	errtile;
}

forma : dialog
{
	aspect_ratio = 0;
	label = "����� �������� �������";
	: boxed_column
  { label = "����� - ��� ���� ����.    | ����";
    : list_box { key = "f_list"; width = 40; }
	}
	ok_cancel;
	errtile;
}

dop_dlg : dialog
{
  aspect_ratio = 0;
  label = "����� �������������� �������";
  : row
  {
    : boxed_column
    { label = "�������";
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
    { label = "������� � �������";
      : list_box { key = "dop_dlg_1"; width = 20; }
    }
  }
  :row
  {
    : button { label ="��������"; key = "dop_dlg_5"; }
    : button { label ="�������"; key = "dop_dlg_6"; }
    : button { label ="�������������"; key = "dop_dlg_7"; }
  }
  ok_cancel;
  errtile;
}

add_dop_sht_dlg : dialog
{
	aspect_ratio = 0;
	label = "����� �������������� �������";
  : edit_box { key = "add_dop_sht_dlg_1"; label = "��� ������"; }
  : edit_box { key = "add_dop_sht_dlg_2"; label = "��� �����"; }
  : radio_column
  {
    : radio_button {label = "�����_���"; key = "add_dop_sht_dlg_3";}
    : radio_button {label = "�����_����"; key = "add_dop_sht_dlg_4";}
    : radio_button {label = "����_����"; key = "add_dop_sht_dlg_5";}
    : radio_button {label = "����_���"; key = "add_dop_sht_dlg_6";}
  }
	ok_cancel;
	errtile;
}

sht_main : dialog
{
	aspect_ratio = 0;
	label = "���������� ������";
	: row
	{
		: column
		{
			: row
			{
				: boxed_column
        { label = "������ � ���������";
          :text { key = "format_text"; width = 25; }
          :text { key = "dir_sht"; width = 5; }
          : button { label = "����� ������..."; mnemonic = "B"; key = "format"; }
				}
				: column
				{
					: button
          { key = "ed_1"; label = "����������..."; }
          : button { key = "ed_3"; label = "��������� �����."; }
          : button { key = "ed_4"; label = "�������"; }
				}
			}
			: boxed_row
      { label = "������� �� ����";
				: radio_column
					{
            : radio_button { label ="����"; key = "Dz_y"; is_tab_stop = false; }
            : radio_button { label ="��� "; key = "Dz_n"; is_tab_stop = false; }
				}
				: column
				{
          : edit_box { key = "z_1"; label = "���. �����"; }
          : edit_box { key = "z_A"; label = "���. �����"; }
				}
			}
      : boxed_column
      { label = "����� ����� (��� ������)";
        : popup_list {label = "";
          tabs = "5 22 45"; 
          list="1\t������� � �����\t(������ ����)\n2\t�����.������.���.\t(������ ����)\n2��\t������� � �����\t(����������� ����)\n2��\t�����.������.���.\t(����������� ����)\n2��\t�����.������.���.\t(�������� ����)\n2��\t�����.������.���.\t(������ ����)\n3\t������ �����\t(��)";
          key = "sht_list";}
      }
      : boxed_row
      { label = "������ ������";
        : button { label = "��������..."; key = "pick"; }
        : edit_box { key = "X0"; label = "X="; }
        : edit_box { key = "Y0"; label = "Y="; }
			}
		}
		: boxed_column
    { label = "�������������� �����";
      : list_box { key = "dop_list"; }
      : button { key = "dop_edit"; label = "��������������..."; }
		}
	}
  : row
  {
    : button { label ="���������"; key = "for_zap";}
    ok_cancel;
    : button { label ="� ���������..."; key = "about";}
  }
	errtile;
}