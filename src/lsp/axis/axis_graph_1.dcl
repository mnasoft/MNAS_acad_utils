dcl_settings : default_dcl_settings { audit_level = 3; }

analitic : dialog
{
  aspect_ratio = 0;
  label = "Аналитическое задание точек графика";
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
        label = "Разметка параметра T";
        : radio_row
        {
          fixed_width = true;
          : radio_button { label = "Пропорциональная"; key = "analitic:proportional-rb";}
          : radio_button { label = "Логарифмическая"; key = "analitic:logarithmic-rb";}
        }
      }
      : row
      {
        : boxed_column
        {
          : row
          { : toggle { key = "analitic:x-function-tg";}
            : edit_box { key = "analitic:x-function-eb"; edit_width=15; label = "Функция по X";}
          }
          : row
          { : toggle { key = "analitic:y-function-tg";}
            : edit_box { key = "analitic:y-function-eb"; edit_width=15; label = "Функция по Y";}
          }
        }
        : button  {key = "analitic:reculc-btn"; label = "Пересчет"; }
      }
    }
    : list_box { key="analitic:points-lb"; width = 25; label = "Точки графика";}
  }
  : boxed_row
  { label = "Ввод функции автолиспа";
    : edit_box  {key = "analitic:function-eb"; label = "Функция"; edit_width=35;}
    : button  {key = "analitic:evaluate-btn"; label = "Оценить"; }
  }
  : boxed_row
  { label = "Сообщение автолиспа";
    : text {key = "analitic:function-te"; label = "Функция";}
  }

  ok_cancel_help;
  errtile;
}
