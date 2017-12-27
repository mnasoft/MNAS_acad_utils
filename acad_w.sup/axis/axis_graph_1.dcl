dcl_settings : default_dcl_settings { audit_level = 3; }

analitic : dialog
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
        : edit_box  {key = "analitic:t-min-eb"; label = "T min"; }
        : edit_box  {key = "analitic:n-eb"; label = "n";}
        : edit_box  {key = "analitic:t-max-eb"; label = "T max";}
      }
      : boxed_row
      {
        label = "�������� ��������� T";
        : radio_row
        {
          fixed_width = true;
          : radio_button { label = "����������������"; key = "analitic:proportional-rb";}
          : radio_button { label = "���������������"; key = "analitic:logarithmic-rb";}
        }
      }
      : row
      {
        : boxed_column
        {
          : row
          { : toggle { key = "analitic:x-function-tg";}
            : edit_box { key = "analitic:x-function-eb"; edit_width=15; label = "������� �� X";}
          }
          : row
          { : toggle { key = "analitic:y-function-tg";}
            : edit_box { key = "analitic:y-function-eb"; edit_width=15; label = "������� �� Y";}
          }
        }
        : button  {key = "analitic:reculc-btn"; label = "��������"; }
      }
    }
    : list_box { key="analitic:points-lb"; width = 25; label = "����� �������";}
  }
  : boxed_row
  { label = "���� ������� ���������";
    : edit_box  {key = "analitic:function-eb"; label = "�������"; edit_width=35;}
    : button  {key = "analitic:evaluate-btn"; label = "�������"; }
  }
  : boxed_row
  { label = "��������� ���������";
    : text {key = "analitic:function-te"; label = "�������";}
  }

  ok_cancel_help;
  errtile;
}
