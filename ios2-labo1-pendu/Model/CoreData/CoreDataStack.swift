
import Foundation
import CoreData

final class CoreDataStack {
    // MARK: - Singleton
    static let shared = CoreDataStack()

    // MARK: - Private
    private init() {
        // Perform Core Data setup here
        let container = NSPersistentContainer(name: "BestScores")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        persistentContainer = container
    }

    private let persistentContainer: NSPersistentContainer

    // MARK: - Public
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
