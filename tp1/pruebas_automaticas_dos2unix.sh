#!/usr/pkg/bin/bash





  echo Running dos2unix testings...
        i=1
	while [ "$i" -le $1 ]; do
    		./dos2unix <test_dos2unix_$i.txt >temp.a.$i.txt || break
    		./unix2dos <temp.a.$i.txt >temp.b.$i.txt || break
    		diff -q test_dos2unix_$i.txt temp.b.$i.txt || break
    		echo Ok: $i;
    		rm -f temp.*
                i=$(( i + 1 ))
	done

        if [ "$i" -le $1 ]
	then
   		echo Error: $i
	fi
  














  



