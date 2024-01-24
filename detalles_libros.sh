#!/bin/bash

# URL del endpoint de autenticación
AUTH_URL="http://localhost:8080/api/v1/auth/signin"

# ID del libro pasado como argumento

read -p "Ingresa el ID del libro: " LIBRO_ID

# URL del endpoint para obtener detalles de un libro
DETALLES_LIBRO_URL="http://localhost:8080/api/v1/libros/$LIBRO_ID"

# Datos de autenticación
AUTH_DATA='{"email":"alice.johnson@example.com", "password":"password123"}'

# Realiza la solicitud POST para obtener el token
response=$(curl -s -X POST -H "Content-Type:application/json" --data "$AUTH_DATA" $AUTH_URL)

# Extrae el token JWT de la respuesta usando grep y cut
token=$(echo $response | grep -o '"token":"[^"]*' | cut -d'"' -f4)

# Verifica si se obtuvo un token
if [ -z "$token" ]; then
    echo "No se pudo obtener el token JWT"
    exit 1
fi

# Realiza la solicitud GET al endpoint de detalles del libro usando el token JWT
curl -v -X GET -H "Authorization: Bearer $token" $DETALLES_LIBRO_URL

# Mensaje de confirmación
read -p "Presiona Enter para continuar..."