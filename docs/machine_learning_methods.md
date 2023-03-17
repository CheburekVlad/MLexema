# Apprentissage non supervisé
Apprentissage autonome, c'est à dire indépendamment d'annotations sur les données. Les données en entrée sont inconnues. La complexité de l'algorithme est moindre, mais la précision des résultats est modérée.

# Apprentissage supervisé
Contrôle l'apprentissage de l'algorithme à partir d'un jeu de données d'exemple. Ainsi, les données en entrée sont connues.
La complexité de l'algorithme est plus importante que pour l'apprentissage non supervisé, mais la précision des résultats produits est améliorée.


<!-- ################################ KMEANS ################################ -->
# K-means (version non détaillée)
## Principe
Le principe de l'algorithme des k-means est de diviser les observations des données en k groupes afin d'obtenir k clusters. Ceux-ci seront homogènes et distincts les uns des autres. Ainsi, les observations ne peuvent appartenir qu'à un seul cluster.  
Une des difficultés de cet algorithme revient à choisir le nombre de cluster à définir.   
En effet, un nombre de cluster trop faible regroupera trop de données et compliquera l'interprétation des patterns entre elles.
En revanche, un nombre de cluster trop grand conduira à une fragmentation des données trop importantes et masquera des patterns intéressants.  
Il faut donc tester différentes valeurs de k.
 
 COMPLETER LES DONNEES AJOUTEES AUX CLUSTERS (CONSTRUCTION DONNEES)

# K-means (version détaillée)
## Principe 
Apprentissage non supervisé, son principe repose sur la segmentation des données en k groupes afin d'obtenir k clusters. Ceux-ci seront homogènes et distincts les uns des autres.

Dans le but de définir ces clusters, dans un premier temps on choisi aléatoirement k centroïdes auxquelles on donne un identifiant (0, 1, 2, ...). 
Ensuite, pour chaque point dans le jeu de données, on assimile le centroïde le plus proche par comparaison entre la distance du point et chacun des k centroïdes.
L'algorithme alterne plusieurs fois les deux étapes pour optimiser leur position. 

Une des difficultés de cet algorithme revient à choisir le nombre de cluster à définir. 
En effet, un nombre de cluster trop faible regroupera trop de données et compliquera l'interprétation des patterns entre elles.
En revanche, un nombre de cluster trop grand conduira à une fragmentation des données trop importantes et masquera des patterns intéressants.
Il faut donc tester différentes valeurs de k et calculer la variance entre les centroïdes des clusters et au sein des observations d'un même cluster.

$V = \sum _j \sum _{x_i \rightarrow c_j} D({c_j, x_i})²$    

Généralement, le nombre idéal de cluster est k = 3.

Avec
- $c_j$ le centre du cluster 
- $x_i$ la ième observation dans le cluster avec pour centroïde $c_j$
- $D({c_j, x_i})$ la distance entre le centre du cluster et le point $x_i$


RECHERCHE VARIANCE ET DVLP LA FORMULE

## Algorithme K-means
En entrée : 
- K nombre de cluster à définir
- Le jeu de données (matrice)

```
DEBUT

Choisir aléatoirement K points (centres de cluster).

    REPETER
    
        Affecter chaque point (élément de la matrice de donnée) à son centre le plus proche

        Recalculer le centre de chaque cluster et modifier le centroide

    JUSQU‘A     
        CONVERGENCE

FIN ALGORITHME
```

## Paramètres
<!-- voir script Egor (quel package utilisé)
-->

## Les points forts
- Identification des groupes de données inconnus à partir des données complexes.
- L'algorithme s'adapte aux changements des données
- Compatible aux grands jeux de données
- Résultats simples à interpréter (description des clusters).
- Faible coût de calcul (rapide, efficace)
- Complexité linéaire 

## Les limites
- Cet algorithme ne peut être utilisé que lorsqu'il est possible de définir une valeur moyenne du cluster.
- Il existe un biais dans la valeur moyenne du cluster si certains points sont extrêmes.
- Il ne convient pas à tous les jeux de données.
- Le choix de la valeur K est aléatoire, il est difficile d'estimer le nombre de catégorie du jeu de données à diviser.
- Le temps de calcul peut être relativement long si le jeu de données est grand (calcul continu des nouveaux centres de cluster...).
- Execution de l'algorithme seulement pour des données numériques


<!-- ################################ RANDOM FOREST ################################ -->
# Random Forest de classification (version non détaillée)
## Principe
Algorithme basé sur l'assemblage d'arbres de décision indépendants. 
Ce sont ces arbres qui, à partir d'une serie de tests, aident à prendre une décision finale (représentée par une feuille de l'arbre).

