#include <ios>
#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>

int main()
{
	std::string line; //Строка ввода.

	while(std::cin)
	{
		std::getline(std::cin, line);
		reverse(line.begin(),line.end());
		std::cout<<line<<std::endl;
	}
  return 0;
}
