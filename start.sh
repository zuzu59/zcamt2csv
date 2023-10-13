#!/bin/bash
#Petit script pour démarrer le binz
#zf231013.2242

#pour installer Docker et Docker compose sur une machine Ubuntu c'est ici:
#https://github.com/zuzu59/docker_demo

docker-compose up -d
docker-compose logs -f

exit

echo -e "

pour voir les logs en continu:
docker-compose logs -f

pour voir qu'est-ce qui tourne:
docker-compose ps

pour 'entrer' dans un 'service':
docker-compose exec nom_service /bin/bash

pour arrêter:
docker-compose stop

pour redémarrer après un 'stop':
docker-compose start

pour enlever les container mais pas les datas:
docker-compose down

pour enlever les container ET aussi les datas:
docker-compose down -v --remove-orphans


"