Pour choisir par quel test commencé, l'algorithme calcule, pour chacun des tests de la série, le gain d'information obtenu. Ainsi, le premier test exécuté sera celui qui maximise le gain.

Le nombre d'arbres est déterminé par validation croisée, c'est-à-dire que l'algorithme utilise des sous-ensembles du jeu de données de départ pour entrainer et tester le modèle.


# Random Forest de classification (version détaillée)
## Principe
Algorithme basé sur l'assemblage d'arbres de décision indépendants. 
Ce sont ces arbres qui, à partir d'une serie de tests, aident à prendre une décision finale (représentée par une feuille de l'arbre).

Pour choisir par quel test commencé, l'algorithme calcul, pour chacun des tests de la série, le gain d'information obtenu. Ainsi, le premier test exécuté sera celui qui maximise le gain.

Le nombre d'arbres est déterminé par validation croisée, c'est-à-dire que l'algorithme utilise des sous-ensembles du jeu de données de départ pour entrainer et tester le modèle.
En effet, le jeu de données est découpé en plusieurs sous-ensemble d'échantillons tirés aléatoirement.
Un modèle est ensuite entrainé sur chacun de ces sous-ensemble ; il y a autant de modèles que de sous-ensemble.
Les résultats des modèles, c'est-à-dire les arbres, sont combinés dans le but de faire mettre en avant un résultat final robuste.


## Algorithme Random Forest
```
DEBUT
    Selectionner n sous-ensembles aléatoires de points et m caractéristiques dans l'ensemble du jeu de données 

    Construiction des arbres de décision individuels pour chaque échantillon

    Recueilir les résultats générés par les arbres

    Vote 

    ......................

FIN    
```

## Paramètres
<!-- voir script -->

## Les points forts
- Visualisation de l'importance d'une variable (au niveau des noeuds).
- Efficace sur tous types de données (catégoriel, numérique, binaire), sans transformation préalable.
- Surajustement faible.
- Haute précision.
- Gain de temps puisque les forêts obtenues peuvent être sauvegardées et réutilisées.

