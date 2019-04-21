#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

const char* archivo_in = "unix2dos_test.txt";
const char* archivo_out = "out_unix2dos_test.txt";

const char* OPEN_ERROR = "Error de apertura al abrir archivo";

const char CONST_CR = '\r';
const char CONST_NL = '\n';

int main(){

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

	while(read(fd_in, &character, 1)){

      	if(character == CONST_NL)
        	write(fd_out, &CONST_CR, 1);

    	write(fd_out, &character, 1);
	}

	close(fd_out);
	close(fd_in);
	return 0;
}