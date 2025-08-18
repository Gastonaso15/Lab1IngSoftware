#!/bin/bash

# Abrir un subscriber en test/topic
mosquitto_sub -h localhost -t "test/topic" -v &
SUB1_PID=$!

# Abrir un segundo subscriber en otro/topic
mosquitto_sub -h localhost -t "otro/topic" -v &
SUB2_PID=$!

# Esperar 2 segundos para que los subscribers estén listos
sleep 2

# Publicar mensajes
mosquitto_pub -h localhost -t "test/topic" -m "Mensaje 1"
mosquitto_pub -h localhost -t "test/topic" -m "Mensaje 2"
mosquitto_pub -h localhost -t "otro/topic" -m "Hola otro topic"
mosquitto_pub -h localhost -t "test/topic" -m "Mensaje 3"

# Esperar 2 segundos para que se reciban mensajes
sleep 2

# Terminar los subscribers
kill $SUB1_PID $SUB2_PID
echo "Test finalizado."
