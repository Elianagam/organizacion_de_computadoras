#include <stdio.h>
#include <stdlib.h>

#define  CONST_R

//Agregar \r antes de cada \n

int main(){

	FILE* f_in = fopen("linuxToWindowsTest.txt", "r");
	FILE* f_out = fopen("out_w.txt", "w+");

	char r_char;

	while(!feof(file)){

		fread(&r_char, sizeof(char), 1, file);
		if(r_char == '\n')
			fwrite(CONST_R, 1, sizeof(char), f_out);

		fwrite(&r_char, 1, sizeof(char), f_out);
	}

	fclose(f_in);
	fclose(f_out);

	return 0;
}
