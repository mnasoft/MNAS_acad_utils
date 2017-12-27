dcl_settings : default_dcl_settings { audit_level = 3; }

axis_graph_main : dialog
{
  aspect_ratio = 0;
  label = "Система подготовки графиков";
  initial_focus = "accept";
  fixed_width = true;
  
  : column
  {
    : button {label="Координатные Шкалы..." ;key = "btn_Координатные Шкалы";}
    : button {label="Системы координат..." ;key = "btn_Системы координат";}
    : button {label="Табличные зависимости..." ;key = "btn_Табличные зависимости";}
    : button {label="Аналитические зависимости...";key = "btn_Аналитические зависимости";}
  }
   ok_cancel_help;
}

axis_graph_axis : dialog
{
  aspect_ratio = 0;
  label = "Координатные Шкалы";
  initial_focus = "accept";
  fixed_width = true;
  :row
  {
  : list_box
    {
      label="Имеющиеся шкалы" ;key = "lst_Имеющиеся шкалы"; width=30; 
    }
  : column
    {
    : button {label="Редактировать" ;key = "btn_Редактировать";}
      spacer;
    : button {label="Добавить" ;key = "btn_Добавить";}
    : button {label="Удалить" ;key = "btn_Удалить";}
      spacer;
    : button {label="Экспорт" ;key = "btn_Экспорт";}
    : button {label="Импорт" ;key = "btn_Импорт";}
      spacer;
    : button {label="Присоединить" ;key = "btn_Присоединить";}
    : button {label="Отсоединить" ;key = "btn_Отсоединить";}
    }
  }
   ok_cancel_help;
}