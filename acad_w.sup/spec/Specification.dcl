dcl_settings : default_dcl_settings { audit_level = 3; }

������� : dialog
{
 label = "�������������� � ����������� ������� ������������";
 aspect_ratio = 0;
 : row
 {
  : column
  {
   : edit_box {label = "�����";        edit_width = 25; key="e_1_0"; mnemonic="�";}
   spacer_1;
   : edit_box {label = "������������"; edit_width = 25; key="e_1_1"; mnemonic="�";}
   : edit_box {label = "�������";      edit_width = 25; key="e_1_2"; mnemonic="�";}
   : popup_list
   {
    label = "������";
    key="p_1_1";
    mnemonic="�";
    edit_width=25;
   }
   spacer_1;
   : edit_box {label = "������";       edit_width = 25; key="e_1_4"; mnemonic="�";}
   : edit_box {label = "����";         edit_width = 25; key="e_1_5"; mnemonic="�";}
   : edit_box {label = "�������";      edit_width = 25; key="e_1_6"; mnemonic="�";}
   : edit_box {label = "�����������";  edit_width = 25; key="e_1_7"; mnemonic="�";}
   : edit_box {label = "������������"; edit_width = 25; key="e_1_8"; mnemonic="�";}
   : edit_box {label = "����������";   edit_width = 25; key="e_1_9"; mnemonic="�";}
   : edit_box {label = "����������";   edit_width = 25; key="e_1_10"; mnemonic="�";}
  }
  : column
  {
   children_alignment=left;
   : button { label="���������";  mnemonic="�"; key="b_1_1";} 
   : edit_box {label = "�������"; edit_width = 5; key="e_1_11"; mnemonic="�";}

   : popup_list
   {
    label="���";
    key="p_1_2";
    list="������\n�����\n�������";  
    edit_width=10;
    mnemonic="�";
   }

   : button { label="�������";  key="b_1_5"; mnemonic="�";}
   : button { label="�������";  key="b_1_6"; mnemonic="�";}
   : button { label="��������"; key="b_1_7"; mnemonic="�";}
   : button { label="��|�����";  key="b_1_8"; mnemonic="�";}
   : button { label="���������";  key="b_1_9"; mnemonic="�";}
   : button { label="������������";  key="b_1_10";}
   : button { label="�����. ����";  key="b_1_11";}
  }
 }
 spacer_1;
 ok_cancel_help_info;
 errtile;
}

��������� : dialog
{
 : row
 {
  : column
  {
   : boxed_column
   {
    label="��������� �����������";
    : radio_column
    { 
     : radio_button {key="r_2_1"; label="a) ������+�����"; mnemonic="a";}
     : radio_button {key="r_2_2"; label="b) ����� ������+�����������"; mnemonic="b";}
     : radio_button {key="r_2_3"; label="c) �����+����� ������"; mnemonic="c";}
     : radio_button {key="r_2_4"; label="d) ������������� ������_�����������"; mnemonic="d";}
     : radio_button {key="r_2_5"; label="e) �������������+����� ������"; mnemonic="e";}
   }
   : row
   {
    : button { label="������";    key="b_2_1"; mnemonic="�";}
    : button { label="��������";  key="b_2_2"; mnemonic="�";}
   }
  }//boxed_column
  : boxed_row
   {label="����������� �����";
    : button { label="������";  key="b_2_4";}
    : button { label="��������";  key="b_2_5";}
   }
  }
  : column
  {
   : boxed_column
   {label="���������� �������";
    : radio_column
    {   
    : radio_button {key="r_2_6"; label="f) �� ���������"; mnemonic="f";}
    : radio_button {key="r_2_7"; label="g) �� �������"; mnemonic="g";}
    : radio_button {key="r_2_8"; label="h) �� \"��������������\""; mnemonic="h";}
    : radio_button {key="r_2_9"; label="i) �� �����������"; mnemonic="i";}
    }
   }
   : boxed_column
   {label="��� �������";
    : radio_column
    {   
    : radio_button {key="r_2_10"; label="j) ��� ������������"; mnemonic="j";}
    : radio_button {key="r_2_11"; label="k) �� �������������"; mnemonic="k";}
    }
   }
   : boxed_column
   {label="�������������� ����������";
    : toggle { label="���� �����"; key="t_2_1"; mnemonic="�";}
    : toggle { label="������������ �� �����������"; key="t_2_2"; mnemonic="�";}
    : toggle { label="���� �������"; key="t_2_3"; mnemonic="�";}
   }
  }//column
 }//row
 ok_cancel;
 errtile;
}

