
import UIKit

class MovieStartVC: UIViewController {

    var hangmanGame = HangmanGame.shared
    var movieDownloader = MovieDownloader.shared    
    
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
        lblMode.text = "Mode [ Titre de film ]"
        lblAide.text = "Aide: année, réalisateur, genre, ..."
        btnStart.setTitle("COMMENCER", for: .normal)        
    }

    override func viewWillAppear(_ animated: Bool) {
        print ("MovieStartView will appear")

        hangmanGame.fetch(usingWordDownloader: false) { success in
            if success {
                // Success handling
                DispatchQueue.main.async {
                    if self.movieDownloader.getCurrentMovie() != nil {
                        self.lblAide.text = "Aide: \n" + self.movieDownloader.toString(self.movieDownloader.getCurrentMovie()!)
                    } else {
                        self.lblAide.text = "ERREUR: movieDownloader.getCurrentMovie()"
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

