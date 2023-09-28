#!/bin/bash

# Obtener una lista de todas las imágenes colgadas (dangling) o que llevan la palabra <none> en REPOSITORY y en el TAG

IMAGENES=$(docker images -f dangling=true -q)
if [ ! -z "$IMAGENES" ]; then

# Eliminar todos los contenedores asociados a las imágenes
	CONTENEDORES=$(docker ps -a -q --filter ancestor=$IMAGENES)
	if [ ! -z "$CONTENEDORES" ]; then
		docker rm -f $CONTENEDORES
	fi

# Eliminar todas las imágenes colgadas (dangling) o que llevan la palabra <none> en REPOSITORY y en el TAG
	docker rmi -f $IMAGENES
fi
