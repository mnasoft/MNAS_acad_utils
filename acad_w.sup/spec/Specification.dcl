dcl_settings : default_dcl_settings { audit_level = 3; }

позиция : dialog
{
 label = "Редактирование и простановка позиций спецификаций";
 aspect_ratio = 0;
 : row
 {
  : column
  {
   : edit_box {label = "Текст";        edit_width = 25; key="e_1_0"; mnemonic="т";}
   spacer_1;
   : edit_box {label = "Спецификация"; edit_width = 25; key="e_1_1"; mnemonic="ц";}
   : edit_box {label = "Вариант";      edit_width = 25; key="e_1_2"; mnemonic="В";}
   : popup_list
   {
    label = "Раздел";
    key="p_1_1";
    mnemonic="д";
    edit_width=25;
   }
   spacer_1;
   : edit_box {label = "Формат";       edit_width = 25; key="e_1_4"; mnemonic="Ф";}
   : edit_box {label = "Зона";         edit_width = 25; key="e_1_5"; mnemonic="а";}
   : edit_box {label = "Позиция";      edit_width = 25; key="e_1_6"; mnemonic="П";}
   : edit_box {label = "Обозначение";  edit_width = 25; key="e_1_7"; mnemonic="О";}
   : edit_box {label = "Наименование"; edit_width = 25; key="e_1_8"; mnemonic="м";}
   : edit_box {label = "Количество";   edit_width = 25; key="e_1_9"; mnemonic="л";}
   : edit_box {label = "Примечание";   edit_width = 25; key="e_1_10"; mnemonic="ч";}
  }
  : column
  {
   children_alignment=left;
   : button { label="Заполнить";  mnemonic="З"; key="b_1_1";} 
   : edit_box {label = "Масштаб"; edit_width = 5; key="e_1_11"; mnemonic="ш";}

   : popup_list
   {
    label="Тип";
    key="p_1_2";
    list="Ничего\nТочка\nСтрелка";  
    edit_width=10;
    mnemonic="и";
   }

   : button { label="Создать";  key="b_1_5"; mnemonic="С";}
   : button { label="Выбрать";  key="b_1_6"; mnemonic="ы";}
   : button { label="Обновить"; key="b_1_7"; mnemonic="б";}
   : button { label="Уд|Восст";  key="b_1_8"; mnemonic="У";}
   : button { label="Настроить";  key="b_1_9"; mnemonic="Н";}
   : button { label="Спецификация";  key="b_1_10";}
   : button { label="Настр. цвет";  key="b_1_11";}
  }
 }
 spacer_1;
 ok_cancel_help_info;
 errtile;
}

настройка : dialog
{
 : row
 {
  : column
  {
   : boxed_column
   {
    label="Параметры простановки";
    : radio_column
    { 
     : radio_button {key="r_2_1"; label="a) Начало+полка"; mnemonic="a";}
     : radio_button {key="r_2_2"; label="b) Линия начало+направление"; mnemonic="b";}
     : radio_button {key="r_2_3"; label="c) Линия+центр начало"; mnemonic="c";}
     : radio_button {key="r_2_4"; label="d) Четноугольник начало_направление"; mnemonic="d";}
     : radio_button {key="r_2_5"; label="e) Четноугольник+центр начало"; mnemonic="e";}
   }
   : row
   {
    : button { label="Задать";    key="b_2_1"; mnemonic="З";}
    : button { label="Показать";  key="b_2_2"; mnemonic="П";}
   }
  }//boxed_column
  : boxed_row
   {label="Направление полки";
    : button { label="Задать";  key="b_2_4";}
    : button { label="Показать";  key="b_2_5";}
   }
  }
  : column
  {
   : boxed_column
   {label="Сортировка позиций";
    : radio_column
    {   
    : radio_button {key="r_2_6"; label="f) Не требуется"; mnemonic="f";}
    : radio_button {key="r_2_7"; label="g) По позиции"; mnemonic="g";}
    : radio_button {key="r_2_8"; label="h) По \"машпроектовски\""; mnemonic="h";}
    : radio_button {key="r_2_9"; label="i) По обозначению"; mnemonic="i";}
    }
   }
   : boxed_column
   {label="Тип чертежа";
    : radio_column
    {   
    : radio_button {key="r_2_10"; label="j) Без спецификации"; mnemonic="j";}
    : radio_button {key="r_2_11"; label="k) Со спецификацией"; mnemonic="k";}
    }
   }
   : boxed_column
   {label="Автоматическое заполнение";
    : toggle { label="Поля текст"; key="t_2_1"; mnemonic="П";}
    : toggle { label="Наименования по обозначению"; key="t_2_2"; mnemonic="б";}
    : toggle { label="Поля позиции"; key="t_2_3"; mnemonic="з";}
   }
  }//column
 }//row
 ok_cancel;
 errtile;
}

