
import Foundation
import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var langueTog: UISwitch!
    @IBOutlet weak var couleurTog: UISwitch!
    @IBOutlet weak var langText: UILabel!
    @IBOutlet weak var coulText: UILabel!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var loadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLanguageLabel()
        updateColorLabel()
        
        langueTog.addTarget(self, action: #selector(toggleLangue), for: .valueChanged)
        couleurTog.addTarget(self, action: #selector(toggleCouleur), for: .valueChanged)
        loadPreferences()
    }
    
    @objc func toggleLangue() {
        updateLanguageLabel()
    }
    
    @objc func toggleCouleur() {
        updateColorLabel()
    }
    
    func updateLanguageLabel() {
        langText.text = langueTog.isOn ? "English" : "Francais"
    }
    
    func updateColorLabel() {
        coulText.text = couleurTog.isOn ? "Fonce" : "Clair"
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {

        guard let name = nameInput.text, !name.isEmpty else {
            showAlert(message: "Entrez un nom.")
            return
        }

        let isEnglish = langueTog.isOn
        let isDarkMode = couleurTog.isOn

        let preferences: [String: Any] = [
            "IsEnglish": isEnglish,
            "IsDarkMode": isDarkMode
        ]

        UserDefaults.standard.set(preferences, forKey: name)

        showAlert(message: "Preferences sauvegardees!")
    }
    
    @IBAction func loadButtonPressed(_ sender: UIButton) {
        guard let name = nameInput.text, !name.isEmpty else {
            showAlert(message: "Entrer un nom.")
            return
        }

        if let preferences = UserDefaults.standard.dictionary(forKey: name) {
            if let isEnglish = preferences["IsEnglish"] as? Bool,
               let isDarkMode = preferences["IsDarkMode"] as? Bool {
                langueTog.isOn = isEnglish
                couleurTog.isOn = isDarkMode
                updateLanguageLabel()
                updateColorLabel()
                showAlert(message: "Preferences restaurees!")
            }
        } else {
            showAlert(message: "Aucune preference pour ce nom.")
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func loadPreferences() {

        if let name = nameInput.text, !name.isEmpty {
            if let preferences = UserDefaults.standard.dictionary(forKey: name) {
                if let isEnglish = preferences["IsEnglish"] as? Bool,
                   let isDarkMode = preferences["IsDarkMode"] as? Bool {
                    langueTog.isOn = isEnglish
                    couleurTog.isOn = isDarkMode
                    updateLanguageLabel()
                    updateColorLabel()
                    showAlert(message: "Preferences chargees!")
                }
            }
        }
    }
}
