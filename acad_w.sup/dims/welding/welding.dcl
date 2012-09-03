dcl_settings : default_dcl_settings { audit_level = 3; }
welding_geometry : dialog
{  label = "Вид стрелки";
 : edit_box  {key ="wg:размер_стрелки" ; label= "Размер стрелки";}
 : edit_box  {key ="wg:угол_раскрытия_стрелки"; label= "Угол раскрытия";}
 : edit_box  {key ="wg:угол_хвоста_стрелки"; label= "Угол  закрытия";}
 
 : row
 { ok_cancel; : button {key ="b_1_1";  label= "По умолчанию";}}
 errtile;
}

po_konturu_sutup : dialog
{  label = "По контуру";
 : edit_box  {key ="e_2_1"; label= "По контуру";}
 : row
 { ok_cancel; : button {key ="b_2_1";  label= "По умолчанию";}}
 errtile;
}

welding_text : dialog
{
  aspect_ratio = 0;
  label = "Сварка";
  initial_focus = "accept";
  : edit_box  {key ="wt:надстрочник";label= "Надстрочник"; }
  : edit_box  {key ="wt:подстрочник";label= "Подстрочник"; }
  : row
  {
    : boxed_radio_row
    { label= "Разворот стрелки";
      : radio_button {key="wt:разв_стрелки_по_часам"; label = "По часовой";}
      : radio_button {key="wt:разв_стрелки_против_часов"; label = "Против часовой";}
    }
    : boxed_radio_row
    { label= "Сторона";
      : radio_button {key="wt:сторона_указываемыя"; label = "Указываемая";}
      : radio_button {key="wt:сторона_оборотная"; label = "Оборотная";}
    }
  }  
  : row
  {
    : boxed_radio_row
    { label= "По контуру";
      : radio_button {key="wt:по_контуру_замкнутому"; label = "Замкнутому";}
      : radio_button {key="wt:по_контуру_разамкнутому"; label = "Разамкнутому";}
      : radio_button {key="wt:по_контуру_по_линии"; label = "По линии";}
    }
    : boxed_radio_row
    { label= "Монтажный";
      : radio_button {key="wt:монтажный_да"; label = "Да";}
      : radio_button {key="wt:монтажный_нет"; label = "Нет";}
    }
  }
  : boxed_row
  { label = "Надстрочник";
    : boxed_row
    { label="Об. стандарта";
      : toggle {key = "wt:обозн_стандарта"; } 
      : popup_list {key = "wt:список_обозн_стандартаpтов";}
    }
    : boxed_row
    { label="Об. шва";
      : toggle {key = "wt:обозн_шва"; }
      : popup_list    {  key = "wt:список_обозн_швов";}
    }
    : boxed_row
    { label="Способ св.";
      : toggle {key = "wt:спос_сварки";} 
      : popup_list    {  key = "wt:список_спос_сварки";}
    }
    : boxed_row
    {label="Катет";
      : toggle {key = "wt:катет_t"; } 
      : edit_box {  key = "wt:катет_eb";}
    }
    : boxed_row
    { label="Доп. знаки";
      : popup_list {key = "wt:надстр_список_доп_знаков"; width =15;}
    }
    : boxed_row
    {label="Шерох.";
      : toggle {key = "wt:надстр_шерох_t"; } 
      : edit_box {  key = "wt:надстр_шерох_eb";}
    }
  }
  : boxed_row
  { label = "Подстрочник";
    : boxed_row
    { label = "Категория";
      : toggle {key = "wt:категория"; }
      : popup_list    {  key = "wt:список_категорий";}
    }
    : boxed_row
    { label = "Комплекс";
      : toggle {key = "wt:комплекс"; }
      : popup_list {key = "wt:список_комплексов";}
    }
    : boxed_row
    { label="Доп. знаки";
      : popup_list {key = "wt:подстр_список_доп_знаков"; width =15;}
    }
    : boxed_row
    { label="Шерох.";
      : toggle {key = "wt:подстр_шерох_t"; }
      : edit_box {  key = "wt:подстр_шерох_eb";}
    }
  }
  : row
  { : button {key="Нарисовать"; label="Нарисовать";}
    : button {key="Настройка"; label="Настройка";}
    : button {key="Сохранить"; label="Сохранить";}
    : button {key="Выбрать"; label="Выбрать";}
    : button {key="Обновить"; label="Обновить";}
  }
  ok_cancel;
  errtile;
}