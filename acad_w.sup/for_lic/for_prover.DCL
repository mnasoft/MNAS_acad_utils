dcl_settings : default_dcl_settings { audit_level = 3; }
	 
	 
for_prover : dialog
{
 label = "����������� ������ ������������ ��������";
 aspect_ratio = 0;
 : row
 {
   : column
   {
     : edit_box {label="������� �����, [��]"; key="f_pr-dc";}
     : edit_box {label="������� �������������� �������, [��]"; key="f_pr-dbx";}
     : edit_box {label="���������� �������������� �������, [��]"; key="f_pr-n";}
     : edit_box {label="������ ����� ��������, [��]"; key="f_pr-r";}
     : edit_box {label="���� ������� �������������� �������, [����]"; key="f_pr-beta";}
     : edit_box {label="���� ������ ��� �����, [����]"; key="f_pr-psi";}
     : edit_box {label="������� ��������, [���]"; key="f_pr-dp";}
     : edit_box {label="��������� �������, [��/�^3]"; key="f_pr-ro";}
     : edit_box {label="����������� �������������� ��������, [���]"; key="f_pr-nu";}
   }
   : image {key="f_pr-image"; width=50; aspect_ratio =0.6;}
 }
 ok_cancel;
 errtile;
}