# orgaDeCompTP0

66:20 Organización de Computadoras
Trabajo práctico 0: infraestructura básica
1 er cuatrimestre de 2019
1.
Objetivos
Familiarizarse con las herramientas de software que usaremos en los siguien-
tes trabajos, implementando un programa (y su correspondiente documenta-
ción) que resuelva el problema piloto que presentaremos más abajo.
2.
Alcance
Este trabajo práctico es de elaboración grupal, evaluación individual, y de
carácter obligatorio para todos alumnos del curso.
3.
Requisitos
El trabajo deberá ser entregado personalmente, en la fecha estipulada, con
una carátula que contenga los datos completos de todos los integrantes.
Además, es necesario que el trabajo práctico incluya (entre otras cosas, ver
sección 7), la presentación de los resultados obtenidos, explicando, cuando co-
rresponda, con fundamentos reales, las razones de cada resultado obtenido.
4.
Recursos
Usaremos el programa GXemul [1] para simular el entorno de desarrollo que
utilizaremos en este y otros trabajos prácticos, una máquina MIPS corriendo
una versión reciente del sistema operativo NetBSD [2].
En la clase del 12/3 hemos repasado, brevemente, los pasos necesarios para
la instalación y configuración del entorno de desarrollo.
5.
Programa
Se trata de escribir en lenguaje C dos programas que permitan convertir
archivos de texto desde y hacia plataformas UNIX como las que usamos en los
trabajos prácticos.En particular, buscamos generar dos programas: unix2dos para transformar
archivos de texto de UNIX a Windows, y dos2unix para hacer la operación
inversa.
Por defecto, en ambos casos, tomaremos la entrada estándar stdin y salida
por stdout. Las opciones -i y -o nos permiten además indicar explı́citamente
los archivos de entrada y salida, usando - para indicar los flujos estándar que
ya mencionamos.
A continuación se presenta un ejemplo de codificación:
$ (echo Uno; echo Dos; echo Tres) | unix2dos | od -t c
0000000
U
n
o \r \n
D
o
s \r \n
T
r
0000020
e
s
\r
\n
Podemos ver, entonces, que por defecto unix2dos opera usando los streams
estándar de entrada/salida, generando los newlines con la convención adopta-
da por Windows. Notar además el uso del programa od, que nos permite ver
caracteres que de otra forma no podrı́an ser observados.
A continuación, usamos dos2unix para hacer una conversión en el sentido
inverso:
$ od -t c /tmp/dos.txt
0000000
U
n
o \r \n
D
o
s \r
0000020
$ dos2unix -i /tmp/dos.txt -o - | od -t c
0000000
U
n
o \n
D
o
s \n
T
0000015
\n T r e
r e s \n
s
\r
\n
Aquı́, /tmp/dos.txt contiene un archivo de texto usando la convención
CR+LF para los caracteres newline, y hemos usado el programa dos2unix para
transformarlo a la convensión LF adoptada en sistemas UNIX.
6.
Casos de prueba
Se deberá verificar el correcto comportamiento del programa, por lo que los
alumnos deberán proponer casos de prueba que crean convenientes, indicando el
motivo de la elección de cada caso, indicando el método utilizado para verificar
que el programa responde correctamente en cada caso.
6.1.
Portabilidad
Como es usual, es necesario que la implementación desarrollada provea un
grado mı́nimo de portabilidad. Para satisfacer esto, el programa deberá funcio-
nar al menos en NetBSD/pmax (usando el simulador GXemul [1]) y la versión
de Linux usada para correr el simulador.
7.
Informe
El informe deberá incluir:
Documentación relevante al diseño, implementación, validación y utiliza-
ción del programa.
2La documentación necesaria para generar los binarios a partir del código
fuente suministrado.
Las corridas de prueba, con los comentarios pertinentes.
El código fuente completo, el cual también deberá entregarse en formato
digital compilable (incluyendo archivos de entrada y salida de pruebas).
Una copia impresa del código MIPS generado por el compilador.
Este enunciado.
8.
Fechas
Fecha de vencimiento: martes 16/4 de 2019.
Referencias
[1] GXemul. http://gavare.se/gxemul/.
[2] The NetBSD project. http://www.netbsd.org/.
[3] Text file (Wikipedia). http://en.wikipedia.org/wiki/Text_file.
[4] Newline (Wikipedia). http://en.wikipedia.org/wiki/Newline.
