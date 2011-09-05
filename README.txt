1.      Инструкция по установке и настройке комплекса программ 
		MNAS_acad_utils
		для Администратора
		
1.1		Установите пакет mnas_acad_db17_utils-2.7.6.1.exe

1.2		Запустите ACAD.

1.3		При помощи команды APPLOAD загрузите приложение к ACAD
		"C:\Program Files\MNASoft\MNAS_acad_utils\vlx\M_utils_loader.VLX"
		
1.4		Выполните команду ACAD   MNASOFT-REGISTRY-INSTALL.

1.5		Процедура установки комплекса программ MNAS_acad_utils завершена.

1.6		Завершите сеанс работы с ACAD.

1.7		Если Вы собираетесь работать под Административной записью
		в ACAD с использованием комплекса программ 
		MNAS_acad_utils - выполните шаги описанные в п.2
		

2.      Инструкция по настройке комплекса программ 
		MNAS_acad_utils
		для Пользователя ACAD
		
2.1     Если вы переходите из версии MNAS_acad_db17_utils-2.3 
		или более ранней - удалите из системного реестра папку 
		HKEY_CURRENT_USER\Software\MNASoft.
		
2.2		Запустите ACAD.

2.3		В диалоге, вызываемом при помощи команды _options добавьте пути 
        для поиска файлов поддержки ACAD:
2.3.1   "C:\Program Files\MNASoft\MNAS_acad_utils" ;
2.3.2   "C:\Program Files\MNASoft\MNAS_acad_utils\acad_fnt" ;
2.3.3   "C:\Program Files\MNASoft\MNAS_acad_utils\acad_fnt\kompas";
2.3.4	"C:\Program Files\MNASoft\MNAS_acad_utils\acad.mnu\acad_mnu_icon" .

2.4     При помощи команды _cui добавьте частичное меню:
		"C:\Program Files\MNASoft\MNAS_acad_utils\acad.mnu\MNASoft.cui"
		
2.5		Завершите сеанс работы с ACAD.

2.6		Повторно запустите ACAD.

2.7		Список команд, определенных в комплексе программ MNAS_acad_utils,
		и их краткое описание можно просмотреть, вызвав команду MAN.
		
2.8		Приятной работы с использованием комплекса программ MNAS_acad_utils.


3.		Инструкция по деинсталяции комплекса программ 
		MNAS_acad_utils
		для Пользователя ACAD

3.1		Запустите ACAD.

3.2		При помощи команды _cui отгрузите частичное меню MNASoft.

3.3		При помощи команды _options удалите пути, добавленные в п. 2.3.

3.4		Приятной работы без использования комплекса программ MNAS_acad_utils.

4.		Инструкция по деинсталяции комплекса программ 
		MNAS_acad_utils
		для Администратора
		
4.1		Запустите ACAD.

4.2		При помощи команды APPLOAD загрузите приложение к ACAD
		"C:\Program Files\MNASoft\MNAS_acad_utils\vlx\M_utils_loader.VLX"
		
4.3		Выполните команду ACAD   MNASOFT-REGISTRY-UNINSTALL.

4.4		Используя диалог "Установка и удаление программ" "Панели инструментов"
		удалите комплекс программ MNAS_acad_utils.