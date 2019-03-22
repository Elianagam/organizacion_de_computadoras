#include <stdio.h>
#include <stdlib.h>

const char CONST_R = '\r';

//Agregar \r antes de cada \n

int main(){

	FILE* f_in = fopen("linuxToWindowsTest.txt", "r");
	FILE* f_out = fopen("out_w.txt", "w");

	char r_char;
	char const_r = '\r';

	while(!feof(f_in)){

		fread(&r_char, sizeof(char), 1, f_in);
		if(r_char == '\n')
			fwrite(&const_r, 1, sizeof(char), f_out);

		fwrite(&r_char, 1, sizeof(char), f_out);
	}

	fclose(f_in);
	fclose(f_out);

	return 0;
}
