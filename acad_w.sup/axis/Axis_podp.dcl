dcl_settings : default_dcl_settings { audit_level = 3; }

axis_podp : dialog
{
  aspect_ratio = 0;
  label = "��������� ������� ���";
  initial_focus = "accept";
  fixed_width = true;
  : row
  {
    : boxed_column
    { label = "������� ��� ������";
      :row
      {
        : toggle {label = "����� ��� Y"; key = "zas_right";}
        : edit_box  {edit_width= 5; key ="zas_right_len";}
      }
      :row
      {
        : toggle {label = "������ ��� Y"; key = "zas_left";}
        : edit_box  {edit_width= 5; key ="zas_left_len";}
      }
      : edit_box  {edit_width= 5; label= "x_min";  key ="zas_x_min";}
      : edit_box  {edit_width= 5; label= "x_max";  key ="zas_x_max";}
      : edit_box  {edit_width= 5; label= "n_div";  key ="zas_n_div";}
      : popup_list {key ="zas_lst"; }
      : toggle {key = "zas_draw";}
    }
    : boxed_column
    { label = "����� ����";
      : edit_box  {edit_width= 5; label= "���������� �� ���";  key ="text_dist_from_ax";}
      : edit_box  {edit_width= 5; label= "������";  key ="text_hight";}
      : edit_box  {edit_width= 5; label= "���� ��������";  key ="text_angle";}
      : edit_box  {edit_width= 5; label= "x_min";  key ="text_x_min";}
      : edit_box  {edit_width= 5; label= "x_max";  key ="text_x_max";}
      : edit_box  {edit_width= 5; label= "n_div";  key ="text_n_div";}
      : popup_list {key ="text_lst"; }
      : toggle {key = "text_draw";}
    }
    : boxed_column
    { label = "������� ���";
      : radio_column
      {   
        : radio_button { label = "������"; key = "podp_text_start";}
        : radio_button { label = "���������"; key = "podp_text_middle";}
        : radio_button { label = "�����"; key = "podp_text_end";}
      }
      : edit_box  {edit_width= 5; label= "���������� �� ���";  key ="podp_text_dist_from_ax";}
      : edit_box  {edit_width= 5; label= "������";  key ="podp_text_hight";}
      : edit_box  {edit_width= 5; label= "���� ��������";  key ="podp_text_angle";}
      : toggle {key = "podp_text_draw";}
    }
  }
  : row
  {
    : button {label="�������� ��� x" ;key = "btn_select_x_axis";}
    : button {label="�������� ��� y" ;key = "btn_select_y_axis";}
    : button {label="����������" ;key = "btn_darw";}
    : button {label="�������" ;key = "btn_delete";}
  }
   ok_cancel_help;
}

