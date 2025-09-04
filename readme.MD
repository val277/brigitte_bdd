# Pour installer la db

```sql
mysql -u root -p < createDb.sql
```

## Requêtes

### 1 - Le nom des animaux du refuge.

```sql
-- facile

```

### 2 - Les fonctionnalités disponibles dans le refuge.

```sql
-- facile

```

### 3 - Les noms des léopards.

```sql
-- facile

```

### 4 - Les maladies contractées au moins une fois par des animaux du refuge.

```sql
-- normal

```

### 5 - Les noms et numéros de cage des animaux mâles qui sont originaires du Kenya et dont la date de naissance est antérieure à 1992.

```sql
-- normal

```

### 6 - Une requête produisant l’affichage suivant : Peyrin vit à Nouméa Berrut vit à Sartène Sicard vit à Calvi Voiron vit à Pointe à Pitre Scholl vit à Ushuaia Adiba vit à Papeete.

```sql
-- difficile

```

### 7 - Le nom et l’âge des animaux en 2017.

```sql
-- normal

```

### 8 - Le nom des soigneurs qui habitent Ushuaïa.

```sql
-- facile

```

### 9 - La fonctionnalité et le nom du soigneur des cages gardées par un employé habitant Calvi.

```sql
-- normal

```

### 10 - Le nom des animaux ainsi que des employés qui en sont soit les soigneurs soit les responsables.

```sql
-- normal

```

### 11 - Le nom des soigneurs gardant tous les animaux.

```sql
-- difficile

```

### 12 - Les noms et types des animaux qui n’ont jamais été malades.

```sql
-- normal

```

### 13 - Les noms des animaux originaires du Kenya ayant déjà contractés une grippe.

```sql
-- normal

```

### 14 - Les numéros et fonctionnalités des cages qui sont inoccupées.

```sql
-- normal

```

### 15 - Donner pour chaque animal mâle l’ensemble des maladies qu’il a contractées (ensemble des couples nom d’animal, nom de maladie).

```sql
-- normal

```

### 16 - Les numéros et fonctionnalités des cages qui sont partagées par des animaux de types différents. En d’autres termes, ce sont les cages qui contiennent au moins deux animaux de types différents.

```sql
-- difficile

```

### 17 - Les noms des responsables et les noms des soigneurs de Charly.

```sql
-- normal

```

### 18 - Le nom et le pays d’origine de l’animal doyen du refuge (il peut y en avoir plusieurs).

```sql
-- normal

```

### 19 - Le nom, le type et l’année de naissance des animaux qui ont contracté toutes les maladies (connues) du refuge.

```sql
-- difficile

```

### 20 - Le nom, le type et le pays d’origine des animaux qui partagent la cage de Charly.

```sql
-- normal

```

### 21 - Le nom et l’adresse des employés qui sont soigneurs d’animaux de tous types, on fait référence aux types des animaux du refuge.

```sql
-- difficile

```

### 22 - Lister le nom et l'âge de tous les animaux.

```sql
-- facile

```

### 23 - Donner les caractéristiques de l'animal appelé HECTOR.

```sql
-- facile

```

### 24 - Donner les origines distinctes de toutes les familles.

```sql
-- normal

```

### 25 - Donner les noms des singes de plus de 10 ans et originaire d'Afrique.

```sql
-- normal

```

### 26 - Donner les noms des singes ainsi que des animaux de plus de 8 ans.

```sql
-- normal

```

### 27 - Donner les races des animaux dont le numéro de menu est 1 et l'âge est supérieur à 10.

```sql
-- normal

```

### 28 - Donner les menus plus 2 fois moins riches en viande qu'en légume?

```sql
-- normal

```

### 29 - Donner l'âge et l'origine des animaux qui sont amis de l'homme.

```sql
-- normal

```

### 30 - Numéro de menu et quantité de viande pour les animaux qui ont une attitude amicale envers l'homme.

```sql
-- normal

```

### 31 - Donner les noms des animaux qui sont grands parents.

```sql
-- difficile

```

### 32 - Quantité de viande totale pour tous les menus.

```sql
-- facile

```

### 33 - Nombre d'enfants pour chaque numéro d'animal.

```sql
-- normal

```

### 34 - Lister les animaux qui dont on connaît les deux parents.

```sql
-- facile

```

### 35 - Donner la moyenne de la quantité de viande servie dans les menus.

```sql
-- facile

```

### 36 - Donner les numéros et la composition des menus plus riches en viande que la moyenne (se servir de la requête précédente pour faire cette requête).

```sql
-- normal

```

## Règles de cohérence

### 1. Un employé est soit un gardien, soit un responsable.

```sql
-- normal

```

### 2. Il n’y a pas de gardien affecté à des cages vides

```sql
-- normal

```
