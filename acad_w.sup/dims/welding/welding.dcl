dcl_settings : default_dcl_settings { audit_level = 3; }
welding_geometry : dialog
{  label = "��� �������";
 : edit_box  {key ="wg:������_�������" ; label= "������ �������";}
 : edit_box  {key ="wg:����_���������_�������"; label= "���� ���������";}
 : edit_box  {key ="wg:����_������_�������"; label= "����  ��������";}
 
 : row
 { ok_cancel; : button {key ="b_1_1";  label= "�� ���������";}}
 errtile;
}

po_konturu_sutup : dialog
{  label = "�� �������";
 : edit_box  {key ="e_2_1"; label= "�� �������";}
 : row
 { ok_cancel; : button {key ="b_2_1";  label= "�� ���������";}}
 errtile;
}

welding_text : dialog
{
  aspect_ratio = 0;
  label = "������";
  initial_focus = "accept";
  : edit_box  {key ="wt:�����������";label= "�����������"; }
  : edit_box  {key ="wt:�����������";label= "�����������"; }
  : row
  {
    : boxed_radio_row
    { label= "�������� �������";
      : radio_button {key="wt:����_�������_��_�����"; label = "�� �������";}
      : radio_button {key="wt:����_�������_������_�����"; label = "������ �������";}
    }
    : boxed_radio_row
    { label= "�������";
      : radio_button {key="wt:�������_�����������"; label = "�����������";}
      : radio_button {key="wt:�������_���������"; label = "���������";}
    }
  }  
  : row
  {
    : boxed_radio_row
    { label= "�� �������";
      : radio_button {key="wt:��_�������_����������"; label = "����������";}
      : radio_button {key="wt:��_�������_������������"; label = "������������";}
      : radio_button {key="wt:��_�������_��_�����"; label = "�� �����";}
    }
    : boxed_radio_row
    { label= "���������";
      : radio_button {key="wt:���������_��"; label = "��";}
      : radio_button {key="wt:���������_���"; label = "���";}
    }
  }
  : boxed_row
  { label = "�����������";
    : boxed_row
    { label="��. ���������";
      : toggle {key = "wt:�����_���������"; } 
      : popup_list {key = "wt:������_�����_���������p���";}
    }
    : boxed_row
    { label="��. ���";
      : toggle {key = "wt:�����_���"; }
      : popup_list    {  key = "wt:������_�����_����";}
    }
    : boxed_row
    { label="������ ��.";
      : toggle {key = "wt:����_������";} 
      : popup_list    {  key = "wt:������_����_������";}
    }
    : boxed_row
    {label="�����";
      : toggle {key = "wt:�����_t"; } 
      : edit_box {  key = "wt:�����_eb";}
    }
    : boxed_row
    { label="���. �����";
      : popup_list {key = "wt:������_������_���_������"; width =15;}
    }
    : boxed_row
    {label="�����.";
      : toggle {key = "wt:������_�����_t"; } 
      : edit_box {  key = "wt:������_�����_eb";}
    }
  }
  : boxed_row
  { label = "�����������";
    : boxed_row
    { label = "���������";
      : toggle {key = "wt:���������"; }
      : popup_list    {  key = "wt:������_���������";}
    }
    : boxed_row
    { label = "��������";
      : toggle {key = "wt:��������"; }
      : popup_list {key = "wt:������_����������";}
    }
    : boxed_row
    { label="���. �����";
      : popup_list {key = "wt:������_������_���_������"; width =15;}
    }
    : boxed_row
    { label="�����.";
      : toggle {key = "wt:������_�����_t"; }
      : edit_box {  key = "wt:������_�����_eb";}
    }
  }
  : row
  { : button {key="����������"; label="����������";}
    : button {key="���������"; label="���������";}
    : button {key="���������"; label="���������";}
    : button {key="�������"; label="�������";}
    : button {key="��������"; label="��������";}
  }
  ok_cancel;
  errtile;
}