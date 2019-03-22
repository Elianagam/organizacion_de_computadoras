#include <stdio.h>
#include <stdlib.h>

int main(){

	FILE* archivoDeMierda = fopen("pruebaWindows.txt", "r");
	char leido[30];

	if(archivoDeMierda == NULL)
		printf("No se abrio");

	while(!feof(archivoDeMierda)){

		fread(leido, sizeof(char), 1, archivoDeMierda); 
		printf("Se leyo: %s \n", leido);
	}

	fclose(archivoDeMierda);

	return 0;
}