## Les limites
- Possibilité de doublons et d'ajouts d'arbres non pertinants dû à la création aléatoire des arbres.
- Vitesse de l'algorithme lent en raison de la construction d'un très grand nombre d'arbres (forêt).
- Difficulté/impossibilité pour interpréter et comprendre la décision finale (boîte noire de l'algorithme)




<!-- ################################ Support Vector Machine (SVM) ################################ -->
# SVM (version non détaillée)
## Principe
Technique d'apprentissage supervisé, le Support Vector Machine (SVM) consiste à déterminer la frontière qui sépare le plus les classes les unes des autres de façon linéaire.

Pour trouver cette frontière, l'algorithme doit s'entrainer sur un ensemble de point dont on connait à quelle classe ils appartiennent. Il détermine la frontière la plus plausible pour ce jeu de données d'entrainement en maximisant la distance entre les points et la frontière. Ainsi, il apprend à prédire l'emplacement des futures données encore inconnues à partir de son entrainement.


# SVM (version détaillée)
## Principe
Technique d'apprentissage supervisé, le Support Vector Machine (SVM) consiste à déterminer la frontière qui sépare le plus les classes les unes des autres de façon linéaire.

Pour trouver cette frontière, l'algorithme doit s'entrainer sur un ensemble de point dont on connait à quelle classe ils appartiennent. Il détermine la frontière la plus plausible pour ce jeu de données d'entrainement en maximisant la distance entre les points et la frontière. Ainsi, il apprend à prédire l'emplacement des futures données encore inconnues à partir de son entrainement.

Pour positionner les points, il faut déterminer au préalable un plan : 
- Calcul de l'hyperplan vectoriel : $w_1 * x_1 + w_2 * x_2 + ... + w_n * x_n = 0$ 
- Calcul d'un scalaire b qui permet d'utiliser un hyperplan affine
- Pour positionner le point, l'algorithme utilise le signe retourné par : $h(x) = w^T * x + b$    
$\left\{ \begin{array}{rcr} 
h(x) \ge 0 \to x \in catégorie_1 \\
h(x) \lt 0 \to x \in catégorie_2
\end{array}
\right\}$  

- Enfin, l'hyperplan choisi est celui qui maximise la marge = distance minimale entre les points déterminés pendant l'entrainement qui supportent la frontière (vecteurs supports) et l'hyperplan.



## Algorithme SVM
```
DEBUT
    Séparer aléatoirement les données en deux groupes dinstincts : un jeu d'entrainement et un jeu de test

    Trouver le meilleur hyperplan à partir du jeu d'entrainement
    
    Pour tous les points du jeu de données test:
        Si les donénes sont séparés de manière non linéaire
            Introduire une nouvelle dimension au plan (astuce du noyau)

        Sinon
            Assigner le point à une des catégories de l'hyperplan

FIN
```


## Paramètres
<!-- voir script -->

## Les points forts
- Particulièrement efficace lorsque le nombre de données d'entrainement est faible.


## Les limites
- Données non séparable linéairement = transformation préalable (kernel trick)



<!-- ################################ Neural Network ################################ -->
# Neural Network (version non détaillée)
## Principe
Basé sur une imitation algorithmique des fonctions du cerveau humain, les réseaux de neurones traitent de façon autonome des données complexes.
L'algorithme est dans un premier temps entrainé puis apprend en autonomie et se met à jour en permanence dans le but d'offrir un résultat le plus précis possible.

Il y a 3 types de neurones principaux : 
- Les neurones d'entrées, recevant les données
- Les neurones de traitements
- Les neurones de sorties

Un réseau de neurones peut être multicouches à chaque niveau (couche d'entrée, couche cachée de traitements, couche de sortie).

Chaque connexion entre neurones a un poids et un biais qui ne sont pas équivalents entre eux.

# Neural Network (version détaillée)
## Principe
Basé sur une imitation algorithmique des fonctions du cerveau humain, les réseaux de neurones traitent de façon autonome des données complexes.
L'algorithme est dans un premier temps entrainé puis apprend en autonomie et se met à jour en permanence dans le but d'offrir un résultat le plus précis possible.

Il y a 3 types de neurones principaux : 
- Les neurones d'entrées, recevant les données
- Les neurones de traitements
- Les neurones de sorties

Un réseau de neurones peut être multicouches à chaque niveau (couche d'entrée, couche cachée de traitements, couche de sortie).

La connexion entre les neurones a un poids jouant un rôle dans la transmission de l'information. 
Si le poids est important, l'information sera dominante à l'entrée du neurone suivant et vise-versa. Les connexions avec un poids faible ne sont pas pour autant ignorées.

Les biais d'une connexion entre neurones est un paramètre permettant d'ajuster les valeurs d'entrées auxquelles les poids ont été appliqués et influe sur la fonction d'activation.

Une fonction d'activation calcul la valeur de sortie de chaque neurone afin de déterminer combien de neurones seront activés pour résoudre le problème.

Fonctionnement des réseaux neuronaux : 
$ \sum_{i=1}^{m} w_ix_i + biais $

$\left\{ \begin{array}{rcr} 
f(x) = 1 if \sum w_1x1 + b \ge 0  \\
f(x) = 0 if \sum w_1x1 + b \lt 0
\end{array}
\right\}$  

## Algorithme Neural Network
En entrée:
- Données aléatoires pour tous les biais (b) et poids (w) du réseau

```
DEBUT
    Insérer en entrée des données labéllisées (dont on connait la sortie) pour l'apprentissage:
        Obtention de résultats attendus

    Calculs des résultats des neurones (activation) jusqu'à la couche de sortie

    Comparaison des résultats de sorties avec ceux attendus

    Correction possible des b et w pour minimiser l'erreur

FIN
```


## Paramètres
<!-- voir script -->

## Les points forts
- Peuvent traiter des problèmes non structurés (sans information initiale)
- Performant même sur des domaines complexes
- Permet de travailler sur des données incomplètes ou bruitées.

## Les limites
- Besoin d'une base d'apprentissage
- Les calculs permettant l'obtention d'un résultat ne sont pas disponible ("boîte noire") : difficulté à lier les variables du modèle entre elles.
- Une architecture optimale locale du réseau de neurones n'est pas toujours une solution optimale en architecture globale (nombres de couches cachées...).


<!-- ####################################### -->
# Sources:
## Kmeans
https://mrmint.fr/algorithme-k-means  
https://datascientest.com/algorithme-des-k-means  
https://dataanalyticspost.com/Lexique/k-means-ou-k-moyennes/  
https://www.data-transitionnumerique.com/k-means/


## Random Forest
https://datascientest.com/random-forest-definition
https://www.tibco.com/fr/reference-center/what-is-a-random-forest


## SVM
https://zestedesavoir.com/tutoriels/1760/un-peu-de-machine-learning-avec-les-svm/
https://fre.myservername.com/what-is-support-vector-machine-machine-learning#Applications_Of_SVM

## Neural Network
https://datascientest.com/deep-neural-network
https://www.jedha.co/formation-ia/reseau-neurones-deep-learning
https://fr.blog.businessdecision.com/tutoriel-machine-learning-comprendre-ce-quest-un-reseau-de-neurones-et-en-creer-un/
https://www.ibm.com/fr-fr/cloud/learn/neural-networks
https://fr.wikiversity.org/wiki/R%C3%A9seaux_de_neurones/Avantages_et_possibilit%C3%A9s

