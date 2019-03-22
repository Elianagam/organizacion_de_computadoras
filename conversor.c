#include <stdio.h>
#include <stdlib.h>

int main(){

	FILE* archivoDeMierda = fopen("pruebaWindows.txt", "r");
	char caracter;
	char* buffer = malloc(200 * sizeof(char));

	if(archivoDeMierda == NULL){
		fclose(archivoDeMierda);
		return 0;
	}
	
	int i = 0;

	//Windows a linux : borrar el \r
	while(!feof(archivoDeMierda)){

		fread(&caracter, sizeof(char), 1, archivoDeMierda);

		if (caracter != '\r'){
			buffer[i] = caracter;
			i++;	

		}else{
			printf("un bufer: %s \n", buffer);
			i = 0;
			for(int j = 0; j < 200; j++)
				buffer[j] = ' ';
		}
	}

	printf("Se leyo: %s \n", buffer);

	fclose(archivoDeMierda);
	//free(buffer);

	return 0;
}

