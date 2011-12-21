dcl_settings : default_dcl_settings { audit_level = 3; }

spring : dialog
{
  label = "Расчет пружины по И ЖАКИ.102.044-93";
  aspect_ratio = 0;
  :row
  {
    : boxed_column
    {
      label = "Геометрия пружины";
      :row
      {
      	: edit_box {key ="d"; label ="d"; }   	//Диаметр проволоки, мм
      	: edit_box {label ="D1"; key ="D1";} 	//Диаметр пружины наружный, мм
      	: edit_box {label ="D"; key ="D";} 	//Диаметр пружины средний, мм
      }
      :row
      {
        : edit_box {label ="n"; key ="n";} 	//Число витков пружины
        : edit_box {label ="n1"; key ="n1";} 	//Полное число витков пружины
      }
      :row
      {
        : edit_box {label ="t"; key ="t";}	//Шаг пружины в свободном состоянии, мм
        : edit_box {label ="L0"; key ="L0";}	//Высота пружины в свободном состоянии, мм
        : edit_box {label ="L4"; key ="L4";}	//Высота пружины при соприкосновении витков, мм
      }
    }
  }
  : boxed_row
  {
    label = "Х-ки материала";
    : edit_box {label ="G"; key ="G";}	//Модуль сдвига, МПа
    : edit_box {label ="[tau]"; key ="[tau]";}	//Допускаемое напряжение при кручении
  }
  : boxed_column
  {
    label = "Х-ки пружины";
    : row
    {
      : edit_box {label ="L1"; key ="L1";} 	//Высота пружины при предварительной деформации, мм
      : edit_box {label ="S1"; key ="S1";}	//Предварительная деформация пружины, мм
      : edit_box {label ="F1"; key ="F1";}	//Сила пружины при предварительной деформации, Н
      : edit_box {label ="tau1"; key ="tau1";}	//Напряжение при кручении при предварительной деформации, МПа
    }
    : row
    {
      : edit_box {label ="L2"; key ="L2";} 	//Высота пружины при рабочей деформации, мм
      : edit_box {label ="S2"; key ="S2";}	//Рабочая деформация пружины, мм
      : edit_box {label ="F2"; key ="F2";}	//Сила пружины при рабочей деформации, Н
      : edit_box {label ="tau2"; key ="tau2";}	//Напряжение при кручении при рабочей деформации, МПа
    }
    : row
    {
      : edit_box {label ="L3"; key ="L3";} 	//Высота пружины при максимальной деформации, мм
      : edit_box {label ="S3"; key ="S3";} 	//Максимальная деформация пружины, мм
      : edit_box {label ="F3"; key ="F3";}	//Сила пружины при максимальной деформации, Н
      : edit_box {label ="tau3"; key ="tau3";}	//Напряжение при кручении при максимальной деформации, МПа
    }
    : row
    {
      : edit_box {label ="h"; key ="h";} 	//Рабочий ход пружины, мм
      : edit_box {label ="C"; key ="C";}		//Жесткость пружины, Н/мм
    }
  }
  : boxed_column
  {
    label = "Некоторые коэфф.";
    : row
    {
      : edit_box {label ="K1"; key ="K1";}	//Коэффициент, учитывающий влияние кривизны витка
      : edit_box {label ="K2"; key ="K2";}	//Коэффициент, учитывающий влияние поперечной силы
      : edit_box {label ="i"; key ="i";}	//Индекс пружины
      : edit_box {label ="i1"; key ="i1";}	//Отношение длины пружины в свободном состоянии к её среднему диаметру
    }
    : row
    {
      : edit_box {label ="L"; key ="L";}	//Длина проволоки развернутой пружины, мм
      : edit_box {label ="Sk"; key ="Sk";}	//Толщина конца опорного витка пружины, мм
    }
  }
  ok_cancel;
  errtile;
}
     
     
sonya : dialog
{
 label = "Это диалог";
 : edit_box {label ="Соня, введи число!"; key ="L";}	//Длина проволоки развернутой пружины, мм
 ok_cancel;
}