���� : dialog
{
 : row
 {
  : popup_list
  {
   label="������������";
   key="p_3_1";
   list="1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n15\n16\n17\n18\n19";  
   edit_width=10;
   mnemonic="�";
  }
  : popup_list
  {
   label="�������";
   key="p_3_2";
   list="1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n15\n16\n17\n18\n19";  
   edit_width=10;
  }
  : popup_list
  {
   label="������";
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
   : button { label="���_���";      key="b_3_1"; mnemonic="�";}
   : button { label="���_���";      key="b_3_2"; mnemonic="�";}
   : button { label="�������";      key="b_3_3"; mnemonic="�";}
   : button { label="������.";      key="b_3_4"; mnemonic="�";}
   : button { label="����.";        key="b_3_5"; mnemonic="�";}
   : button { label="�������";      key="b_3_6"; mnemonic="�";}
   : button { label="�����. ���.";  key="b_3_7"; mnemonic="�";}
   : button { label="<";            key="b_3_8"; mnemonic="<";}
   : button { label=">";            key="b_3_9"; mnemonic=">";}
  }
 }
 : column
 {
   : edit_box {label = "������";       edit_width = 25; key="e_3_4"; mnemonic="�";}
   : edit_box {label = "����";         edit_width = 25; key="e_3_5"; mnemonic="�";}
   : edit_box {label = "�������";      edit_width = 25; key="e_3_6"; mnemonic="�";}
   : edit_box {label = "�����������";  edit_width = 25; key="e_3_7"; mnemonic="�";}
   : edit_box {label = "������������"; edit_width = 25; key="e_3_8"; mnemonic="�";}
   : edit_box {label = "����������";   edit_width = 25; key="e_3_9"; mnemonic="�";}
   : edit_box {label = "����������";   edit_width = 25; key="e_3_10"; mnemonic="�";}
   }
 : row { ok_cancel;}
 errtile;
}

���� : dialog
{
 label="��������� ������ ��� ������������";
 children_fixed_height=true;
 children_fixed_width=true;
 : row
 {
  : button { key="b_4_1"; label="������� ������"; width=25; }
  : text   { key="t_4_1"; width=10;}
  : image_button { key="i_4_1"; height = 2; width=10; }
 }
 : row
 {
  : button { key="b_4_2"; label="����� �������"; width=25; }
  : text   { key="t_4_2"; width=10; }
  : image_button { key="i_4_2"; height = 2; width=10;}
 }
 : row
 {
  : button { key="b_4_3"; label="�����"; width=25;}
  : text   { key="t_4_3"; width=10; }
  : image_button { key="i_4_3"; height = 2; width=10; }
 }
 : row
 {
  : button { key="b_4_4"; label="����� �������"; width=25;}
  : text   { key="t_4_4"; width=10; }
  : image_button { key="i_4_4"; height = 2; width=10;}
 }
 children_fixed_height=false;
 children_fixed_width=false;
 ok_cancel;
}

����_������ : dialog
{
 label = "���� ������ ����������";
 : boxed_column 
 {label = "������� ������";
  : row
  {
   : column
   {
    : text { label="������";}
    : edit_box { key="e_5_1"; value="*"; }
   }
   : column 
   {
    : text { label="�����������";}
    : edit_box  {key="e_5_2"; value="*"; }
   }
   :column 
   {  
    : text { label="������������";}
    : edit_box  { key="e_5_3"; value="*"; }
   }
  }
  : row
  {
   :column 
   {  
    : text { label="����������";}
    : edit_box  { key="e_5_4"; value="*"; }
   }
   :column 
   {  
    : text { label="��������";}
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
   label="������";
   : edit_box  { label="������"; key="e_5_6";}
   : edit_box  { label="�����������"; key="e_5_7";}
   : edit_box  { label="������������"; key="e_5_8";}
   : edit_box  { label="��������"; key="e_5_9";}
   : edit_box  { label="����������"; key="e_5_10";}
   : edit_box  { label="��������"; key="e_5_11";}
  }
 : boxed_column
  {
   label="��������";
   : button  { label="��������"; key="b_5_1";}
   : button  { label="�������"; key="b_5_2";}
   : button  { label="��������"; key="b_5_3";}
   : button  { label="���. ������"; key="b_5_4";}
   : button  { label="���������"; key="b_5_5";}
  } 
 }
 spacer_1;
 ok_cancel_help_info;
 errtile;
}