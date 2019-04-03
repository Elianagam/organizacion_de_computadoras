#include <stdio.h>

const char CONST_CR = '\r';
const char CONST_NL = '\n';

//Agregar \r antes de cada \n

int main(int argsc, char* argv[]){

	FILE* f_in = fopen(argv[1], "r");
  	if(!f_in) return 0;

	FILE* f_out = fopen("out_w.txt", "w");

	if (!f_out){
		fclose(f_in);
		return 0;
	}

	char character;

	while(!feof(f_in)){

		fread(&character, sizeof(char), 1, f_in);
		if(character == CONST_NL)
			fwrite(&CONST_CR, 1, sizeof(char), f_out);

		fwrite(&character, 1, sizeof(char), f_out);
	}

	fclose(f_in);
	fclose(f_out);

	return 0;
}
