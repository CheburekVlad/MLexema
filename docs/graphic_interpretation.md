# COURBE ROC (Receiver Operating Characteristic)
Permet de mesurer et comparer la performances de plusieurs modèles en calculant les aires sous la courbe.
La courbe ROC est illustre la relation entre la sensiblité (taux de vrais positifs) et la spécificité (taux de faux positifs).

Construction du graphe:
- L'ordonnée représente la sensibilité
- l'abscisse représente 1 - la spécificité

La courbe commence par le point de coordonnées (0,0) et termine par le point de coordonnées (1,1). 
Chaque point correspond à la valeur du test pour l'individu i.
Pour chacun des points, son couple (1 - spécificité, sensibilité) est placé dans le graphe.


En haut à droite, on retrouve les points très sensibles mais très peu spécifiques ; en revanche, en bas à gauche, on retrouve les points très spécifiques mais très peu sensibles.
Il faut donc trouver le point faisant le meilleur compromis entre ces deux métriques : en haut à gauche. 

Il est possible de calculer l'air sous la courbe.
Si l'air de la courbe ROC vaut:
- 1, le test est parfait.
- 0.90, très bonne performance du modèle, le test retourne un résultat significativement meilleur que le hasard.
- 0.5, le modèle retourne un résultat "au hasard" (autant de chance d'avoir un vrai positif qu'un faux positif).

# MATRICE DE CONFUSION
Résume les prédictions d'un modèle par rapport à une variable cible d'un jeu de données réelles. Elle permet de faire le point sur le type d'erreur commis par le modèle.

La matrice de confusion nous donne donc des informations sur : 
- Accuracy : indique la proportion de patients réellement allergique (ACD) et de patients non allergiques (no ACD) reconnus comme tels sur le nombre total de cas. Une valeur élevée est préférable. 
- 95% CI
- No information Rate (NIR) : valeur pour laquelle la précision (accuracy) doit être supérieure pour que le test soit significatif.
- P-value [Acc > NIR] 
- Kappa : compris entre -1 et +1, lordqu'il vaut 1, la concordance est parfaite.
- Mcnemar's Test P-value : ce test est utilisé pour déterminer s'il existe des différences sur une variable dépendante dichotomique (ex : Diagnosis) entre deux groupes apparentés.
- Sensitivity : nombre de vraies prédictions positives divisé par le nombre total de positif (VP / TP+FN)
- Specificity : ratio entre le nombre de vrais prédictions négatives et le nombre total de négatifs (VN / VN+FP). Correspond au nombre de patients no ACD correctement prédits.
- Pos Pred Value
- Neg Pred Value
- Precision : rapport entre les vrais positifs et le nombre total de positifs (VP / VP+FP). Parmi tous les positifs, lesquels le sont réellement ?
- Recall : correspond à la somme des vrais positifs et des faux négatifs. Il doit être proche de 100%. En effet, si le recall est de 100%, cela signifie que le nombre de faux négatif est de 0.
- F1 : Si la valeur du recall et de accuracy sont équivalents, la valeur du score F1 est maximale.
- Prevalence : nombre de positifs / (nombre de positifs + nombre de négatifs)
- Detection Rate 
- Detection Prevalence
- Balanced Accuracy
- 'Positive' Class



# Sources
## Courbe ROC
https://hal.science/hal-02870055v2/document
https://www.reseau-naissance.fr/data/mediashare/t3/pr3xql3uzbdbgvdkpemed657ohvpki-org.pdf

## Matrice de confusion
https://www.jedha.co/formation-ia/matrice-confusion

## Autres sortie des fonctions
https://rpubs.com/Mentors_Ubiqum/tunegrid_tunelength
https://machinelearningmastery.com/machine-learning-evaluation-metrics-in-r/