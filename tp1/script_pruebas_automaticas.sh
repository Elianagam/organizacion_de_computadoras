#!/bin/bash

TEST_UNIX2DOS = "test_unix2dos_"
TEST_DOS2UNIX = "test_dos2unix_"

if [$1 = unix2dos]

then
  echo Running testings unix2dos...
  
	for ((i=1; i<=$2; i++)); do
		./unix2dos <$TEST_UNIX2DOS$i.txt >temp.a.$i.txt || break
    ./dos2unix <$out.txt >temp.b.$i.txt || break
    diff -q $TEST_UNIX2DOS$i.txt temp.b.$i.txt || break
    echo Ok: $i;
    rm -f temp.*
  done
  
done; echo Error: $i

else
echo Running testings dos2unix...

  for ((i=1; i<=$2; i++)); do
		./dos2unix <$TEST_DOS2UNIX$i.txt >temp.a.$i.txt || break
    ./unix2dos <temp.a.$i.txt >temp.b.$i.txt || break
    diff -q $TEST_DOS2UNIX$i.txt temp.b.$i.txt || break
    rm -f temp.*
    echo Ok: $i;
  done
  
done; echo Error: $i

fi
