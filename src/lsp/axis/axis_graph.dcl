dcl_settings : default_dcl_settings { audit_level = 3; }

axis_graph_main : dialog
{
  aspect_ratio = 0;
  label = "������� ���������� ��������";
  initial_focus = "accept";
  fixed_width = true;
  
  : column
  {
    : button {label="������������ �����..." ;key = "btn_������������ �����";}
    : button {label="������� ���������..." ;key = "btn_������� ���������";}
    : button {label="��������� �����������..." ;key = "btn_��������� �����������";}
    : button {label="������������� �����������...";key = "btn_������������� �����������";}
  }
   ok_cancel_help;
}

axis_graph_axis : dialog
{
  aspect_ratio = 0;
  label = "������������ �����";
  initial_focus = "accept";
  fixed_width = true;
  :row
  {
  : list_box
    {
      label="��������� �����" ;key = "lst_��������� �����"; width=30; 
    }
  : column
    {
    : button {label="�������������" ;key = "btn_�������������";}
      spacer;
    : button {label="��������" ;key = "btn_��������";}
    : button {label="�������" ;key = "btn_�������";}
      spacer;
    : button {label="�������" ;key = "btn_�������";}
    : button {label="������" ;key = "btn_������";}
      spacer;
    : button {label="������������" ;key = "btn_������������";}
    : button {label="�����������" ;key = "btn_�����������";}
    }
  }
   ok_cancel_help;
}