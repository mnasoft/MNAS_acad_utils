dcl_settings : default_dcl_settings { audit_level = 3; }

rgb : dialog
{
label = "��������� ������� ��������";aspect_ratio = 0;
//: button { key ="b_1_1";label= "��������� ���������";}
: toggle { key = "t_1_1"; label= "��� ����";}
: boxed_radio_column
  {
   : radio_button
   { key="rb_1_1"  ;label="����� 1 (5  ������)"; }
   : radio_button
   { key="rb_1_2"  ;label="����� 2 (14 ������)"; }
  }
  : edit_box { key = "eb_1_1"; label="������ ����������"; allow_accept = true;}
  : edit_box { key = "eb_1_2"; label="��������� �����"; allow_accept = true;}
  : edit_box { key = "eb_1_3"; label="�������������"; allow_accept = true;}
  ok_cancel_help_errtile; 
}