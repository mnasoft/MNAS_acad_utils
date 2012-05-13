#include <ios>
#include <iostream>
#include <fstream>
#include <string>

#define uint unsigned int

int main()
{
	std::string line; //Строка ввода.
	std::string dir_name; //Имя директории.
	std::string file_name; //Имя файла.
	std::string file_name_ext=""; //Расширение файла.
	std::string prev_file_name_ext=""; //Предыдущее обработанное расширение файла.
	
	uint len_line=0;//Длина строки ввода.
	
	std::fstream inst;
	std::fstream uninst;

	inst.open("./inst.tmp", std::ios::out);
	uninst.open("./un.inst.tmp", std::ios::out);
	
	while(std::cin)
	{
		std::getline(std::cin, line);
		
		len_line=line.length();
		uint len_dir_name=line.find_last_of('/', len_line);//Поиск положения символа разделителя для пути.
		uint len_file_name_ext=line.find_last_of('.', len_line);//Поиск положения символа разделителя для расширения.
	
		if(	len_dir_name<len_line && 
			len_dir_name<len_file_name_ext && 
			len_file_name_ext<len_line)
		{
			dir_name=line.substr(0, len_dir_name);
			file_name=line.substr(len_dir_name+1, len_line-len_dir_name-1);
			file_name_ext=line.substr(len_file_name_ext+1, len_line-len_file_name_ext-1);
			
			if (prev_file_name_ext != file_name_ext)
			{
				if(prev_file_name_ext=="")
				{
					inst<<"Section "<<'"'<<file_name_ext<<'"'<<std::endl;
					uninst<<"Section "<<'"'<<"un."<<file_name_ext<<'"'<<std::endl;
				}
				else
				{
					inst<<"SectionEnd"<<std::endl;
					inst<<"Section "<<'"'<<file_name_ext<<'"'<<std::endl;
					uninst<<"SectionEnd"<<std::endl;
					uninst<<"Section "<<'"'<<"un."<<file_name_ext<<'"'<<std::endl;
				}
			}
			prev_file_name_ext=file_name_ext;
			
			inst<<"  SetOutPath $INSTDIR/"<<dir_name<<std::endl;
			inst<<"  File "<<line<<std::endl;
		
			uninst<<"  Delete $INSTDIR/"<<line<<std::endl;
		}
	}
	inst<<"SectionEnd"<<std::endl;
	uninst<<"SectionEnd"<<std::endl;
	
	inst.close();
	uninst.close();
}
