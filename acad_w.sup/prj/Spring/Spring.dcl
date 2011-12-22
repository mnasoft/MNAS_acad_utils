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
      	: edit_box {key ="d" ; label ="d, мм"; }   	//Диаметр проволоки, мм
      	: edit_box {key ="D1"; label ="D1, мм";} 	//Диаметр пружины наружный, мм
      	: edit_box {key ="D" ; label="D, мм";}	 	//Диаметр пружины средний, мм
      }
      :row
      {
        : edit_box {key ="n" ; label ="n";} 		//Число витков пружины
        : edit_box {key ="n1"; label ="n1";} 		//Полное число витков пружины
      }
      :row
      {
        : edit_box {key ="t" ; label ="t, мм";}		//Шаг пружины в свободном состоянии, мм
        : edit_box {key ="L0"; label ="L0, мм";}	//Высота пружины в свободном состоянии, мм
        : edit_box {key ="L4"; label ="L4, мм";}	//Высота пружины при соприкосновении витков, мм
      }
    }
  }
  : boxed_row
  {
    label = "Х-ки материала";
    : edit_box {key ="G"; label="G, МПа";}		//Модуль сдвига, МПа
    : edit_box {key ="[tau]"; label ="[tau], МПа";}	//Допускаемое напряжение при кручении, МПа
  }
  : boxed_column
  {
    label = "Х-ки пружины";
    : row
    {
      : edit_box {key ="L1"; label ="L1, мм";} 		//Высота пружины при предварительной деформации, мм
      : edit_box {key ="S1"; label ="S1, мм";}		//Предварительная деформация пружины, мм
      : edit_box {key ="F1"; label ="F1, Н";}		//Сила пружины при предварительной деформации, Н
      : edit_box {key ="tau1"; label ="tau1, ";}	//Напряжение при кручении при предварительной деформации, МПа
    }
    : row
    {
      : edit_box {key ="L2"; label ="L2, мм";} 		//Высота пружины при рабочей деформации, мм
      : edit_box {key ="S2"; label ="S2, мм";}		//Рабочая деформация пружины, мм
      : edit_box {key ="F2"; label ="F2, Н";}		//Сила пружины при рабочей деформации, Н
      : edit_box {key ="tau2"; label ="tau2, МПа";}	//Напряжение при кручении при рабочей деформации, МПа
    }
    : row
    {
      : edit_box {key ="L3"; label ="L3, мм";} 		//Высота пружины при максимальной деформации, мм
      : edit_box {key ="S3"; label ="S3, мм";} 		//Максимальная деформация пружины, мм
      : edit_box {key ="F3"; label ="F3, Н";}		//Сила пружины при максимальной деформации, Н
      : edit_box {key ="tau3"; label ="tau3, МПа";}	//Напряжение при кручении при максимальной деформации, МПа
    }
    : row
    {
      : edit_box {key ="h"; label ="h, мм";}	 	//Рабочий ход пружины, мм
      : edit_box {key ="C"; label ="C, Н/мм";}		//Жесткость пружины, Н/мм
    }
  }
  : boxed_column
  {
    label = "Некоторые коэфф.";
    : row
    {
      : edit_box {key ="K1"; label ="K1";}	//Коэффициент, учитывающий влияние кривизны витка
      : edit_box {key ="K2"; label ="K2";}	//Коэффициент, учитывающий влияние поперечной силы
      : edit_box {key ="i"; label ="i";}	//Индекс пружины
      : edit_box {key ="i1"; label ="i1";}	//Отношение длины пружины в свободном состоянии к её среднему диаметру
    }
    : row
    {
      : edit_box {key ="L"; label ="L, мм";}	//Длина проволоки развернутой пружины, мм
      : edit_box {key ="m"; label ="m, кг";}	//Масса пружины, кг
      : edit_box {key ="Sk"; label ="Sk, мм";}	//Толщина конца опорного витка пружины, мм
    }
  }
  : cluster
  {
  : button {key = "Print"; label = "Print" ;}
  ok_cancel;
  : button {key = "about"; label = "О программе..." ;}
  : button {key = "help"; label = "Помощь" ;}
  }
  errtile;
}
