//
//  Score.swift
//  ios2-labo2-pendu
//
//  Created by Simon Turcotte (2395412) et Mathieu Hatin (2296939)
//

import Foundation

import Foundation

class Score {
    static let shared = Score()
    
    private let userDefaults = UserDefaults.standard
    
    // Key for the UserDefaults
    private let keyScores = "Scores"
    
    struct ScoreData: Codable {
        let user: String
        let mode: Int
        let score: Int
    }
    
    var scores: [ScoreData] {
        get {
            if let data = userDefaults.data(forKey: keyScores) {
                do {
                    let decoder = JSONDecoder()
                    let scores = try decoder.decode([ScoreData].self, from: data)
                    return scores
                } catch {
                    print("Error decoding scores data: \(error)")
                }
            }
            return []
        }
        set {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(newValue)
                userDefaults.set(data, forKey: keyScores)
            } catch {
                print("Error encoding scores data: \(error)")
            }
        }
    }
    
    func createAndSaveScore(user: String, mode: Int, score: Int) {
        let newScore = ScoreData(user: user, mode: mode, score: score)
        var savedScores = scores
        savedScores.append(newScore)
        scores = savedScores
        synchronize()
    }
    
    func retrieveAndPrintScores() {
        let savedScores = scores
        for score in savedScores {
            print("User: \(score.user), Mode: \(score.mode), Score: \(score.score)")
        }
    }
    
    func getAllScoresAsString() -> String {
        let savedScores = scores
        var scoresString = ""
        
        for score in savedScores {
            let scoreString = "User: \(score.user), Mode: \(score.mode), Score: \(score.score)\n"
            scoresString.append(scoreString)
        }
        
        return scoresString
    }
    
    func getBestScoresByUserAsString() -> String {
        let savedScores = scores
        
        var bestScoresByUser = [String: ScoreData]()
        
        for score in savedScores {
            if let existingBestScore = bestScoresByUser[score.user] {
                if score.score < existingBestScore.score {
                    bestScoresByUser[score.user] = score
                }
            } else {
                bestScoresByUser[score.user] = score
            }
        }
        
        var bestScoresString = ""
        
        for (_, bestScore) in bestScoresByUser {
            let scoreString = "User: \(bestScore.user), Mode: \(bestScore.mode), Best Score: \(bestScore.score)\n"
            bestScoresString.append(scoreString)
        }
        
        return bestScoresString
    }
    
    func getBestScoresByUserAsStringFrenchAndFormat() -> String {
        let savedScores = scores
        
        var bestScoresByUser = [String: ScoreData]()
        
        for score in savedScores {
            if let existingBestScore = bestScoresByUser[score.user] {
                if score.score < existingBestScore.score {
                    bestScoresByUser[score.user] = score
                }
            } else {
                bestScoresByUser[score.user] = score
            }
        }
        
        var bestScoresString = "Joueur\t\t\tMode(1-2)\t\tPointage (0-6)\n"
        
        for (_, bestScore) in bestScoresByUser {
            let paddedString = bestScore.user.padding(toLength: 12, withPad: "_", startingAt: 0)
            let scoreString = "\(paddedString)\t\t\t\(bestScore.mode)\t\t\t\(bestScore.score)\n"
            bestScoresString.append(scoreString)
        }
        bestScoresString.append("\nMode 1: Mot du dictionnaire anglais\n")
        bestScoresString.append("Mode 2: Titre de film\n")
        return bestScoresString
    }
    
    func eraseAllScores() {
        scores = []
        synchronize()
    }
    
    func synchronize() {
        userDefaults.synchronize()
    }
    
}
