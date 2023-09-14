//
//  ScoreVC.swift
//  ios2-labo2-pendu
//
//  Created by Simon Turcotte (2395412) et Mathieu Hatin (2296939)
//
import UIKit

class ScoreVC: UIViewController {

    @IBOutlet weak var lblScore: UILabel!
    
    let scoreManager = ScoreManager(context: CoreDataStack.shared.viewContext)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ScoreView did load")
    }
    
    func showScore() {
       
        let bestScoresMode1 = scoreManager.getHighScores(for: 1) // Mode 1
        let bestScoresMode2 = scoreManager.getHighScores(for: 2) // Mode 2

        let sortedScoresMode1 = bestScoresMode1.sorted { $0.score < $1.score }
        let sortedScoresMode2 = bestScoresMode2.sorted { $0.score < $1.score }

        let topScoresMode1 = Array(sortedScoresMode1.prefix(5))
        let topScoresMode2 = Array(sortedScoresMode2.prefix(5))

        var scoresString = "Top Scores - Mode Dictionnaire:\n"
        for (index, score) in topScoresMode1.enumerated() {
            let playerName = score.name ?? "Inconnu"
            scoresString += "\(index + 1). Nom: \(playerName), Score: \(score.score)\n"
        }
        
        scoresString += "\nTop Scores - Mode Films:\n"
        for (index, score) in topScoresMode2.enumerated() {
            let playerName = score.name ?? "Inconnu"
            scoresString += "\(index + 1). Nom: \(playerName), Score: \(score.score)\n"
        }

        lblScore.text = scoresString
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ScoreView will appear")
        showScore()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ScoreView did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ScoreView will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ScoreView did disappear")
    }
}
