#!/bin/bash

TEST_UNIX2DOS = "test_unix2dos_"
OUT_UNIX2DOS = "out_unix2dos_"
TEST_DOS2UNIX = "test_dos2unix_"
OUT_DOS2UNIX = "out_dos2unix_"

if [$1 = unix2dos]
then
	for num in {1..5} # se hacen 5 pruebas
	do
		echo "Prueba unix2dos $num"
		od -t c $TEST_UNIX2DOS$num.txt
		./unix2dos <$TEST_UNIX2DOS$num.txt> $OUT_UNIX2DOS_$num.txt
		od -t c $OUT_UNIX2DOS_$num.txt
	done
else
	for num in {1..5} # se hacen 5 pruebas
	do
		echo "Prueba dos2unix $num"
		od -t c $TEST_DOS2UNIX$num.txt
		./dos2unix <$TEST_DOS2UNIX$num.txt> $OUT_DOS2UNIX_$num.txt
		od -t c $OUT_DOS2UNIX_$num.txt
	done
fi
