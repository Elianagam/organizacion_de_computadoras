- Correr pruebas en linux con los comandos
```
./pruebas.sh unix2dos <nombre_archivo>
./pruebas.sh dos2unix <nombre_archivo>
```
- Copiar archivos
```
Abrimos dos consolas (un puente tiene dos extremos):

En la primera abrimos el gxemul junto con la imagen del NetBSD (./gxemul -e 3max -d netbsd-pmax.img) completando user y pass con
	user : root
	contraseña : orga6620

En la segunda tiramos:
	ifconfig lo:0 172.20.0.1

Ahora vamos a abrir el puente desde NetBSD a Linux; por lo que vamos a la consola en que abrimos el NetBSD y tiramos:
	ssh -R 2222:127.0.0.1:22 user@172.20.0.1	(user debe reemplazarse por el usuario de la sesión actual -en mi caso sería tomas-)
	Esto nos va a pedir la contraseña de la sesión de user (como si hubiesemos querido iniciar sesión ahí)

	Desde la consola de Linux (en la que no está abierto NetBSD) tiramos :  ssh -p 2222 root@127.0.0.1
	en donde nos va a pedir la contraseña de root (que es orga6620). Una vez aceptado nos va a pedir que elijamos un tipo de terminal
	yo pongo siempre xterm que es la común (debe haber otras opciones pero no las investigué).

	Entonces hasta ahora lo que creamos es una ventana (por la cual miramos) desde NetBSD (1° consola) a Linux (vemos como si estuviesemos en Linux); y otra de Linux a NetBSD (2° consola) vemos el usuario root.

	Para poder copiar archivos vamos a ir a cualquiera de los dos y utilizar el comando scp -p2222 [-r: para carpetas] origen destino
	Supongamos que quiero copiar un archivo de Linux a NetBSD, entonces hago lo siguiente:
		Voy a la consola en que "veo" Linux (1° consola, aquella en que abri NetBSD)
		Tiro el comando "scp -p2222 /home/mi_usuario/Escritorio/archivo.extension root@127.0.0.1:/carpeta/"
		(notar que después de root@ lo que aparece es la ip que definimos anetes en Linux)

		Otra forma:
		Voy a la consola de NetBSD (2° consola) y tiro:
		"scp -p2222 /carpeta/ mi_usuario@172.20.0.1" -notar que después de mi_usuario@ también aparece la ip configurada antes

	Sin importar que forma haga la contraseña que deberé poner es la del OTRO sistema el cuál aparece en bash, si lo hago por la forma 1 entonces uso la pass de root@, en la 2da uso la de Linux.
```


