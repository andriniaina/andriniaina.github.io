---
title: Andri Rakotomalala
subtitle: 
    Software Engineer,
    Fullstack developer & Tech Leader, specialized in .NET+javascript
author:
- 13 years of experience in enterprise applications, including 8 years in finance
---

<link href="custom.css" rel="stylesheet" type="text/css" media="all" />



Education
-------------

2005
: INSA de Lyon -- Master's degree in engineering in Computer Science

2000
: Baccalauréat (A Levels) in science with honours

Transversal skills
-------------

Financial Markets
: Advanced knowledge of Commodities and derivatives, Greeks, risks, VaR
: Basics in stock markets

MOA
: Analyse et rédaction des expressions de besoins, rédaction de spécifications fonctionnelles, rédaction de la documentation technique et utilisateur, tests fonctionnels


MOE
: Conception d'applications de qualité (maintenables, testables, performants, et secures)
: TDD, BDD, Tests unitaires et refactoring de code *legacy* avec forte dette technique
: Programmation fonctionelle


Technical skills
-------------

As a result of my various work experiences and my excellent general knowledge in IT, I can easily and quickly adapt myself to a new technical environment.
However, I am currently specialized in development of **.NET applications** (C# of F#) and **javascript** (reactjs or angularjs).

Non-exhastive list of technologies that I can work with:

* Client technologies
: WPF, Windows Forms, jQuery, ReactJs, AngularJs, html/css

* Languages
: C#, F#, VB.NET, java, SQL

* Databases
: MSSQL, Oracle, Sybase ASE, Cassandra

* Unit tests


Work experience
-------------


<div class="duree_offset">05/2016 - today</div>

### Société Générale CIB

**.NET Technical Leader for the commodities department (SGCIB/CTY) of the Société Générale**

I was called back to SGCIB/CTY to help on the FRTB project (Fondamental Review of the Trading Book).
FRTB (aka Basel III) is a set of laws that will define the new market risk capital rules, starting from Jan 2020.
These new rules would require 10x more computations.

Strong technical and functional challenges to adapt the legacy risk computation engine in order to have a scalable architecture.

Achievements:

* Member of the chapter *Software Craftmanship*
* Member of the transversal guild of Tech Leaders
* Staff recruitement
* Progressively changed the existing engine to be adapt to new paradigms (dynamic VaR scenarios depending on the financial product)
* Started implementing a simpler functional architecture (1 given input => 1 predictable output)
* Decoupled components and services
* Choice and introduction of more recent technologies that still respects the existing architecture:
   * NoSQL -- Cassandra
   * Monitoring -- stack Grafana+InfluDb+AppMetrics
   * Microservices -- consul.io, traefik

> **Technologies:** C#, VB.NET, Sybase, MsSQL, Cassandra, Symphony (grid computing), git & teamcity, consul.io & traefik, InfluxDb






---






<div class="duree_offset"> 05/2014 - 05/2016 (2yr)</div>

### BNP Paribas CIB

**Lead Software Dev in .NET, java, AngularJs for BNP Paribas Compliance (GECD/MGA)**

Big technical debt. Rewrote and maintained various apps: insiders tracking; position followup; trading restrictions.

Achievements:

* Helped to rewrite the *short-sales* application (java):
    * Brought simple technical recommendations
    * Rewrote a batch (daily notification mail alerts)

* Modernized a legacy app (position tracking):
    * Reverse-engineering
    * Rewrote and optimized the different calculation modules (~1.5millions of lines to calculate in a few minutes depending on country specific rules)
    * Pushed for a test-centric BDD approach with SpecFlow
    * Modernisation of a website (from asp.NET/vb.net to angularjs/bootstrap-css/odata/C#)

> **Technologies:** C#, VB.NET, java, bootstrap css, angularJs, reactjs/react-native, javascript/typescript, Visual Studio, vscode, eclipse, jenkins











---


<div class="duree_offset">08/2011 - 05/2014 (~3yr)</div>

### Société Générale CIB

**.NET Developer for the commodities department (SGCIB/CTY) of the Société Générale**

Complex technical environment where we needed to find the right balance between technical debt and innovation.


Maintained the *Front Office* tools:

* Pre-trade pricers: shows products characteristics, greeks, live market data
* Meteor Risk Management : Distributed Grid computation (valuation, greeks, VaR) for the whole perimeter of CTY -- 8 million deals accross different business lines (metals, agricultural, energy, exotic and indexes) and various product types.


Achievements:

* Implémentation de nouveaux développements suite au changement du modèle de pricing (nouveaux indicateurs Explained PnL, nouvelles implémentations de VaR, calculs de dates, etc.)
* Investigations sur les erreurs de calculs (indicateurs de pricing, nominal, paramètres de marché incorrects, etc.) et les dégradations de performance
* Comparateur de résultats de jobs d’analyse de risque pour automatiser les tests d’intégration et simplifier la validation manuelle en UAT
* Stabilisation et refactoring de composants (dependency injection, mise en place d’Unity)
* Mise en place de tests unitaires avec mocking sur des composants legacy pour atteindre 65% de coverage
* Maintenance des interfaces Windows Forms+Infragistics et des modèles de données


> **Env. Technique:** Agile, C# (45%), vb.net (45%), vb6/com (10%), .net 3.5, windows forms, wcf, microsoft unity, nhibernate, sybase 12, SQL Server 2008, ado.net, Symphony (grid computing), team foundation server





---





<div class="duree_offset">03/2010 - 06/2011 (~1an)</div>

### GFI Informatique


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








---





<div class="duree_offset">09/2005 - 02/2010 (~4.5ans+)</div>

### Amadeus IT Group, département SEP (Sales and e-commerce platforms)


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

