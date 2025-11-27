# Documentation

## Variables

* **MAZE** :
    * tableau de 6 561o
    * représente l'architecture du labyrinthe
        * les 1 sont les murs
        * les 0 sont les chemins ouverts
        * les autres valeurs sont les indices de cases
        * chaque case fait 16 bits
    
* **VISITED** :
    * tableau de 
    * sert à modéliser la visite des proches voisins dans l'algo de génération en profondeur

## Procédures

* **TO1D** : *DATASPACE.X68*
    * retourne la valeur de MAZE à l'adresse (x,y)
    * D3.b : largeur du labyrinthe 
    * D4.b : x
    * D5.b : y
    * A0 : retour

## Registres

| Registre | Libre | Utilisation |
|---|---|---|
| D0 | ❌ | Appels systèmes très fréquents |
| D1 | ❌ | Appels systèmes très fréquents |
| D2 | ❌ | Appels systèmes pour l'affichage |
| D3 | ⚠️ | TO1D |
| D4 | ⚠️ | TO1D |
| D5 | ⚠️ | TO1D |
| D6 | ✅ |  |
| D7 | ✅ |  |
| A0 | ⚠️ | TO1D |
| A1 | ⚠️ | Ouverture de fichiers |
| A2 | ✅ |  |
| A3 | ✅ |  |
| A4 | ✅ |  |
| A5 | ✅ |  |
| A6 | ✅ |  |
| A7 | ✅ |  |
