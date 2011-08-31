dcl_settings : default_dcl_settings { audit_level = 3; }

axis : dialog
{
  aspect_ratio = 0;
  label = "���� ����� �������";
  initial_focus = "accept";
  : row
  { : edit_box  {key ="e4";label= "��� �������"; }
    : button  {key = "b10"; label = "<"; }
    : text {key = "t2"; width=5; }
    : button  {key = "b11"; label = ">"; }
    : button  {key = "b18"; label = "Ins"; mnemonic="s"; }
    : button  {key = "b19"; label = "Del"; mnemonic="l";}
  }
  : row
  {
    : button  {key = "b12"; label = "X-�����"; }
    : edit_box{key ="e5"; }
    : button  {key = "b13"; label = "X-����� "; }
    : button  {key = "b14"; label = "Y-�����"; }
    : edit_box{key ="e6"; }
    : button  {key = "b15"; label = "Y-�����"; }
  }
  : boxed_row
  { label = "��������������� ������ �������� �������";
    : column
    {
      : boxed_column
      { label = "��������� �����";
      : boxed_row
        { label = "��������,�������,���������";
          : edit_box{key = "e1"; edit_width = 5;}
          : button  {key = "b6"; label = "Del";mnemonic="D";}
          : text    {key = "t1"; label = ""; width = 15;}
          : button  {key = "b5"; label = "Ins";mnemonic="I";}
        }
        : row
        {
          : button  {key = "b1"; label = "<<"; }
          : button  {key = "b2"; label = "<"; }
          : button  {key = "b3"; label = ">"; }
          : button  {key = "b4"; label = ">>"; }
        }
      }
      : boxed_column
      { label = "������������� �����";
        : row
        {
          : edit_box  {key = "e2"; label = "X = ";}
          : edit_box  {key = "e3"; label = "Y = ";}
        }
        : row
        {
          : button  {key = "b8"; label = "Pick"; mnemonic="P"; }
          : button  {key = "b9"; label = "Edit"; mnemonic="E";}
        }
      }
    }
    : column
    {
      : list_box { key="l1"; width = 15; label = "����� �������";}
      : button  {key = "b17"; label = "��������� �����"; }
      : button  {key = "b7"; label = "������������� ������� �����"; }
    }
  }
  : row
  { ok_cancel_help;
    : button  {key = "b16"; label = "� ���������"; }
    : button  {key = "b20"; label = "��������";}
  }
  errtile;
}

panal : dialog
{
  aspect_ratio = 0;
  label = "������������� ������� ����� �������";
  initial_focus = "accept";
  : boxed_row
  {
    : boxed_column
    {
      : row
      {
        : edit_box  {key = "e20"; label = "T min"; }
        : edit_box  {key = "e21"; label = "n";}
        : edit_box  {key = "e22"; label = "T max";}
      }
      : boxed_row
      {
        label = "�������� ��������� T";
        : radio_row
        {
          fixed_width = true;
          : radio_button { label = "����������������"; key = "r21";}
          : radio_button { label = "���������������"; key = "r22";}
        }
      }
      : row
      {
        : boxed_column
        {
          : row
          { : toggle { key = "t21";}
            : edit_box { key = "e24"; edit_width=15; label = "������� �� X";}
          }
          : row
          { : toggle { key = "t22";}
            : edit_box { key = "e25"; edit_width=15; label = "������� �� Y";}
          }
        }
        : button  {key = "b21"; label = "��������"; }
      }
    }
    : list_box { key="l21"; width = 25; label = "����� �������";}
  }
  : boxed_row
  { label = "���� ������� ���������";
    : edit_box  {key = "e23"; label = "�������"; edit_width=35;}
    : button  {key = "b22"; label = "�������"; }
  }
  : boxed_row
  { label = "��������� ���������";
    : text {key = "te21"; label = "�������";}
  }

  ok_cancel_help;
  errtile;
}

eaxis : dialog
{
  aspect_ratio = 0;
  label = "�������������� �����";
  initial_focus = "accept";
  : edit_box  {key = "e36"; label = "��� �����";  }
  : boxed_column
  { label = "�����. ����� � ��. ����� � ���";
    : row
    {
      : edit_box  {key = "e30"; label = "Xs";  }
      : edit_box  {key = "e31"; label = "Ys";  }
      : button    {key = "b31"; label = "Pick";}
      : edit_box  {key = "e32"; label = "Ls";  }
    }
    : row
    {
      : edit_box  {key = "e33"; label = "Xe";}
      : edit_box  {key = "e34"; label = "Ye";}
      : button    {key = "b32"; label = "Pick";}
      : edit_box  {key = "e35"; label = "Le";}
    }

    : boxed_row
    {
      label = "�������� ��������� T";
      : radio_row
      {
        fixed_width = true;
        : radio_button { label = "����������������"; key = "r30";}
        : radio_button { label = "���������������"; key = "r31";}
      }
    }
  }
  : row
  { ok_cancel;
    : button { label ="About"; key = "about" ; }
  }
  errtile;
}

epline : dialog
{
  aspect_ratio = 0;
  label = "����� �������";
  initial_focus = "accept";
  : edit_box  {key ="e41";label= "������ �����"; }
  : row { ok_cancel; : button {key = "b41"; label = "��������";} }
  errtile;
}

eblock : dialog
{
  aspect_ratio = 0;
  label = "����� �������";
  initial_focus = "accept";
  : edit_box  {key ="e61";label= "��� �����"; }
  : row
  {
  : edit_box  {key ="e62";label= "X �����"; }
  : edit_box  {key ="e63";label= "Y �����"; }
  }
  : row { ok_cancel; : button {key = "b61"; label = "��������";} }
  errtile;
}

eprop : dialog
{
  aspect_ratio = 0;
  label = "��������� �����";
  initial_focus = "accept";
  : row
  { : toggle { key = "t81";} : button {key = "b81"; label = "����"; } }
  : row
  { : toggle { key = "t82";} : button {key = "b82"; label = "�����"; } }
  ok_cancel;
  errtile;
}

im :dialog
{ label = "ESKD Formats";
  : image_button
  { key          = "i101";
    width        = 28;
    aspect_ratio = 1;
    color        = 0;
    allow_accept = true;
  }
  ok_cancel;
  errtile;
}

