#include <stdio.h>

const char CONST_CR = '\r';
const char CONST_NL = '\n';

//Sacar \r antes de cada \r + \n

int main(int cantidadArgs, char* args[]){

	FILE* f_in = fopen(args[1], "r");
  if(!f_in) return 0;

	FILE* converted_file = fopen("out_u.txt", "w");

  if(!converted_file){
    fclose(f_in);
    return 0;
  }

	char character;

  while(!feof(f_in)){

    fread(&character, sizeof(char), 1, f_in);

    if(character == CONST_CR){
      fread(&character, sizeof(char), 1, f_in);
      if(character != CONST_NL)
        fwrite(&CONST_CR, 1, sizeof(char), converted_file);
    }

    fwrite(&character, 1, sizeof(char), converted_file);
  }

  fclose(f_in);
  fclose(converted_file);

	return 0;
}
