#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

const char* archivo_in = "dos2unix_test.txt";
const char* archivo_out = "out_dos2unix_test.txt";

const char* OPEN_ERROR = "Error de apertura al abrir archivo";

const char CONST_CR = '\r';
const char CONST_NL = '\n';

int main(){
	
	// Nota: open no devuelve un puntero FILE si no que devuelve un file descriptor (int).

	int fd_in = open(archivo_in, O_RDONLY);

	if(fd_in == -1)
		write(2, OPEN_ERROR, 18);

	int fd_out = open(archivo_out, O_WRONLY);

	if(fd_out == -1){
		write(2, OPEN_ERROR, 18);
		close(fd_out);
		return 0;
	}

	char character;

	//read lee del file descriptor (1), la cantidad de caracteres (3) y lo guarda en buffer (2)

	while(read(fd_in, &character, 1)){

		if(character == CONST_CR){
      		read(fd_in, &character, 1);
      		if(character != CONST_NL)
        		write(fd_out, &character, 1);
    	}

    	write(fd_out, &character, 1);
	}

	close(fd_out);
	close(fd_in);
	return 0;
}