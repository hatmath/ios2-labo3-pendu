
import UIKit

class ScoreTestingVC: UIViewController {
    
    @IBOutlet weak var txtScore: UITextField!
    @IBOutlet weak var txtMode: UITextField!
    @IBOutlet weak var txtPlayer: UITextField!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBAction func savePush(_ sender: Any) {
        
        var msg = ""
        let player: String? = txtPlayer.text
        let mode: String? = txtMode.text
        let score: String? = txtScore.text
        lblMessage.textColor = UIColor.red
        
        if player != "" {
            if mode != "" {
                if score != "" {
                    // Create and save a score
                    Score.shared.createAndSaveScore(user: player!, mode: Int(mode!)!, score: Int(score!)!)
                    
                    lblMessage.textColor = UIColor.blue
                    msg = "Pointage enregistré"
                    txtPlayer.text = ""
                    txtMode.text = ""
                    txtScore.text = ""
                } else {
                    msg = "Aucun pointage"
                }
            } else {
                msg = "Aucun mode"
            }
        } else {
            msg = "Aucun joueur"
        }
        lblMessage.text = msg        
    }
    
    @IBAction func eraseAllPush(_ sender: Any) {
        // Erase all scores
        Score.shared.eraseAllScores()
        lblMessage.textColor = UIColor.blue
        lblMessage.text = "Pointages effacés"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ScoreTestingView did load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print ("ScoreTestingView will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print ("ScoreTestingView did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("ScoreTestingView will disappear")
        super.viewWillDisappear(animated)
        if let firstVC = presentingViewController as? ScoreVC {
            DispatchQueue.main.async {
                firstVC.viewWillAppear(animated)
            }
        }
    }
        
    override func viewDidDisappear(_ animated: Bool) {
        print ("ScoreTestingView did disappear")
    }
        
}
