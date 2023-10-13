# zcamt2csv
Petit utilitaire pour convertir des fichiers XML CAMT 053 de la Banque Alternative Suisse (BAS) en CSV
zf231011.2257, 231013.2258


## Buts
L'extraction des transactions de la Banque Alternative Suisse en CSV est pourrie, on n'a pas les colonnes références et communications !
Le seul moyen de les avoir, c'est de récupérer l'exportation en format XML/CAMT053 et de le convertir en CSV.

Mais ce format est tellement pourri (encore une fois) que les convertisseurs XML/CSV standards ne fonctionnent pas ou alors très mal.
Le but donc de ce petit utilitaire est d'extraire les colonnes désirées du fichier XML pour les convertir en CSV.
La seule lib que j'ai trouvée qui est utilisable et surtout facile à choisir ce que l'on veut comme colonnes est une lib en Ruby.

Afin de simplifier au maximum l'utilisation de cet utilitaire par le secrétaire, j'en ai fait un petit service WEB (Un GRAND merci à https://github.com/multiscan). 

## Prérequis
Il faut que Docker tourne sur sa machine !


## Utilisation

Faire simplement:
  ```
  ./start.sh
  ```

Après on peut simplement ouvrir avec son browser:
http://localhost:4567

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


## Pseudo documentation
Pour trouver le nom des champs à extraire dans la lib ruby camt:parser il faut aller creuser dans ces fichiers:

https://github.com/viafintech/camt_parser/blob/master/lib/camt_parser/general/entry.rb<br>
https://github.com/viafintech/camt_parser/blob/master/lib/camt_parser/general/transaction.rb


## Sources
https://github.com/viafintech/camt_parser<br>
https://stackoverflow.com/questions/50804957/parse-a-xml-uploaded-with-camt-parser-rails-gem<br>
https://github.com/plumped/camt_converter_ISO20022_for_camt<br>
https://hub.docker.com/_/ruby

