# MLexema

Cette application R permet d'implementer des différents modèles de classification : 
* supervisés -> Random Forest et SVM
* non-supervisés -> Kmeans

## Preparation

Pour accéder aux fichiers il faut cloner le répertoire GIT :
```git clone https://github.com/CheburekVlad/MLexema.git```
ou en télechargeant l'archive directement.

### Organisation des fichiers
Voici le schéma d'organisation des fichiers:

![filesOrganisation.png](./docs/fileOrganisation.png)

## Utilisation
L'implémentation de ces modèles se déroule à l'aide d'une application shiny. Pour accéder à l'interface graphique (GUI), il faut exécuter le code contenu dans app.R ce qui chargera automatiquement les dependances manquantes et lancera le GUI.

<img style="float: right;" src="./docs/tabboard.png">
Une fois l'application lancée, dans le tabboard il existe plusieurs options.
--> Normalisation des données brutes permet d'effectuer le pré-traitement des données pour systematiser le format des fichiers d'entrée de sorte qu'ils puisse être utilisés. Permet également de normalisér les données d'expression et fusionner des datasets differents.

--> Chargement de données permet soit :
- charger un model de ML existant et analyser le dataset en le chargeant dans l'onglet Prediction,
- de charger un jeu de données et choisir les variables explicatives et la variable cible et de passer à l'etape d'analyse en cliquant sur le bouton soumettre. Dans le deuxieme cas, une fois le jeu de données chargé, ses 10 premieres lignes seront affichées pour vérifier la bonne importation et faciliter le choix des variables.

--> Algorithme est l'onglet sur lequel on peut choisir le type d'analyse.

### RF et SVM
SVM et RF impliquent l'entrainement d'un nouveau modèle (bouton Entrainement). La prédiction de ce modèle peut être visualisé en cliquant sur le bouton Analyse du modèle. Ceci va automatiquement ouvrir l'onglet Resultats ou 4 objets peuvent être consulté pour déterminer les résultats d'analyse: Courbe de précision, Prédictions du modèle vs données initiales, Matrice de confusion et la courbe ROC (Cf. graphic_interpretation.md).

### Kmeans
Kmeans, étant un modèle non-supervisé, ne nécessite pas l'entrainement et affiche les résultats directement. Les paramètres qui sont données par défault sont normalement performant pour des petits jeux de données mais peuvent être ajustés si le jeu de données devient plus conséquant.

```Nombre de clusters``` permet de choisir le nombre de clusters dans lesquels les observations vont être divisées.
```Nombre d'essais aleatoires``` permet de choisir combien de fois les centres des clusters seront déterminés. La fonction fera ensuite une moyenne pour déterminer la séparation la plus adéquate.
```Nombre d'iterations max``` permet de choisir le nombre de calcul des centre des clusters par essai.

Le bouton Clusterisation va directement ouvrir l'onglet Résultats ou 3 objets peuvent être analysés: Prédiction de l'algorithme, précision de prédiction et la courbe ROC.

## Conlusion

Suite a des données obtenues à la fin de l'analyse, vous obtenez donc une prédiction du phénotype du patient en question. Sachant que la prédiction se base UNIQUEMENT sur un modèle statistique et mathématique, le résultat peut varier en fonction de différents paramètres (nombre d'obsérvations, nombre de variables...) mais également peut étre différent d'un essai à l'autre pour les algorithmes de machine learning. Ces résultats sont en aucun cas des valeurs sûres, donc à interpréter avec attention. Pour avoir une meilleure précision, il est conseillé d'obtenir la prédiction par plusieurs modèle pour augmenter la probabilité de trouver un résultat juste. 

## Remarques

Fonctionne sous ```R 4.2+```, le bon fonctionnement de l'application n'est pas garanti sous une version inferieure. Dans ce cas il est conseillé d'installer une version plus récente.

Du à des particularité d'utilisation de shiny en cas de probleme, il est conseillé de redemarrer l'application et votre Session dans R en supprimant les variables de GlobalEnv. Ce détail affecte uniquement les problèmes dus à l'interface et non la précision de la prédiction.


