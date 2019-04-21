#include <stdio.h>
#include <string.h>

const char CONST_NL = '\n';
const char CONST_CR = '\r';

char* read_unix_file(FILE* file_read, char* buffer){
    // return buffer with line
    
    int i = 0;
    char character;
    while(!feof(file_read)) {
	fread(&character, sizeof(char), 1, file_read);	
	if(character == CONST_NL)
	    buffer[i++] = CONST_CR;
	    
	buffer[i++] = character;
    }
    buffer[i] = '\0';
    return buffer;
}

char* read_dos_file(FILE* file_read, char* buffer){
    // return buffer with line
    int i = 0;
    char character;
    while(!feof(file_read)){
       fread(&character, sizeof(char), 1, file_read);

	if(character == CONST_CR){
      	    fread(&character, sizeof(char), 1, file_read);
      	    if(character != CONST_NL)
		buffer[i++] = CONST_CR;
	}
	buffer[i++] = character;
    }
    buffer[i] = '\0';
    return buffer;
}
