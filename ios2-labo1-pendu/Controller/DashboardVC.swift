
import UIKit

class DashboardVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("DashboardView did load")
    }

    override func viewWillAppear(_ animated: Bool) {
        print ("DashboardView will appear")        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print ("DashboardView did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print ("DashboardView will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print ("DashboardView did disappear")
    }
    
}
