dcl_settings : default_dcl_settings { audit_level = 3; }

spring : dialog
{
  aspect_ratio = 0;
  label = "������ ������������� ������� ������";
  initial_focus = "accept";
  : boxed_column
  {
    label = "�������������� �������������� �������";
    : edit_box  {key ="wire_dia";label= "������� ��������� �������, ��"; }
    : edit_box  {key ="spring_mid_dia";label= "������� ������� �������, ��"; }
    : edit_box  {key ="spring_length_wo_weighting";label= "����� ������� � ��������� ���������, ��"; }
    : edit_box  {key ="spring_full_coil_number";label= "����� ������� � ��������� ���������, ��"; }
  }
  : boxed_column
  {
    label = "�������������� ���������";
    : edit_box  {key ="matirial_Ung_modulus_2type";label= "������ ���� ������� ����, ���"; }
    : edit_box  {key ="matirial_tau_dop";label= "���������� ���������� ��� ��������, ���"; }
  }
  : boxed_column
  {
     label = "������� �������";
     : edit_box  {key ="L1"; label= "L1, ��"; }
     : edit_box  {key ="L2"; label= "L2, ��"; }
     : edit_box  {key ="L3"; label= "L3, ��"; }
     : edit_box  {key ="working_temperature";label= "������� �����������, ����. �"; }
  }
  : row
  { ok_cancel_help;
    : button  {key = "about"; label = "� ���������"; }
  }
  errtile;
}