спец : dialog
{
 : row
 {
  : popup_list
  {
   label="Спецификация";
   key="p_3_1";
   list="1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n15\n16\n17\n18\n19";  
   edit_width=10;
   mnemonic="и";
  }
  : popup_list
  {
   label="Вариант";
   key="p_3_2";
   list="1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n15\n16\n17\n18\n19";  
   edit_width=10;
  }
  : popup_list
  {
   label="Раздел";
   key="p_3_3";
   list="1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n15\n16\n17\n18\n19";  
   edit_width=10;
  }
 }
 : row
 {
  : list_box 
  { key = "l_3_1";
    width=106; 
    hight=10;
    tab_truncate=true;
    tabs = "15 20 25 31 37 43 60 87 94 106";
  }//      14 5  5  6  6  6 17 17  7  12
 
  : column
  {
   : button { label="Доб_пер";      key="b_3_1"; mnemonic="Д";}
   : button { label="Доб_пос";      key="b_3_2"; mnemonic="с";}
   : button { label="Удалить";      key="b_3_3"; mnemonic="У";}
   : button { label="Редакт.";      key="b_3_4"; mnemonic="Р";}
   : button { label="Сорт.";        key="b_3_5"; mnemonic="Р";}
   : button { label="Выбрать";      key="b_3_6"; mnemonic="Р";}
   : button { label="Расст. поз.";  key="b_3_7"; mnemonic="Р";}
   : button { label="<";            key="b_3_8"; mnemonic="<";}
   : button { label=">";            key="b_3_9"; mnemonic=">";}
  }
 }
 : column
 {
   : edit_box {label = "Формат";       edit_width = 25; key="e_3_4"; mnemonic="Ф";}
   : edit_box {label = "Зона";         edit_width = 25; key="e_3_5"; mnemonic="а";}
   : edit_box {label = "Позиция";      edit_width = 25; key="e_3_6"; mnemonic="П";}
   : edit_box {label = "Обозначение";  edit_width = 25; key="e_3_7"; mnemonic="О";}
   : edit_box {label = "Наименование"; edit_width = 25; key="e_3_8"; mnemonic="м";}
   : edit_box {label = "Количество";   edit_width = 25; key="e_3_9"; mnemonic="л";}
   : edit_box {label = "Примечание";   edit_width = 25; key="e_3_10"; mnemonic="ч";}
   }
 : row { ok_cancel;}
 errtile;
}

цвет : dialog
{
 label="Настройка цветов для спецификации";
 children_fixed_height=true;
 children_fixed_width=true;
 : row
 {
  : button { key="b_4_1"; label="Отметка начала"; width=25; }
  : text   { key="t_4_1"; width=10;}
  : image_button { key="i_4_1"; height = 2; width=10; }
 }
 : row
 {
  : button { key="b_4_2"; label="Линия выноски"; width=25; }
  : text   { key="t_4_2"; width=10; }
  : image_button { key="i_4_2"; height = 2; width=10;}
 }
 : row
 {
  : button { key="b_4_3"; label="Плока"; width=25;}
  : text   { key="t_4_3"; width=10; }
  : image_button { key="i_4_3"; height = 2; width=10; }
 }
 : row
 {
  : button { key="b_4_4"; label="Текст позиции"; width=25;}
  : text   { key="t_4_4"; width=10; }
  : image_button { key="i_4_4"; height = 2; width=10;}
 }
 children_fixed_height=false;
 children_fixed_width=false;
 ok_cancel;
}

база_данных : dialog
{
 label = "База данных документов";
 : boxed_column 
 {label = "Шаблоны поиска";
  : row
  {
   : column
   {
    : text { label="Формат";}
    : edit_box { key="e_5_1"; value="*"; }
   }
   : column 
   {
    : text { label="Обозначение";}
    : edit_box  {key="e_5_2"; value="*"; }
   }
   :column 
   {  
    : text { label="Наименование";}
    : edit_box  { key="e_5_3"; value="*"; }
   }
  }
  : row
  {
   :column 
   {  
    : text { label="Примечание";}
    : edit_box  { key="e_5_4"; value="*"; }
   }
   :column 
   {  
    : text { label="Описание";}
    : edit_box  { key="e_5_5"; value="*"; }
   }
  }
 }
 : list_box 
  { key = "l_5_1";
    width=106; 
    hight=10;
    tab_truncate=true;
    tabs = "5 25 50 80";
  }
 : row
 {
  : boxed_column
  {
   label="Запись";
   : edit_box  { label="Формат"; key="e_5_6";}
   : edit_box  { label="Обозначение"; key="e_5_7";}
   : edit_box  { label="Наименование"; key="e_5_8";}
   : edit_box  { label="Материал"; key="e_5_9";}
   : edit_box  { label="Примечание"; key="e_5_10";}
   : edit_box  { label="Описание"; key="e_5_11";}
  }
 : boxed_column
  {
   label="Действия";
   : button  { label="Добавить"; key="b_5_1";}
   : button  { label="Удалить"; key="b_5_2";}
   : button  { label="Обновить"; key="b_5_3";}
   : button  { label="Вып. запрос"; key="b_5_4";}
   : button  { label="Сохранить"; key="b_5_5";}
  } 
 }
 spacer_1;
 ok_cancel_help_info;
 errtile;
}