
import Foundation
import CoreData

class ScoreManager {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func saveHighScore(playerName: String, gameMode: Int16, score: Int16) {
        let newHighScore = BestScores(context: context)
        newHighScore.name = playerName
        newHighScore.mode = gameMode
        newHighScore.score = score

        do {
            try context.save()
            print("High score saved successfully.")
        } catch {
            print("Error saving high score: \(error.localizedDescription)")
        }
    }

    func getHighScores(for gameMode: Int16) -> [BestScores] {
        let fetchRequest: NSFetchRequest<BestScores> = BestScores.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "mode == %d", gameMode)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "score", ascending: false)]

        do {
            let highScores = try context.fetch(fetchRequest)
            return highScores
        } catch {
            print("Error fetching high scores: \(error.localizedDescription)")
            return []
        }
    }
}
