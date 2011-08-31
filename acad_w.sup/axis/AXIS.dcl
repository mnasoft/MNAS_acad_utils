dcl_settings : default_dcl_settings { audit_level = 3; }

axis : dialog
{
  aspect_ratio = 0;
  label = "Ввод точек графика";
  initial_focus = "accept";
  : row
  { : edit_box  {key ="e4";label= "Имя графика"; }
    : button  {key = "b10"; label = "<"; }
    : text {key = "t2"; width=5; }
    : button  {key = "b11"; label = ">"; }
    : button  {key = "b18"; label = "Ins"; mnemonic="s"; }
    : button  {key = "b19"; label = "Del"; mnemonic="l";}
  }
  : row
  {
    : button  {key = "b12"; label = "X-Шкала"; }
    : edit_box{key ="e5"; }
    : button  {key = "b13"; label = "X-Сетка "; }
    : button  {key = "b14"; label = "Y-Шкала"; }
    : edit_box{key ="e6"; }
    : button  {key = "b15"; label = "Y-Сетка"; }
  }
  : boxed_row
  { label = "Манипулирование точкам текущего графика";
    : column
    {
      : boxed_column
      { label = "Ссылочная точка";
      : boxed_row
        { label = "Удаление,Вставка,Прокрутка";
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
      { label = "Редактируемая точка";
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
      : list_box { key="l1"; width = 15; label = "Точки графика";}
      : button  {key = "b17"; label = "Параметры точек"; }
      : button  {key = "b7"; label = "Аналитическое задание точек"; }
    }
  }
  : row
  { ok_cancel_help;
    : button  {key = "b16"; label = "О программе"; }
    : button  {key = "b20"; label = "Просмотр";}
  }
  errtile;
}

panal : dialog
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
        : edit_box  {key = "e20"; label = "T min"; }
        : edit_box  {key = "e21"; label = "n";}
        : edit_box  {key = "e22"; label = "T max";}
      }
      : boxed_row
      {
        label = "Разметка параметра T";
        : radio_row
        {
          fixed_width = true;
          : radio_button { label = "Пропорциональная"; key = "r21";}
          : radio_button { label = "Логарифмическая"; key = "r22";}
        }
      }
      : row
      {
        : boxed_column
        {
          : row
          { : toggle { key = "t21";}
            : edit_box { key = "e24"; edit_width=15; label = "Функция по X";}
          }
          : row
          { : toggle { key = "t22";}
            : edit_box { key = "e25"; edit_width=15; label = "Функция по Y";}
          }
        }
        : button  {key = "b21"; label = "Пересчет"; }
      }
    }
    : list_box { key="l21"; width = 25; label = "Точки графика";}
  }
  : boxed_row
  { label = "Ввод функции автолиспа";
    : edit_box  {key = "e23"; label = "Функция"; edit_width=35;}
    : button  {key = "b22"; label = "Оценить"; }
  }
  : boxed_row
  { label = "Сообщение автолиспа";
    : text {key = "te21"; label = "Функция";}
  }

  ok_cancel_help;
  errtile;
}

eaxis : dialog
{
  aspect_ratio = 0;
  label = "Редактирование шкалы";
  initial_focus = "accept";
  : edit_box  {key = "e36"; label = "Имя шкалы";  }
  : boxed_column
  { label = "Коорд. точек и зн. шкалы в них";
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
      label = "Разметка параметра T";
      : radio_row
      {
        fixed_width = true;
        : radio_button { label = "Пропорциональная"; key = "r30";}
        : radio_button { label = "Логарифмическая"; key = "r31";}
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
  label = "Линия графика";
  initial_focus = "accept";
  : edit_box  {key ="e41";label= "Ширина линии"; }
  : row { ok_cancel; : button {key = "b41"; label = "Свойства";} }
  errtile;
}

eblock : dialog
{
  aspect_ratio = 0;
  label = "Точки графика";
  initial_focus = "accept";
  : edit_box  {key ="e61";label= "Имя блока"; }
  : row
  {
  : edit_box  {key ="e62";label= "X масшт"; }
  : edit_box  {key ="e63";label= "Y масшт"; }
  }
  : row { ok_cancel; : button {key = "b61"; label = "Свойства";} }
  errtile;
}

eprop : dialog
{
  aspect_ratio = 0;
  label = "Настройки точек";
  initial_focus = "accept";
  : row
  { : toggle { key = "t81";} : button {key = "b81"; label = "Блок"; } }
  : row
  { : toggle { key = "t82";} : button {key = "b82"; label = "Линия"; } }
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

