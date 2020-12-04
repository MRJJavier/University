Nota: Contiene el código de inicialización para RPI3.

1. Al conectar empieza a sonar la melodía (The Imperial March) y empiezan a parpadear todos los LEDs. 

2. Si se pulsa el botón correspondiente a GPIO 2 cambia la secuencia de LEDs a parpadear todos y si ya esta en esa secuencia no produce ningún cambio.

3. Si se pulsa el botón correspondiente a GPIO 3 cambia la secuencia de LEDs a un encendido y apagado secuencial de cada uno de los LEDs empezando por GPIO9 hasta GPIO27.

4. Mientras tanto la melodía se mantiene inalterada.

5. La secuencia de GPIO 3 no empieza por GPIO 9 cada vez que activa, el contador de la secuencia sigue cambiando en el modo de GPIO 2 para que al volver vaya acorde los LEDs con la melodía.

6. En notas.inc he cambiado el valor de SILEN para que sea 0 en vez de 555 y sea un silencio real que mejore la melodía.

7. En vader.inc he añadido 2 SILEN de duracion BL (manteniendo el tempo) al final del array para distinguir cuando termina y cuando empieza de nuevo.

8. Los pulsadores cambian la variable MODO para que en la irq_handler mediante comparaciones y saltos sepa que secuencia activar.

9. En la fiq_handler se guarda en r3 el periodo de la nota a sonar (se podria hacer en una variable global) y configura la próxima interrupción con la duracion de la nota.

10. La nota suena en el bucle hecho con la rutina espera. Dentro de espera está la comprobación de los pulsadores que a su vez saltan para cambiar el modo a uno u otro. Si saltan despues a pulsadores despues saltan a nota, que esta dentro de la rutina espera.