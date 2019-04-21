#include <stdio.h>
#include <string.h>

int write_file(char* name_file, char* buffer){
	// write buffer in file
	FILE* f_out = fopen(name_file, "w");

	if (!f_out) return 0;

	fwrite(buffer, strlen(buffer) + 1, sizeof(char), f_out);

	fclose(f_out);

	return 0;
}
