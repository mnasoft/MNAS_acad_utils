dcl_settings : default_dcl_settings { audit_level = 3; }

�������������_bak : dialog
{
 label = "����������� ��������������";
 aspect_ratio = 0;
 : column
 {
  : radio_row
  {  
   : radio_button
   { key="rb_1_7"; label="Ra";}
   : radio_button
   { key="rb_1_8"; label="Rz";}
  }
  : row
  {
   : toggle{key="tgl_1_11";}
   : edit_box   {label="��������";fixed_width = true ;edit_width = 20; width = 36; key="eb_1_1";}
   : popup_list {key ="pl_1_1"; fixed_width = true ; width = 20;}
  } 
  
  : row
  {
   : toggle{key="tgl_1_12";}
   : edit_box {label="������ ���������";fixed_width = true ;edit_width = 20; width = 36; key="eb_1_2";}
   : popup_list {key ="pl_1_2"; fixed_width = true ;width = 20; }
  }
  : edit_box {label="�������";key="eb_1_3";}
 }
 : row
 {
  : radio_column
  {  
   boxed=true;
   : radio_button   { key="rb_1_1";label="�� ������� �-��";}
   : radio_button   { key="rb_1_2";label="��� ������ �-��";}
   : radio_button   { key="rb_1_3";label="�����������";}
  }
  : column
  {
   boxed=true;
  	: radio_column
  	{
  	: radio_button {key="rb_1_4"; label="��� �������";}
  	: radio_button {key="rb_1_5"; label="� ������� �������";}
  	: radio_button {key="rb_1_6"; label="� ���������� �������";}
	}
   : toggle{key="tgl_1_2"; label="�� �������";}
   : toggle{key="tgl_1_3"; label="������������";}
  }
  : list_box {key="ppl_1_3";label="��� ����."; height=4; width=12;}
 }
 : row
 {
  : button {key="bt_1_1"; label="����������";}
  : button {key="bt_1_2"; label="�������";}
  : button {key="bt_1_3"; label="��������";}
 }
 ok_cancel;
 errtile;
}

edit_box_35_10 : edit_box {fixed_width=true; width=35; edit_width=10;}

popup_list_14 : popup_list {fixed_width = true; edit_width=14;}

������������� : dialog
{
 fixed_width_font = true;
 label = "����������� �������������� (���� 2789-73)";
 aspect_ratio = 0;
 : boxed_row
 {
  label="�������� � ���";
  : radio_row
  {: radio_button {key="rb_1_Ra"; label="Ra";}
   : radio_button {key="rb_1_Rz"; label="Rz";}
  }
  : popup_list_14 {key ="pl_1_RaRz"; label="���";}
 }
 :  boxed_column
 {label="�������� ���������";
  : row
  {: toggle{key="tgl_1_max_val";}
   : edit_box_35_10 {label="������������"; key="eb_1_max_val";}
   : popup_list_14 {key ="pl_1_max_val"; }
  }
  : row
  {: toggle{key="tgl_1_min_val";}
   : edit_box_35_10 {label="�����������"; key="eb_1_min_val";}
   : popup_list_14 {key ="pl_1_min_val"; }
  }
  : row
  {: toggle{key="tgl_1_spos_pol";}
   : edit_box_35_10 {label="������ ���������"; key="eb_1_spos_pol";}
   : popup_list_14 {key ="pl_1_spos_pol";}
  }
 }
 : row
 {
 : boxed_radio_column
  {label="������ ���. �-��";
   : radio_button   { key="rb_1_osn_ml_sn";label="����";}
   : radio_button   { key="rb_1_osn_ml_nesn";label="���";}
   : radio_button   { key="rb_1_osn_ml_neobr";label="�����������";}
  }
 : boxed_radio_column
 {label="������ ������ ";
  : radio_button {key="rb_1_bez_sk"; label="���  ������";}
  : radio_button {key="rb_1_kr_sk"; label="������� ()";}
  : radio_button {key="rb_1_kv_sk"; label="���������� []";}
  }
 }
 : row
 {: boxed_column
  {: toggle{key="tgl_1_po_konturu"; label="�� �������"; }
   : toggle{key="tgl_1_perevern"; label="������������";}
  }
  : boxed_row
  {label="����. �����������";
   : toggle{key="tgl_1_napr_miko_ner"; }
   : popup_list {key ="pl_1_napr_miko_ner"; }
  }
 }
 : boxed_row
 {label="�������";
 : edit_box {key="eb_1_masht";}
 : button {key="bt_1_masht"; label="�� ����.�����";}
 : popup_list {key ="pl_1_masht"; }
 }
 : row
 {: button {key="bt_1_1"; label="����������";}
  : button {key="bt_1_2"; label="�������";}
  : button {key="bt_1_3"; label="��������";}
 }
 ok_cancel;
 errtile;
}




/*
image_gold : image
{
 height=10;
 aspect_ratio=1.62;
 fiexd_width=true;
 fixed_height=true;
 color=0;
}
*/

/*
test_window: dialog
{
 label="���� ������������";
 :row
 {
  : image_gold
  { key="i_3_1";}
  : column
  {
   : button
   { key="b_3_1";
    label="������� �������";
   }
   : button
   { key="b_3_2";
    label="����������";
   }
  }
 }
 ok_only;
}
*/