#include <stdio.h>
#include <string.h>
#include "read.h"
#include "write.h"

#define max_size 2000

int main(int argsc, char* argv[]){
	// unix2dos
	FILE* f_in = fopen(argv[1], "r");
  	if(!f_in) return 0;
	
	char buffer[MAX_SIZE];
	buffer = read_dos_file(f_in, buffer);
	
	char file_out[80] = "out_";
	strcat(file_out, argv[1]);
	
	write_file(file_out, buffer);
	return 0;
}
