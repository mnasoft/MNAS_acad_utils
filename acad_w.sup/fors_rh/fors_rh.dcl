dcl_settings : default_dcl_settings { audit_level = 3; }

fors_gas : dialog
{
  aspect_ratio = 0;
  label = "���������� ��������� �������������� ������� ��������";
  initial_focus = "accept";
  
  : edit_box  {key ="fors_gas:f_fors";label= "����������� ������� ��������, ��^2";}
  : edit_box  {key ="fors_gas:ro*dp_min";label= "���. ����. �����. ro*dp, (��/�^3)*���";}
  : edit_box  {key ="fors_gas:ro*dp_max";label= "���. ����. �����. ro*dp, (��/�^3)*���";}
  : edit_box  {key ="fors_gas:var_name";label= "���������� ��� ������ ����� �������";}
  : edit_box  {key ="fors_gas:n_div";label= "���������� �������";}
  : radio_column
  {
    : radio_button {label = "���������������� �����"; key = "fors_gas:fl_pr";}
    : radio_button {label = "��������������� �����"; key = "fors_gas:fl_log";}
  }
  ok_cancel_help;
  errtile;
}

fors_lic : dialog
{
  aspect_ratio = 0;
  label = "���������� ��������� �������������� ���������� ��������";
  initial_focus = "accept";
  
  : edit_box  {key ="fors_lic:P_kontr";label= "�������� � ����������� ����� P_kontr, [���]";}
  : edit_box  {key ="fors_lic:G_kontr";label= "������ � ����������� ����� G_kontr, [��/�]";}
  : edit_box  {key ="fors_lic:Ro_kontr";label= "��������� ������� � ����������� ����� Ro_kontr, (��/�^3)";}
  : edit_box  {key ="fors_lic:Ro";label= "��������� ������� ��� ������� Ro, (��/�^3)";}
  : edit_box  {key ="fors_lic:dP_min";label= "���. ����. �����. dP_min, [���]";}
  : edit_box  {key ="fors_lic:dP_max";label= "���. ����. �����. dP_max, [���]";}
  : edit_box  {key ="fors_lic:var_name";label= "���������� ��� ������ ����� �������";}
  : edit_box  {key ="fors_lic:n_div";label= "���������� �������";}
  : radio_column
  {
    : radio_button {label = "���������������� �����"; key = "fors_lic:fl_pr";}
    : radio_button {label = "��������������� �����"; key = "fors_lic:fl_log";}
  }
  
  ok_cancel_help;
  errtile;
}