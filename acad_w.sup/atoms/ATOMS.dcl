atoms : dialog
{
  label = "Atoms-family";
  : edit_box  { key = "e_1_1";}
  : row
  {
    : column
    {
      :row
      {
        : button { key = "b_1_14l"; label = "��� � | � ���";}
        : text {key= "t_1_1l"; width=5;}
      }
      : edit_box  { key = "e_1_2l";}
      : list_box  { key = "l_1_l"; width=25;}
      : text {key=t_1_2l; width=20;}
    }
    : column
    {
      :row
      {
        : button { key = "b_1_14r"; label = "��� � | � ���";}
        : text {key= "t_1_1r"; width=5;}
      }
      : edit_box  { key = "e_1_2r";}
      : list_box  { key = "l_1_r"; width=25;}
      : text {key=t_1_2r; width=20;}
    }
    : column
    {
      : button { key = "b_1_11"; label = " ������� ";}
      : button { key = "b_1_15"; label = " ��������";}
      : button { key = "b_1_10"; label = "<---- Del";}
      : button { key = "b_1_7"; label = "�������� ";}
      : button { key = "b_1_8"; label = "���������";}
      : button { key = "b_1_12"; label = "���������";}
      : button { key = "b_1_13"; label = "���������";}
      : button { key = "b_1_16"; label = " ������� ";}

      : button { key = "b_1_9"; label = "<-- Copy ";}
      : button { key = "b_1_2"; label = "U   �!=� ";}
      : button { key = "b_1_3"; label = "�   �!=� ";}
      : button { key = "b_1_4"; label = "  <----> ";}
    }
  }
  ok_cancel;
  errtile;
}

