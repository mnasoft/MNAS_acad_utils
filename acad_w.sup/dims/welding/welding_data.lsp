(setq key_list '("wt:�����������"              "wt:�����������"              "wt:����_�������_��_�����"    "wt:����_�������_������_�����"
                 "wt:�������_�����������"      "wt:�������_���������"        "wt:��_�������_����������"    "wt:��_�������_������������"
                 "wt:��_�������_��_�����"      "wt:���������_��"             "wt:���������_���"            "wt:�����_���������"
                 "wt:������_�����_���������p���"                             "wt:�����_���"                "wt:������_�����_����"
                 "wt:����_������"              "wt:������_����_������"       "wt:�����_t"                  "wt:�����_eb"
                 "wt:������_���_�����"         "wt:������_������_���_������" "wt:������_�����_t"           "wt:������_�����_eb"
                 "wt:���������"                "wt:������_���������"         "wt:��������"                 "wt:������_����������"
                 "wt:������_���_����"          "wt:������_������_���_������" "wt:������_�����_t"           "wt:������_�����_eb"
                 "����������"                  "���������"                   "���������"                   "�������"
                 "��������"))

(setq ll_welding_setup
       '(("wt:�����������" "")
         ("wt:�����������" "")
         ("wt:����_�������_��_�����" "1")
         ("wt:����_�������_������_�����" "0")
         ("wt:�������_�����������" "1")
         ("wt:�������_���������" "0")
         ("wt:��_�������_����������" "0")
         ("wt:��_�������_������������" "0")
         ("wt:��_�������_��_�����" "1")
         ("wt:���������_��" "0")
         ("wt:���������_���" "1")
         ("wt:�����_���������" "1")
         ("wt:������_�����_���������p���" "0" ("��� �" "��� �" "��� �" "��� �" "��� �"))
         ("wt:�����_���" "1")
         ("wt:������_�����_����"
          "0"
          ("�1" "�2" "�3" "�4" "�6" "�7" "�8" "�9" "�11" "�12" "�15" "�17" "�18" "�20" "�21" "�25" "�1" "�3" "�4" "�5" "�6" "�8" "�9" "�1" "�2" "�3"
           "�4" "�6" "�7" "�8" "�1" "�2"))
         ("wt:����_������" "1")
         ("wt:������_����_������" "0" ("�" "��" "���" "��" "��"))
         ("wt:�����_t" "0")
         ("wt:�����_eb" "1.5")
         ("wt:������_������_���_������" "0" ("��� ���. ��." "������. �����" "�����. �����."))
         ("wt:������_�����_t" "0")
         ("wt:������_�����_eb" "20")
         ("wt:���������" "1")
         ("wt:������_���������" "0" ("I" "II" "III" "IV"))
         ("wt:��������" "1")
         ("wt:������_����������"
          "0"
          ("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15" "16" "17" "18"))
         ("wt:������_������_���_������" "0" ("��� ���. ��." "������. �����" "�����. �����."))
         ("wt:������_�����_t" "0")
         ("wt:������_�����_eb" "20")))

(setq standart      '(("��� �"
                       "���� 5264-80. ������ ������� ������. ���������� �������. �������� ����, �������������� �������� � �������.")
                      ("��� �"
                       "���� 11534-75. ������ ������� ������. ���������� ������� ��� ������ � ������ ������. �������� ����, �������������� �������� � �������.")
                      ("��� �"
                       "���� 14771-76. ������� ������ � �������� ����. ���������� �������. �������� ����, �������������� �������� � �������.")
                      ("��� �"
                       "���� 23518-79. ������� ������ � �������� �����. ���������� ������� ��� ������ � ������ ������. �������� ����, �������������� �������� � �������.")
                      ("��� �"
                       "���� 14806-80. ������� ������ �������� � ����������� ������� � ������� �����. ���������� �������. �������� ����, �������������� �������� � �������."))
      sposob_svarki '(("�" "������� ������ ������� ����������")
                      ("��" "������� ������ � �������� ����� ������������ ���������� ��� ������������ �������")
                      ("���" "������� ������ � �������� ����� ������������ ���������� � ����������� ��������")
                      ("��"
                       "������� ������ � �������� ����� � �� ������ � ���������� ����� � ���������� ���������� ����������")
                      ("��" "������� ������ � ���������� ���� � ��� ����� � ���������� ���������� ����������"))
      kategoryja    '(("I" "����� ������������� � ������������ � P>2.5���") ("II" "") ("III" "") ("IV" ""))
      komplex       '(("1" "")
                      ("2" "")
                      ("3" "")
                      ("4" "")
                      ("5" "")
                      ("6" "")
                      ("7" "")
                      ("8" "")
                      ("9" "")
                      ("10" "")
                      ("11" "")
                      ("12" "")
                      ("13" "")
                      ("14" "")
                      ("15" "")
                      ("16" "")
                      ("17" "")
                      ("18" ""))
      obozn_shva    '(("�1" "")
                      ("�2" "")
                      ("�3" "")
                      ("�4" "")
                      ("�6" "")
                      ("�7" "")
                      ("�8" "")
                      ("�9" "")
                      ("�11" "")
                      ("�12" "")
                      ("�15" "")
                      ("�17" "")
                      ("�18" "")
                      ("�20" "")
                      ("�21" "")
                      ("�25" "")
                      ("�1" "")
                      ("�3" "")
                      ("�4" "")
                      ("�5" "")
                      ("�6" "")
                      ("�8" "")
                      ("�9" "")
                      ("�1" "")
                      ("�2" "")
                      ("�3" "")
                      ("�4" "")
                      ("�6" "")
                      ("�7" "")
                      ("�8" "")
                      ("�1" "")
                      ("�2" ""))
      dop_znaki     '(("������. �����" "") ("�����. �����." "")))
