# BUG À CORRIGER AVANT LA REMISE

	- Ne pas pouvoir entrer plusieurs lettres d'un coup
 	- Ne plus pouvoir écrire dans les lettres utilisée
  	- Les espaces et les chiffres devrait être fourni

# ENTÊTE
   
    Projet:  LABORATOIRE 3 : LE JEU DU PENDU AVEC BD
    Codeurs: Simon Turcotte (2395412) et Mathieu Hatin (2296939)
    Cours : DÉVELOPPEMENT D'APPLICATIONS MOBILES SOUS IOS 2 (420-292-AH)

# ÉNONCÉ/DESCRIPTION

	OBJECTIF	
 
		Le but de ce laboratoire est de mettre en pratique les notions de base de données locales.
	
	ÉVALUATION
	
		Le laboratoire est noté selon la qualité du code et du projet avec le barème ci-dessous. 
		Vous devez remettre un fichier zip qui contient votre projet et le nommer : NNNp_NNNp_201234567_201234567_labo3.zip,
		où ‘NNN’ sont les trois premières lettres de votre nom de famille, ‘p’ est la première lettre de votre prénom, 
		et 201234567 est votre matricule.
	
	RESSOURCES	
	
		1) Sauver et charger un dictionnaire dans « UserDefaults » :
			a. Basic : HS lien
			b. Avancé : lien Cocoacasts
		2) Core Data
			a. https://developer.apple.com/documentation/coredata/
			b. https://www.kodeco.com/7569-getting-started-with-core-data-tutorial    
	
	TRAVAIL DEMANDÉ
	
		< voir le pdf pour l'image de l'interface >

		En vous basant sur votre application du laboratoire 2, rajouter la persistance des données. 
		Vous allez enrichir votre jeu du pendu en ajoutant des fonctionnalités à la section "Préférences". 
		Cette section vous permettra d'enregistrer et de récupérer les préférences de l'utilisateur, 
		ainsi que d'afficher les meilleurs scores. 
	
	OBJECTIFS 
	
		1. Utiliser UserDefaults pour stocker et récupérer les préférences de l'utilisateur. 
		2. Utiliser Core Data pour stocker et afficher les cinq meilleurs scores par type de partie pour tous les joueurs. 
	
	ÉTAPES
	
		1. CONFIGURATION DE COREDATA :
  
			☺ Si ce n'est pas déjà fait, initialisez Core Data dans votre projet.
			☺ Créez une nouvelle entité nommée "Score" avec les attributs suivants :
				• username: String
				• gameType: String
				• score: Int16
				
		2. SECTION PRÉFÉRENCES D'UTILISATEUR :
	
			Choix de la langue et du thème :
				
				☺ Dans l'onglet "Préférences", ajoutez une interface permettant à l'utilisateur de sélectionner sa langue préférée et le thème de couleur. 				
				☺ Utilisez UserDefaults pour stocker ces préférences. Par exemple : 
					UserDefaults.standard.set(selectedLanguage, forKey: "userLanguage") 
					UserDefaults.standard.set(selectedTheme, forKey: "userTheme")
	
			Affichage et mise à jour des préférences :
			
				☺ Lorsque l'utilisateur ouvre l'onglet "Préférences", récupérez ses préférences à partir de UserDefaults et affichez-les à l'écran.				
				☺ Si l'utilisateur modifie ses préférences, assurez-vous de mettre à jour les informations dans UserDefaults.
				
		3. SECTION SCORES :
		
			Enregistrement des scores :
			
				☺ Chaque fois qu'une partie se termine, enregistrez le score de l'utilisateur dans l'entité "Score".
				☺ Assurez-vous d'associer le score au type de partie jouée (Titre de films ou Mots).
			
			Affichage des scores :
			
				☺ Dans l'onglet "Scores", créez une interface pour afficher les cinq meilleurs scores pour chaque type de partie. 
				☺ Utilisez une requête Core Data pour récupérer les scores et les trier par score et type de jeu.
	
	CONSEILS : 
	
		☺ Bien qu'UserDefaults soit pratique pour stocker des données simples, il n'est pas conçu pour stocker de grandes quantités de données. Utilisez-le judicieusement !
		☺ Rappelez bien de sauver le résultat de toutes les parties avec les informations pertinentes.
		☺ Rappelez-vous d’effacer et remettre à zéro votre simulateur afin d’effacer la BD Core Data et assurez que votre app fonctionne bien.
		☺ Testez régulièrement votre application pour vous assurer que les préférences et les scores sont correctement enregistrés et affichés. 

	BARÈME
	
		Important : Vous n’êtes pas obligé de dessiner le pendu dans votre app, vous pouvez simplement afficher un compteur d’erreurs (0/6, 1/6, etc.).

		Voici le barème approximatif :
	 
		Barème 								[%]
		Utilisation de Core Data pour les scores			30%
		Affichage des 5 meilleurs scores selon le type de partie	25%
		Préférence utilisateur avec « User Default »			15%
		Respect du modèle MVC						10%
		Qualités du code et de la app 					20%
		
		Votre travail sera évalué sur la façon dont vous avez intégré les fonctionnalités requises, 
		la clarté et la structure de votre code, ainsi que sur l'expérience utilisateur globale de votre jeu. 
		Assurez-vous de bien tester votre application pour détecter et résoudre les éventuels problèmes.

		Bon travail !
