#!/bin/bash

# esto se ejecuta como ./pruebas.sh unix2dos (o dos2unix)
# si el anterior comando fue corrido entonces se tendria que correr el inverso como ./pruebas.sh unix2dos inverse
t1= test1.txt
t2= test2.txt
ot1= out_test1.txt
ot2= out_test2.txt

echo "Pruebas de " $0

if [ "$1" = "inverse" ]
	then
		echo "1) Prueba inversa caso basico $ot1" 
			od -t c $ot1
			./$0 $ot1
			od -t c $t1

		echo "2) Prueba caso complejo $ot2" 
			od -t c $ot2
			./$0 $ot2
			od -t c $t2

else
	echo "1) Prueba caso basico $t1" 
			od -t c $t1
			./$0 $t2
			od -t c $ot1

		echo "2) Prueba caso complejo $t2" 
			od -t c $t2
			./$0 $t2
			od -t c $ot2
fi
