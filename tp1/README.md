compilar cada funcion por separado con
```
gcc -c read.c
gcc -c write.c
gcc -c unix2dos
gcc write.o read.o unix2dos.o -o unix2dos
```

luego se ejecuta con 
```
./unix2dos test1.txt
```


