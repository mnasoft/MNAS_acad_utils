dcl_settings : default_dcl_settings { audit_level = 3; }

// Надписи на графике
gr_text : dialog
{
  aspect_ratio = 0;
  label = "Надписи  графика";
  initial_focus = "zagolovok";
  : row
  {
    : edit_box { key = "zagolovok"; label = "Заголовок      "; edit_width = 20; fixed_width = true; }
    : edit_box { key = "h_tt"; label = "Высота"; edit_width = 3; fixed_width = true; }
    : edit_box { key = "d_tt"; label = "+ dY"; edit_width = 5; fixed_width = true; }
  }
  : row
  {
    : edit_box { key = "x_axis"; label = "Ось X          "; edit_width = 20; fixed_width = true; }
    : edit_box { key = "h_axis"; label = "Высота"; edit_width = 3; fixed_width = true; }
    : edit_box { key = "d_tx"; label = "+ dX"; edit_width = 5; fixed_width = true; }
  }
  : row
  {
    : edit_box { key = "y_axis"; label = "Ось Y          "; edit_width = 20; fixed_width = true; }
    : edit_box { key = "d_ty"; label = "+ dY"; edit_width = 5; fixed_width = true; }
  }
  : row
  {
    : edit_box { key = "risunok"; label = "Подрис. надпись"; edit_width = 20; fixed_width = true; }
    : edit_box { key = "h_tr"; label = "Высота"; edit_width = 3; fixed_width = true; }
    : edit_box { key = "d_tr"; label = " - dY"; edit_width = 5; fixed_width = true;  }
  }
  : column
  {
    : row
    {
      : edit_box { key = "h_net"; label = "Высота текста на сетке   "; edit_width = 5; fixed_width = true; }
      : edit_box { key = "d_net"; label = "Смещение         "; edit_width = 5; fixed_width = true; }
    }
  }
  ok_cancel_help;
  errtile;
}

// Настройка сетки для графика
gr_net : dialog
{
  aspect_ratio = 0;
  label = "Сетка графика";
  initial_focus = "min_x";
  : row
  {
    : edit_box{key="min_x";label = "Min X";edit_width = 5;fixed_width = true;}
    : edit_box{key = "max_x";label = "Max X";edit_width = 5;fixed_width = true;}
    : edit_box{key = "dx";label = "Dx";edit_width = 5;fixed_width = true;}
    : edit_box{key="sub_x";label="sub_x";edit_width=5;fixed_width = true;}
  }
  : row
  {
    : edit_box {key="min_y";label="Min Y";edit_width = 5; fixed_width = true; }
    : edit_box {key="max_y";label="Max y";edit_width = 5; fixed_width = true; }
    : edit_box {key ="dy";label = "Dy";edit_width = 5;fixed_width = true;}
    : edit_box {key ="sub_y";label="Sub_y";edit_width=5;fixed_width = true;}
  }
  : row
  {
    : edit_box  { key = "ps_x"; label = "Scale X";}
    : edit_box  { key = "ps_y"; label = "Scale Y";}
  }
  : row
  {
    : edit_box  { key = "pp_x"; label = "X0"; }
    : edit_box  { key = "pp_y"; label = "Y0"; }
  }
  : column
  {
    : row
    {
      : edit_box  { key = "l_type"; label = "Тип линии: "; }
      : edit_box  { key = "l_color"; label = "Цвет линии: "; }
    }
    : row
    {
      : edit_box  { key = "point_bl"; label = "Блок "; }
      : edit_box  { key = "sc_x_bl";  label = "sc x "; }
      : edit_box  { key = "sc_y_bl";  label = "sc y "; }
      : edit_box  { key = "color_bl"; label = "Color ";}
    }
  }
  ok_cancel_help;
  errtile;
}

