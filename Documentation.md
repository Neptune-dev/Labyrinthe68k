# Documentation

## Variables

* MAZE :
    * tableau de 200o
    * représente l'architecture du labyrinthe
    
* VISITED :
    * tableau de 200o
    * sert à modéliser la visite des proches voisins dans l'algo de génération en profondeur

## Procédures

* TO1D :
    * retourne la valeur de MAZE à l'adresse (x,y)
    * D3.w :
        * x sur 4 bit
        * y sur 4 bts
        * largeur du labyrinthe sur le deuxieme octet
    * A0.b : retour

## Registres

| Registre | Libre | Utilisation |
|---|---|---|
| D0 | ❌ | Appels systèmes très fréquents |
| D1 | ❌ | Appels systèmes très fréquents |
| D2 | ❌ | Appels systèmes pour l'affichage |
| D3 | ✅ |  |
| D4 | ✅ |  |
| D5 | ✅ |  |
| D6 | ✅ |  |
| D7 | ✅ |  |
| A0 | ✅ |  |
| A1 | ❌ | Ouverture de fichiers |
| A2 | ✅ |  |
| A3 | ✅ |  |
| A4 | ✅ |  |
| A5 | ✅ |  |
| A6 | ✅ |  |
| A7 | ✅ |  |
