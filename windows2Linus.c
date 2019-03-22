#include <stdio.h>
#include <stdlib.h>

#define REDIM 2

int main(){

	FILE* file = fopen("pruebaWindows.txt", "r");
	FILE* converted_file = fopen("salida.txt", "w+");
	char character;
	long buffer_size = 200;
	char* buffer = malloc(buffer_size * sizeof(char));

	if(!file){
		fclose(file);
		free(buffer);
		return 0;
	}
	
	int i = 0;
	int j;

	//Windows2Linux 
	while(!feof(file)){

		fread(&character, sizeof(char), 1, file);

		if (character != '\r'){
			if (i == buffer_size){
				char* aux_buffer = malloc(buffer_size * REDIM * sizeof(char));
				for (j = 0; j<buffer_size; j++){
					aux_buffer[j] = buffer[j];
					free(buffer);
					buffer = aux_buffer;
				}
				buffer_size = buffer_size * REDIM;
			}
			buffer[i] = character;
			i++;	
		}else{
			fwrite(buffer, 1, sizeof(buffer), converted_file );
			//printf("un bufer: %s \n", buffer);
			i = 0;
			for(int j = 0; j < 200; j++)
				buffer[j] = '\0';
		}
	}

	fclose(file);
	free(buffer);

	return 0;
}

