dcl_settings : default_dcl_settings { audit_level = 3; }
	 
	 
for_prover : dialog
{
 label = "Проверочный расчет центробежной форсунки";
 aspect_ratio = 0;
 : row
 {
   : column
   {
     : edit_box {label="Диаметр сопла, [мм]"; key="f_pr-dc";}
     : edit_box {label="Диаметр тангенциальных каналов, [мм]"; key="f_pr-dbx";}
     : edit_box {label="Количество тангенциальных каналов, [мм]"; key="f_pr-n";}
     : edit_box {label="Радиус плеча закрутки, [мм]"; key="f_pr-r";}
     : edit_box {label="Угол наклона тангенциальных каналов, [град]"; key="f_pr-beta";}
     : edit_box {label="Угол конуса при сопле, [град]"; key="f_pr-psi";}
     : edit_box {label="Перепад давления, [бар]"; key="f_pr-dp";}
     : edit_box {label="Плотность топлива, [кг/м^3]"; key="f_pr-ro";}
     : edit_box {label="Коэффициент кинематической вязкости, [сСт]"; key="f_pr-nu";}
   }
   : image {key="f_pr-image"; width=50; aspect_ratio =0.6;}
 }
 ok_cancel;
 errtile;
}