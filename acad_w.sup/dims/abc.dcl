dcl_settings : default_dcl_settings { audit_level = 3; }

начальный_индекс : dialog
{
 label = "Начальный индекс";
 : row {
 : list_box {key ="lb_1_1"; }
 : list_box {key ="lb_1_2"; tabs = "5 10";}
 }
  : button {key="bt_1_1"; label="Указать";}
 
 ok_cancel;
 errtile;
}

