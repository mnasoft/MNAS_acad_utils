dcl_settings : default_dcl_settings { audit_level = 3; }

spring : dialog
{
  label = "������ ������� �� � ����.102.044-93";
  aspect_ratio = 0;
  :row
  {
    : boxed_column
    {
      label = "��������� �������";
      :row
      {
      	: edit_box {key ="d" ; label ="d, ��"; }   	//������� ���������, ��
      	: edit_box {key ="D1"; label ="D1, ��";} 	//������� ������� ��������, ��
      	: edit_box {key ="D" ; label="D, ��";}	 	//������� ������� �������, ��
      }
      :row
      {
        : edit_box {key ="n" ; label ="n";} 		//����� ������ �������
        : edit_box {key ="n1"; label ="n1";} 		//������ ����� ������ �������
      }
      :row
      {
        : edit_box {key ="t" ; label ="t, ��";}		//��� ������� � ��������� ���������, ��
        : edit_box {key ="L0"; label ="L0, ��";}	//������ ������� � ��������� ���������, ��
        : edit_box {key ="L4"; label ="L4, ��";}	//������ ������� ��� ��������������� ������, ��
      }
    }
  }
  : boxed_row
  {
    label = "�-�� ���������";
    : edit_box {key ="G"; label="G, ���";}		//������ ������, ���
    : edit_box {key ="[tau]"; label ="[tau], ���";}	//����������� ���������� ��� ��������, ���
  }
  : boxed_column
  {
    label = "�-�� �������";
    : row
    {
      : edit_box {key ="L1"; label ="L1, ��";} 		//������ ������� ��� ��������������� ����������, ��
      : edit_box {key ="S1"; label ="S1, ��";}		//��������������� ���������� �������, ��
      : edit_box {key ="F1"; label ="F1, �";}		//���� ������� ��� ��������������� ����������, �
      : edit_box {key ="tau1"; label ="tau1, ";}	//���������� ��� �������� ��� ��������������� ����������, ���
    }
    : row
    {
      : edit_box {key ="L2"; label ="L2, ��";} 		//������ ������� ��� ������� ����������, ��
      : edit_box {key ="S2"; label ="S2, ��";}		//������� ���������� �������, ��
      : edit_box {key ="F2"; label ="F2, �";}		//���� ������� ��� ������� ����������, �
      : edit_box {key ="tau2"; label ="tau2, ���";}	//���������� ��� �������� ��� ������� ����������, ���
    }
    : row
    {
      : edit_box {key ="L3"; label ="L3, ��";} 		//������ ������� ��� ������������ ����������, ��
      : edit_box {key ="S3"; label ="S3, ��";} 		//������������ ���������� �������, ��
      : edit_box {key ="F3"; label ="F3, �";}		//���� ������� ��� ������������ ����������, �
      : edit_box {key ="tau3"; label ="tau3, ���";}	//���������� ��� �������� ��� ������������ ����������, ���
    }
    : row
    {
      : edit_box {key ="h"; label ="h, ��";}	 	//������� ��� �������, ��
      : edit_box {key ="C"; label ="C, �/��";}		//��������� �������, �/��
    }
  }
  : boxed_column
  {
    label = "��������� �����.";
    : row
    {
      : edit_box {key ="K1"; label ="K1";}	//�����������, ����������� ������� �������� �����
      : edit_box {key ="K2"; label ="K2";}	//�����������, ����������� ������� ���������� ����
      : edit_box {key ="i"; label ="i";}	//������ �������
      : edit_box {key ="i1"; label ="i1";}	//��������� ����� ������� � ��������� ��������� � � �������� ��������
    }
    : row
    {
      : edit_box {key ="L"; label ="L, ��";}	//����� ��������� ����������� �������, ��
      : edit_box {key ="m"; label ="m, ��";}	//����� �������, ��
      : edit_box {key ="Sk"; label ="Sk, ��";}	//������� ����� �������� ����� �������, ��
    }
  }
  : cluster
  {
  : button {key = "Print"; label = "Print" ;}
  ok_cancel;
  : button {key = "about"; label = "� ���������..." ;}
  : button {key = "help"; label = "������" ;}
  }
  errtile;
}
