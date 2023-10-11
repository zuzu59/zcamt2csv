# zcamt2csv
Petit utilitaire pour convertir des fichier XML CAMT 053 de la Banque Alternative Suisse en CSV
zf231011.2257, 231011.2330


## Buts
L'extraction des transactions de la Banque Alternative Suisse en CSV est pourrie, on n'a pas les colonnes références et communications !
Le seul moyen de les avoir c'est de récupérer l'exportation en format XML/CAMT053 et de le convertir en CSV.

Mais ce format est tellement pourri (encore une fois) que les convertisseurs XML/CSV standards ne fonctionnent pas ou alors très mal.
Le but donc de ce petit utilitaire est d'extraire les colonnes désirées du fichier XML pour les convertir en CSV.
La seule lib que j'ai trouvée qui est utilisable et surtout facile à choisir ce que l'on veut comme colonnes est une lib en Ruby.
Et comme je ne veux pas installer Ruby sur mon ordi je travaille avec un container Docker qui tourne Ruby.

## Prérequis
Il faut que Docker tourne sur sa machine !


## Utilisation
ATTENTION: pour l'instant le nom du fichier XML/CAMT053 est écrit en dur dans le script ruby

Faire simplement:

  ```
  ./start.sh
  ```

## Pseudo documentation
Pour trouver le nom des champs à extraire dans la lib ruby camt:parser il faut aller creuser dans ces fichiers:

https://github.com/viafintech/camt_parser/blob/master/lib/camt_parser/general/entry.rb
https://github.com/viafintech/camt_parser/blob/master/lib/camt_parser/general/transaction.rb


## Sources
https://github.com/viafintech/camt_parser
https://stackoverflow.com/questions/50804957/parse-a-xml-uploaded-with-camt-parser-rails-gem
https://github.com/plumped/camt_converter_ISO20022_for_camt
https://hub.docker.com/_/ruby







LE RESTE DE CE README N'EST PAS à JOUR EN CE MOMENT !  (ZF231011.2308)

## Pour arrêter !
Simplement faire:
  ```
  ./stop.sh
  ```

## Pour tout effacer !
Une fois après avoir arrêté le container, on peut purger toute l'installation avec:
  ```
  ./purge.sh
  ```
**ATTENTION:**<br>
Ceci va **effacer tous les containers qui ne tournent pas** en ce moment.<br>
Donc il faut faire très **attention avec d'autres containers éteints !**


