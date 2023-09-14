//
//  HangmanGame.swift
//  ios2-labo2-pendu
//
//  Created by Simon Turcotte (2395412) et Mathieu Hatin (2296939)
//

import UIKit
import Foundation

class HangmanGame {
    private var word: String = ""
    private var guessedWord: [Character] = []
    private var incorrectGuessCount = 0
    private var selectedLetters: Set<Character> = []
    private var numberOfGuess = 7
    private var usingWordDownloader: Bool?
    
    static let shared = HangmanGame()
 
    private init() {}
    
    func fetch(usingWordDownloader: Bool, completion: @escaping (Bool) -> Void) {
        if usingWordDownloader {
            self.usingWordDownloader = true
            WordDownloader.shared.fetchRandomWord { result in
                switch result {
                case .success(let item):
                    let title = item.uppercased()
                    self.word = title
                    self.guessedWord = Array(repeating: "_", count: title.count)
                    completion(true)

                case .failure(let error):
                    print("Error fetching word: \(error)")
                    self.word = "DEFAULT"
                    self.guessedWord = Array(repeating: "_", count: 7)
                    completion(false)
                }
            }
        } else {
            self.usingWordDownloader = false
            MovieDownloader.shared.fetchRandomMovie { result in
                switch result {
                case .success(let item):
                    let title = item.Title.uppercased()
                    var initialGuessedWord = [Character]()

                    for char in title {
                        if char.isLetter {
                            initialGuessedWord.append("_")
                        } else {
                            initialGuessedWord.append(char)
                        }
                    }

                    self.word = title
                    self.guessedWord = initialGuessedWord
                    completion(true)

                case .failure(let error):
                    print("Error fetching movie title: \(error)")
                    self.word = "DEFAULT"
                    self.guessedWord = Array(repeating: "_", count: 7)
                    completion(false)
                }
            }
        }
        selectedLetters = []
        incorrectGuessCount = 0
    }

    
    func isWordDownloaderMode() -> Bool? {
        return usingWordDownloader
    }
    
    func makeGuess(letter: Character) {
        let input = String(letter)
        
        let pattern = "^[a-zA-Z]$"
        
        if let _ = input.range(of: pattern, options: .regularExpression) {
            let uppercasedLetter = Character(input.uppercased())
            
            guard !selectedLetters.contains(uppercasedLetter) else {
                return
            }
            
            selectedLetters.insert(uppercasedLetter)
            
            if word.contains(uppercasedLetter) {
                for (index, char) in word.enumerated() {
                    if char == uppercasedLetter {
                        guessedWord[index] = char
                    }
                }
            } else {
                incorrectGuessCount += 1
            }
        }
    }

    
    func getAHint() -> String {
        if usingWordDownloader != nil && usingWordDownloader == false {
            if let movie = MovieDownloader.shared.getCurrentMovie() {
                switch self.getIncorrectGuessCount() {
                case 0:
                    return "Aucun indice pour l'instant"
                case 1:
                    return "Un indice s'en vient"
                case 2:
                    return """
                    Indice:
                    Année de production: \(movie.Released)
                    """
                case 3:
                    return "Aucun indice pour l'instant"
                case 4:
                    return """
                    Indices:
                    Classé: \(movie.Rated)
                    Genre: \(movie.Genre)
                    """
                case 5:
                    return """
                    Indices
                    Réalisateur(s): \(movie.Director)
                    Acteur(s): \(movie.Actors)
                    """
                case 6:
                    return "Vous avez utilisé tout vos indices"
                case 7:
                    return "Vous avez utilisé tout vos indices"
                default:
                    return "Aucun indice"
                }
            }
            return ""
        } else {
            return ""
        }
    }
    
    func compareCharacterArraysIgnoringSpaces(_ array1: [Character], _ array2: [Character]) -> Bool {
        let string1 = String(array1.filter { $0 != "_" })
        let string2 = String(array2.filter { $0 != " " })
        print(string1)
        print(string2)
        return string1 == string2
    }
    
    func isWordGuessed() -> Bool {
        return compareCharacterArraysIgnoringSpaces(guessedWord,Array(word))
    }
    
    func isGameOver() -> Bool {
        return incorrectGuessCount >= numberOfGuess || isWordGuessed()
    }
    
    func getGuessedWord() -> String {
        return guessedWord.map { String($0) }.joined(separator: " ")
    }
    
    func getNumberOfGuess() -> Int {
        return numberOfGuess
    }
    
    func getIncorrectGuessCount() -> Int {
        return incorrectGuessCount
    }
    
    func getSelectedLetters() -> Set<Character> {
        return selectedLetters
    }
    
    func getCurrentImageName() -> String {
        switch getIncorrectGuessCount() {
        case 0:
            return "0_echafaud"
        case 1:
            return "1_tete"
        case 2:
            return "2_corps"
        case 3:
            return "3_bras_gauche"
        case 4:
            return "4_bras_droit"
        case 5:
            return "5_jambe_gauche"
        case 6:
            return "6_jambe_droite"
        case 7:
            return "7_final"
        default:
            return "7_final"
        }
    }
    
}

