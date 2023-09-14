
import UIKit

class GameEndVC: UIViewController {
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var btnHome: UIButton!
    
    var hangmanGame = HangmanGame.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MovieEndView did load")
        btnHome.setTitle("ACCUEIL", for: .normal)
        if hangmanGame.isWordGuessed() {
            let mode = hangmanGame.isWordDownloaderMode()! ? "Mot du dictionnaire" : "Titre de film"
            lblMessage.text =
                """
                BRAVO!!
                Votre score est:
                \(hangmanGame.getIncorrectGuessCount()) erreur(s) en \(hangmanGame.getNumberOfGuess()) tentatives
                en mode [ \(mode) ]
                """
            lblName.text =
                """
                Entrer votre nom
                pour sauvegarder votre score
                """
            txtName.text = ""
        } else {
            lblMessage.text = "Meilleure chance la prochaine fois"
            lblName.text = ""
            txtName.isHidden = true
        }
        
    }
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        saveScore()  
        let controller = storyboard?.instantiateViewController(identifier: "id_HomeTabBar") as! UITabBarController
         controller.modalPresentationStyle = .fullScreen
         present(controller, animated: true, completion: nil)
    }
    
    func saveScore() {
        if hangmanGame.isWordGuessed() {
            if txtName.text != "" {
                let playerName = txtName.text!
                let gameMode = hangmanGame.isWordDownloaderMode()! ? 1 : 2
                let scoreValue = hangmanGame.getIncorrectGuessCount()
                
                // Create a ScoreManager instance using your CoreDataStack's context
                let scoreManager = ScoreManager(context: CoreDataStack.shared.viewContext)
                
                // Save the high score using the ScoreManager
                scoreManager.saveHighScore(playerName: playerName, gameMode: Int16(gameMode), score: Int16(scoreValue))
            }
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        print ("MovieEndView will appear")        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print ("MovieEndView did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("MovieEndView will disappear")
        performSegue(withIdentifier: "unwindToStart", sender: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print ("MovieEndView did disappear")
    }
    
}
