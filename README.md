# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# RocketDeliveryBackend

**Qu'est-ce que SQL?**

SQL (Structured Query Language) est un langage de programmation utilisé pour gérer et manipuler des bases de données relationnelles. Il permet de créer, modifier et supprimer des tables, d'insérer, mettre à jour et supprimer des données, ainsi que de récupérer des informations spécifiques à partir de la base de données. SQL est utilisé dans de nombreux domaines, notamment la finance, la gestion de projet, la gestion des ressources humaines et la gestion de l’inventaire.


Quelle est la principale différence entre SQLite et MySQL?

La principale différence entre SQLite et MySQL est que SQLite est un système de gestion de base de données sans serveur, ce qui signifie qu'il stocke la base de données dans un fichier sur le disque dur de l'ordinateur, tandis que MySQL est un système de gestion de base de données client-serveur, ce qui signifie qu'il utilise un serveur pour stocker la base de données et gérer les connexions des clients. SQLite est souvent utilisé pour les applications mobiles et les petits projets, tandis que MySQL est utilisé pour les applications web et les projets plus importants.

Quels sont les clés primaires et étrangères?

Les clés primaires sont des attributs d'une table qui identifient de manière unique chaque enregistrement de la table. Les clés étrangères sont des attributs d'une table qui font référence à la clé primaire d'une autre table. Les clés étrangères sont utilisées pour établir des relations entre les tables et garantir l'intégrité référentielle des données.

Quels sont les différents types de relations qui peuvent être trouvés dans une base de données relationnelle ? Donnez un exemple pour chaque type.

Il existe trois types de relations dans une base de données relationnelle :
Relation un-à-un : chaque enregistrement dans la table A est associé à un seul enregistrement dans la table B, et vice versa. Par exemple, une table "employé" peut être associée à une table "numéro de sécurité sociale", où chaque employé a un seul numéro de sécurité sociale et chaque numéro de sécurité sociale est associé à un seul employé.
Relation un-à-plusieurs : chaque enregistrement dans la table A est associé à plusieurs enregistrements dans la table B, mais chaque enregistrement dans la table B est associé à un seul enregistrement dans la table A. Par exemple, une table "client" peut être associée à une table "commande", où chaque client peut passer plusieurs commandes, mais chaque commande est passée par un seul client.
Relation plusieurs-à-plusieurs : chaque enregistrement dans la table A est associé à plusieurs enregistrements dans la table B, et vice versa. Pour représenter cette relation, une table de jonction est nécessaire. Par exemple, une table "étudiant" peut être associée à une table "cours", où chaque étudiant peut suivre plusieurs cours et chaque cours peut être suivi par plusieurs étudiants. La table de jonction contiendrait les clés primaires des deux tables pour représenter les relations entre les étudiants et les cours.

**ANALYSE D'UN DIAGRAMME ENTITÉ-RELATION (ERD)**

Identifiez une paire de tables qui ont une relation de plusieurs-à-un. Expliquez pourquoi elles ont une telle relation.


La table orders et order_status_id. Parce que pour plusieurs order_status_id il y seulement un id de statut. Chaque commande ne peut pas avoir plusieurs status ça ne ferait pas de sens. Par contre un status peut être assigner à plusieurs commandes.

Identifiez une paire de tables qui ont une relation de un-à-un. Expliquez pourquoi elles ont une telle relation.

La table users et employees. Parce que une un employer à seulement un identificateur et pas plusieurs à la fois. La réciproque est vrai aussi, un identifiant d’utilisateur n’es assigner qu’a un employé.
Identifiez une relation de plusieurs-à-plusieurs dans le diagramme. Quelles tables sont impliquées et pourquoi?

Aucune 