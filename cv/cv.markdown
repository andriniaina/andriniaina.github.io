


<div class="row">

<div class="col-sm-9 col-md-10">
<h1>
<!--
<img class="img-circle" src="photo.jpg" style="width:100px; height:100px; float:left; margin: 0 1ex 0 0;" />
<img class="img-circle" src="photo_visage.jpg" style="width:100px; height:100px; float:left; margin: 0 1ex 0 0;" />
<img class="img-thumbnail" src="photo.jpg" style="width:140px; height:140px; float:left; margin: 0 1ex 0 0;" />
<img class="img-thumbnail" src="photo_reversed.jpg" style="width:140px; height:140px; float:right; margin: 0 1ex;" />
<img class="img-circle" src="photo_reversed.jpg" style="width:140px; height:140px; float:right; margin: 0 1ex; " />
-->
Andri Rakotomalala
</h1>
<p><strong>Ingénieur Informatique, Développeur multi-technologies frntend et backend, spécialisé en .NET/web
</strong></p>
<p><strong>13 ans d'expérience en développement d'applications d'entreprise, dont 8 ans en finance de marché
</strong></p>
<p><strong>Anglais courant
</strong></p>
</div>


<a class="col-xs-3 col-sm-3 col-md-2" style="margin:30px 0 0 0" href="photo.jpg">
<img class="img-thumbnail scaled" src="photo.jpg" />
</a>

</div>


## Formation
2005
: Ingénieur INSA de Lyon - Département Informatique

2000
: Baccalauréat S - Spécialité Mathématiques, Mention Bien



## Compétences techniques

Mes diverses expériences et ma grande culture générale en informatique me permettent de passer et de m'adapter à tout type d'environnement technique.
Néanmoins, ma spécialité actuelle est le développement d'**applications .NET** (C# ou F#) et **javascript** (reactjs ou angularjs).

Parmi les technologies que je maîtrise:

* Applications clientes
: WPF, Windows Forms, jQuery, ReactJs, AngularJs, html/css

* Langages
: C#, F#, VB.NET, java, SQL

* Bases de données relationnelles
: MSSQL, Oracle, Sybase ASE, Cassandra

* Tests unitaires et tests automatisés d'interface web (selenium)


## Compétences métiers
MOA
: Analyse et rédaction des expressions de besoins, rédaction de spécifications fonctionnelles, rédaction de la documentation technique et utilisateur, tests fonctionnels

Finance de marchés
:  Marchés des matières premières et ses produits dérivés, Grecs, VaR
: Notions en marchés d'actions

MOE
: Conception d'applications de qualité (maintenables, testables, performants, et secures)
: TDD, BDD, Tests unitaires et refactoring de code *legacy* avec forte dette technique
: Programmation fonctionelle

## Expérience professionnelle


<h3><div class="duree_offset">05/2016 - actuel</div> Société Générale CIB</h3>
**Tech Lead .NET au sein de la branche *commodities* (SGCIB/CTY) de la Société Générale**

Retour chez SGCIB/CTY pour participer au projet FRTB (Fondamental Review of the Trading Book).
Fort challenge technique pour adapter le moteur de calcul existant de façon à pouvoir décupler la puissuance de calcul.

Réalisations notables :
* Réarchitecturisation progressive du moteur existant pour s'adapter à de nouveaux paradigmes (scénarios de VaR dynamiques)
* Début d'implémentation d'une architecture en programmation fonctionnelle et immutable: donner ce qui est nécessaire en input pour que les calculateurs puissent opérer de façon indépendante
* Découplage et divers changements pour réduire le Time-To-Market
* Evaluation et introduction de technologies récentes tout en respectant le legacy:
   * NoSQL - Cassandra
   * Monitoring - stack Grafana+InfluDb+AppMetrics
   * Microservices - consul.io

> **Env. Technique:** C#, VB.NET, Sybase, MsSQL, Cassandra, Symphony (grid computing), git

<h3><div class="duree_offset"> 05/2014 - 05/2016 (2ans)</div>BNP Paribas CIB</h3>

**Tech lead .NET, java, AngularJs au sein de Compliance (GECD/MGA), BNP Paribas**

Dette technique considérable. Refonte et maintenance des applications de suivi des initiés, des poses de chaque desk/entité, des restrictions de trading.

Réalisations notables :

* Participation à un projet de refonte (java):
    * Apport de plusieurs conseils techniques
    * Réécriture des batchs d'envoi des mails

* Réécriture de l'application de suivi des poses de la BNP (C#):
    * Reverse-engineering
    * Réécriture et optimisation des modules de calcul (~1.5millions de lignes à calculer en quelques minutes)
    * Développement d'une batterie de tests fonctionnels automatisés (BDD avec Specflow)
    * Modernisation du site web (asp.NET/C# + bootstrap css + angularjs)

> **Env. Technique:** C#, VB.NET, java, bootstrap css, angularJs, reactjs/react-native, javascript/typescript, Visual Studio, eclipse















<h3><div class="duree_offset">08/2011 - 05/2014 (~3ans)</div> Société Générale CIB</h3>

**Développeur .NET au sein de la branche *commodities* (SGCIB/CTY) de la Société Générale**

Environnement technique complexe où il faut concilier dette technique et volonté d’avancer. Calculs intensifs, grands volumes de données. Applications transverses à toutes les lignes métiers de CTY (metals, agricultural, energy, cross-assets) et à tout type de produits dérivés

Développement et maintenance des outils *Front Office* transverses à toutes les lignes métiers de CTY et à tout type de produits dérivés dont :

* Plusieurs pricers pre-trade : affichage des caractéristiques du contrat, grecs, paramètres de marché live
* Meteor Risk Management (outil critique de calcul et de reporting post-trade sur tout le périmètre commodity) : gros volumes de données ; calculs intensifs de valuation, VaR, risk analysis journaliers sur une grille de calcul distribuée


Réalisations :

* Implémentation de nouveaux développements suite au changement du modèle de pricing (nouveaux indicateurs Explained PnL, nouvelles implémentations de VaR, calculs de dates, etc.)
* Investigations sur les erreurs de calculs (indicateurs de pricing, nominal, paramètres de marché incorrects, etc.) et les dégradations de performance
* Comparateur de résultats de jobs d’analyse de risque pour automatiser les tests d’intégration et simplifier la validation manuelle en UAT
* Stabilisation et refactoring de composants (dependency injection, mise en place d’Unity)
* Mise en place de tests unitaires avec mocking sur des composants legacy pour atteindre 65% de coverage
* Maintenance des interfaces Windows Forms+Infragistics et des modèles de données


> **Env. Technique:** Agile, C# (45%), vb.net (45%), vb6/com (10%), .net 3.5, windows forms, wcf, microsoft unity, nhibernate, sybase 12, SQL Server 2008, ado.net, Symphony (grid computing), team foundation server











<h3><div class="duree_offset">03/2010 - 06/2011 (~1an)</div> GFI Informatique</h3>


**Consultant .NET et Java au sein de GFI Informatique – Division Industrie, Pôle TMA**

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













<h3><div class="duree_offset">09/2005 - 02/2010 (~4.5ans+)</div>Amadeus IT Group, département SEP (Sales and e-commerce platforms)</h3>
**Responsable de la maintenance des composants PNR (dossier passager), TSM (pricing records), et Queues (file de traitement des PNR) du logiciel de réservation B2B phare d’Amadeus**

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



---
