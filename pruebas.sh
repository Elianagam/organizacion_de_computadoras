#!/bin/bash

# esto se ejecuta como ./pruebas.sh unix2dos (o dos2unix)
# si el anterior comando fue corrido entonces se tendria que correr el inverso como ./pruebas.sh unix2dos inverse

echo "Prueba $1: linux a windows  con archivo $2" 

if [ $1 = "unix2dos" ]
    then
    echo "Archivo inicial"
    od -t c $2
    ./unix2dos $2
    echo "Archivo final"
    od -t c out_w.txt
else
    echo "Archivo inicial"
    od -t c $2
    ./dos2unix $2
    echo "Archivo final"
    od -t c out_u.txt
fi
