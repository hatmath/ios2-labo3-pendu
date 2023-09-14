
import UIKit

class WordStartVC: UIViewController {

    var hangmanGame = HangmanGame.shared
    var wordDownloader = WordDownloader.shared
    
    @IBOutlet weak var lblAide: UILabel!
    @IBOutlet weak var lblMode: UILabel!
    @IBOutlet weak var btnStart: UIButton!
    
    @IBAction func unwindToStart(unwindSegue: UIStoryboardSegue) {}
    
    @IBAction func btnStart(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(identifier: "id_GameVC") as! GameVC
         controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MovieStartView did load")
        
        lblMode.text = "Mode [ Mot du dictionnaire anglais ]"
        lblAide.text = "Aide: Le mot"
        btnStart.setTitle("COMMENCER", for: .normal)
    }


    override func viewWillAppear(_ animated: Bool) {
        print ("WordStartView will appear")
    
        hangmanGame.fetch(usingWordDownloader: true) { success in
            if success {
                // Success handling
                DispatchQueue.main.async {
                    if self.wordDownloader.getCurrentWord() != nil {
                        self.lblAide.text = "Aide: \n" + self.wordDownloader.getCurrentWord()!
                    } else {
                        self.lblAide.text = "ERREUR: wordDownloader.getCurrentMovie()"
                    }
                }
            } else {
                // Failure handling
                DispatchQueue.main.async { self.lblAide.text = "ERREUR hangmanGame.fetch()" }
            }
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        print ("MovieStartView did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("MovieStartView will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print ("MovieStartView did disappear")
    }

}


