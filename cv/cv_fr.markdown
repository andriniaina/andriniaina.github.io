---
title:  Andri Rakotomalala
subtitle: 
    Ingénieur Informatique,
    Développeur & Tech Leader, spécialisé en .NET/web
header-includes:
    - \usepackage{graphicx,grffile}
    - \usepackage{fancyhdr}
    - \pagestyle{fancy}
    - \lhead{\includegraphics{linkedin-logo-11x11.png} http://www.linkedin.com/in/arakotomalala}
    - \rhead{\includegraphics{email-icon-13x10.png} andriniaina@gmail.com}
geometry:
- margin=1in
---

13 ans d'expérience en développement d'applications d'entreprise, dont 8 ans en finance de marché

Anglais courant


Résumé
=============
Développeur **multi-technologies**, mais néanmoins actuellement spécialisé en **.NET (F# ou C#) + javascript (reactjs ou angularjs)** avec 13 ans d'expérience en développement d'applications maintenables et testables, tout en restant lisible et abordable.

En raison de mes diverses expériences et ma grande culture générale en informatique, je peux aisément et rapidement m'adapter aux nouveaux environnements et aux nouvelles technologies; ce qui me permet d'apporter de la valeur en un court laps de temps.

Formation
=============

| **2005** \ Ingénieur INSA de Lyon -- Département Informatique
| **2000** \ Baccalauréat S -- Spécialité Mathématiques, Mention Bien


Compétences
=============

Finance de marchés
: Marchés des matières premières et ses produits dérivés, Grecs, VaR
: Notions en marchés d'actions

Ingénierie logicielle
: Architecture et conception
: Analyse et rédaction des expressions de besoins, rédaction de spécifications fonctionnelles, rédaction de la documentation technique et utilisateur, tests fonctionnels
: TDD, BDD, tests unitaires et refactoring de code *legacy* avec beaucoup de dette technique
: Programmation fonctionnelle

Environnements techniques
: Applications clientes: WPF, Windows Forms, jQuery, ReactJs, AngularJs, html/css
: Langages: C#, F#, VB.NET, typescript/javascript, java, SQL
: Bases de données: MSSQL, Oracle, Sybase ASE, Cassandra

\clearpage

Expérience professionnelle
=============


Société Générale CIB / Commodities  \hfill\mdseries <span class='date'>05/2016 - actuel</span>
------------------------

**Technical Leader .NET au sein de la branche *commodities* (SGCIB/CTY)**

Retour chez SGCIB/CTY pour participer au projet FRTB (Fondamental Review of the Trading Book, aka Bale III).
Fort challenge technique pour adapter le moteur de calcul existant de façon à pouvoir décupler la puissance de calcul.

**Réalisations notables :**

* Membre du chapter Software Craftmanship
* Membre de la guilde transversale des Tech Leaders
* Staff recruitement
* Réarchitecturisation progressive du moteur existant pour s'adapter à de nouveaux paradigmes (scénarios de VaR dynamiques selon le produit, Expected Shortfall, Internal Model based approach)
* a suggeré et commencé à implémenter une architecture en programmation fonctionnelle et immutable: donner ce qui est nécessaire en input pour que les calculateurs puissent opérer de façon indépendante
* a poussé pour découpler les composants et divers changements pour réduire le Time-To-Market (UAT en 4j au lieu de ~1.5mois, livraison sans downtime en semaine au lieu du week-end)
* Choix et introduction de technologies récentes tout en respectant l'existant:
    * NoSQL -- Cassandra
    * Monitoring -- stack Grafana+InfluDb+AppMetrics
    * Microservices -- consul.io, traefik

> **Env. Technique:** méthodologie SAFe, C#, VB.NET, Sybase, MsSQL, Cassandra, Symphony (grid computing), git & teamcity & xldeploy, consul.io & traefik, InfluxDb






---






BNP Paribas CIB / Compliance \hfill\mdseries <span class='date'>05/2014 - 05/2016 (2ans)</span>
--------------------

**Lead Software Dev .NET, java, AngularJs au sein de Compliance (GECD/MGA)**

Dette technique considérable. Refonte et maintenance des applications de suivi des initiés, des poses de chaque desk/entité, des restrictions de trading.

**Réalisations notables :**

* Participation à un projet de refonte (java):
    * Apport de plusieurs conseils techniques
    * Réécriture des batchs d'envoi des mails

* Réécriture de l'application de suivi des poses de la BNP (C#):
    * Reverse-engineering
    * Réécriture et optimisation des modules de calcul (~1.5millions de lignes à calculer en quelques minutes)
    * Développement d'une batterie de tests fonctionnels automatisés (BDD avec Specflow)
    * Modernisation du site web (asp.NET/C# + bootstrap css + angularjs)

> **Env. Technique:** C#, VB.NET, java, bootstrap css, angularJs, javascript/typescript, Visual Studio, vscode, eclipse, jenkins, tests automatisés avec selenium











---


Société Générale CIB / Commodities \hfill\mdseries <span class='date'>08/2011 - 05/2014 (~3ans)</span>
------------------------

**Développeur .NET au sein de la branche *commodities* (SGCIB/CTY)**

Environnement technique complexe où il faut concilier dette technique et volonté d’avancer. Calculs intensifs, grands volumes de données. Applications transverses à toutes les lignes métiers de CTY (metals, agricultural, energy, cross-assets) et à tout type de produits dérivés.

Développement et maintenance des outils *Front Office* transverses à toutes les lignes métiers de CTY et à tout type de produits dérivés dont :

* Plusieurs pricers pre-trade : affichage des caractéristiques du contrat, grecs, paramètres de marché live
* Meteor Risk Management (outil critique de calcul et de reporting post-trade sur tout le périmètre commodity) : gros volumes de données ; calculs intensifs de valuation, VaR, risk analysis journaliers sur une grille de calcul distribuée


**Réalisations notables :**

* Implémentation de nouveaux développements suite au changement du modèle de pricing (nouveaux indicateurs Explained PnL, nouvelles implémentations de VaR, calculs de dates, etc.)
* Investigations sur les erreurs de calculs (indicateurs de pricing, nominal, paramètres de marché incorrects, etc.) et les dégradations de performance
* Comparateur de résultats de jobs d’analyse de risque pour automatiser les tests d’intégration et simplifier la validation manuelle en UAT
* Stabilisation et refactoring de composants (dependency injection, mise en place d’Unity)
* Mise en place de tests unitaires avec mocking sur des composants legacy pour atteindre 65% de coverage
* Maintenance des interfaces Windows Forms+Infragistics et des modèles de données


> **Env. Technique:** Agile, C# (45%), vb.net (45%), vb6/com (10%), .net 3.5, windows forms, wcf, microsoft unity, nhibernate, sybase 12, SQL Server 2008, ado.net, Symphony (grid computing), team foundation server





---





GFI Informatique \hfill\mdseries <span class='date'>03/2010 - 06/2011 (~1an)</span>
---------------------


**Consultant .NET et Java au sein de la Division Industrie, Pôle TMA**

* Conseil avant-vente : Participation aux appels d’offres nécessitant un conseil technique (chiffrage, identification des impacts, conseil en système d’information, architecture)
* Rédaction de bonnes pratiques pour le développement de logiciels avec .NET, à l’attention de développeurs débutants
* Mise en place d’une chaîne de production réutilisable de projets .NET basé sur Microsoft Team Foundation Server
* Veille technologique (méthodologies, coding standards, best practices, etc.)
* Audit de code (performances, sécurité, normes de programmation)
* Prototypage
* Conseil et participation à divers projets forfaits clients, dont :
    * SNCF Yield Management: gestion dynamique du prix selon le stock de places disponibles
    * SNCF R&D: Création d’une application interactive de visualisation de gros volumes de données statistiques (cartes, graphes, etc.) sur écran tactile
    * EDF / ERDF: Participation à la refonte de l’application Info réseau en abobe flex (anciennement en vb6)


> **Env. Technique:** java/j2ee, jboss, Oracle 9i, Adobe Flex 4, blazeds, hibernate








---





Amadeus IT Group \hfill\mdseries <span class='date'>09/2005 - 02/2010 (~4.5ans+)</span>
------------------------------


**Responsable de la maintenance des composants PNR (dossier passager), TSM (pricing records), et Queues (file de traitement des PNR) du logiciel de réservation B2B phare d’Amadeus, au sein de SEP (Sales and e-commerce platforms)**

**Ingénieur analyste fonctionnel**

* Définition des cas d'utilisation, à partir des besoins formulés par le Product Management et Marketing
* Identification des impacts sur le système et suivi de la progression du développement auprès des équipes impactées
* Evaluation de la charge de travail
* Proposition de maquettes d'interfaces IHM
* Rédaction des spécifications fonctionnelles
* Présentation des impacts et des nouvelles fonctionnalités
* Identification des plans de tests et rédaction des tests fonctionnels
* Validation fonctionnelle du logiciel, en amont de l’équipe Assurance Qualité
* Validation des fichiers d'aide

**Ingénieur développement Java/javascript**

* Responsable du développement des modules PNR, TSM et Queues (client léger javascript)
* Conception et maintenance de beans serveur

> **Env. Technique:** java/j2ee, xml/xsd/xslt, html/css, javascript, edifact, Visual Studio, Eclipse, Rational Rose, JBoss

