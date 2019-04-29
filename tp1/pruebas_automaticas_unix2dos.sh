#!/usr/pkg/bin/bash

  echo Running dos2unix testings...
        i=1
	while [ "$i" -le $1 ]; do
    		./unix2dos <test_unix2dos_$i.txt >temp.a.$i.txt || break
    		./dos2unix <temp.a.$i.txt >temp.b.$i.txt || break
    		diff -q test_unix2dos_$i.txt temp.b.$i.txt || break
    		echo Ok: $i;
    		rm -f temp.*
                i=$(( i + 1 ))
	done

        if [ "$i" -le $1 ]
	then
   		echo Error: $i
	fi
  














  



