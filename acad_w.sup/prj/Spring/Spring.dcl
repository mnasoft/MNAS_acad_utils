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
      	: edit_box {key ="d"; label ="d"; }   	//������� ���������, ��
      	: edit_box {label ="D1"; key ="D1";} 	//������� ������� ��������, ��
      	: edit_box {label ="D"; key ="D";} 	//������� ������� �������, ��
      }
      :row
      {
        : edit_box {label ="n"; key ="n";} 	//����� ������ �������
        : edit_box {label ="n1"; key ="n1";} 	//������ ����� ������ �������
      }
      :row
      {
        : edit_box {label ="t"; key ="t";}	//��� ������� � ��������� ���������, ��
        : edit_box {label ="L0"; key ="L0";}	//������ ������� � ��������� ���������, ��
        : edit_box {label ="L4"; key ="L4";}	//������ ������� ��� ��������������� ������, ��
      }
    }
  }
  : boxed_row
  {
    label = "�-�� ���������";
    : edit_box {label ="G"; key ="G";}	//������ ������, ���
    : edit_box {label ="[tau]"; key ="[tau]";}	//����������� ���������� ��� ��������
  }
  : boxed_column
  {
    label = "�-�� �������";
    : row
    {
      : edit_box {label ="L1"; key ="L1";} 	//������ ������� ��� ��������������� ����������, ��
      : edit_box {label ="S1"; key ="S1";}	//��������������� ���������� �������, ��
      : edit_box {label ="F1"; key ="F1";}	//���� ������� ��� ��������������� ����������, �
      : edit_box {label ="tau1"; key ="tau1";}	//���������� ��� �������� ��� ��������������� ����������, ���
    }
    : row
    {
      : edit_box {label ="L2"; key ="L2";} 	//������ ������� ��� ������� ����������, ��
      : edit_box {label ="S2"; key ="S2";}	//������� ���������� �������, ��
      : edit_box {label ="F2"; key ="F2";}	//���� ������� ��� ������� ����������, �
      : edit_box {label ="tau2"; key ="tau2";}	//���������� ��� �������� ��� ������� ����������, ���
    }
    : row
    {
      : edit_box {label ="L3"; key ="L3";} 	//������ ������� ��� ������������ ����������, ��
      : edit_box {label ="S3"; key ="S3";} 	//������������ ���������� �������, ��
      : edit_box {label ="F3"; key ="F3";}	//���� ������� ��� ������������ ����������, �
      : edit_box {label ="tau3"; key ="tau3";}	//���������� ��� �������� ��� ������������ ����������, ���
    }
    : row
    {
      : edit_box {label ="h"; key ="h";} 	//������� ��� �������, ��
      : edit_box {label ="C"; key ="C";}		//��������� �������, �/��
    }
  }
  : boxed_column
  {
    label = "��������� �����.";
    : row
    {
      : edit_box {label ="K1"; key ="K1";}	//�����������, ����������� ������� �������� �����
      : edit_box {label ="K2"; key ="K2";}	//�����������, ����������� ������� ���������� ����
      : edit_box {label ="i"; key ="i";}	//������ �������
      : edit_box {label ="i1"; key ="i1";}	//��������� ����� ������� � ��������� ��������� � � �������� ��������
    }
    : row
    {
      : edit_box {label ="L"; key ="L";}	//����� ��������� ����������� �������, ��
      : edit_box {label ="Sk"; key ="Sk";}	//������� ����� �������� ����� �������, ��
    }
  }
  ok_cancel;
  errtile;
}
     
     
sonya : dialog
{
 label = "��� ������";
 : edit_box {label ="����, ����� �����!"; key ="L";}	//����� ��������� ����������� �������, ��
 ok_cancel;
}
