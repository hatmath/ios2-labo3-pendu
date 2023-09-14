//
// GameVC.swift
//  ios2-labo2-pendu
//
//  Created by Simon Turcotte (2395412) et Mathieu Hatin (2296939)
//

import UIKit

class GameVC: UIViewController {

    @IBOutlet weak var txtFieldUneLettre: UITextField!
    @IBOutlet weak var txtFieldLesLettres: UITextField!
    @IBOutlet weak var btnValider: UIButton!
    @IBOutlet weak var lblDevinette: UILabel!
    @IBOutlet weak var imgViewPendu: UIImageView!
    @IBOutlet weak var lblPointage: UILabel!
    @IBOutlet weak var btnRejouer: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    
    var hangmanGame = HangmanGame.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        print ("MovieView will appear")

        txtFieldUneLettre.text = ""
        txtFieldLesLettres.text = ""
        txtFieldLesLettres.isUserInteractionEnabled = false
        lblPointage.text = ""
        btnRejouer.isHidden = false
        lblMessage.text = ""
        imgViewPendu.image = UIImage(named: "0_echafaud")
        lblDevinette.text = hangmanGame.getGuessedWord()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print ("MovieView will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print ("MovieView did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("MovieView will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print ("MovieView did disappear")
    }    

    @IBAction func pushValider(_ sender: Any) {
        
        if hangmanGame.getIncorrectGuessCount() < hangmanGame.getNumberOfGuess() {
            if let letter = txtFieldUneLettre.text?.first {

                hangmanGame.makeGuess(letter: letter)

                imgViewPendu.image = UIImage(named: hangmanGame.getCurrentImageName())!
                
                txtFieldLesLettres.text = hangmanGame.getSelectedLetters().sorted().map { String($0) }.joined(separator: ", ")
                lblPointage.text = "Pointage: \(hangmanGame.getIncorrectGuessCount())/\(hangmanGame.getNumberOfGuess() )"
                lblDevinette.text = hangmanGame.getGuessedWord()
                lblMessage.text = hangmanGame.getAHint()
                                                                     
                 if hangmanGame.isGameOver() || hangmanGame.isWordGuessed() {
                    let controller = storyboard?.instantiateViewController(identifier: "id_GameEndVC") as! GameEndVC
                     controller.modalPresentationStyle = .fullScreen
                     present(controller, animated: true, completion: nil)
                 }
            }
        }

        txtFieldUneLettre.text = ""
    }

    @IBAction func pushRejouer(_ sender: Any) {
       let controller = storyboard?.instantiateViewController(identifier: "id_HomeTabBar") as! UITabBarController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)        
    }
    
}
