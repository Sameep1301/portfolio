
import UIKit
//This view controller contains information about all the third party frameworks utilized in the app
class AboutViewController: UIViewController {

  
    
    
    override func viewWillAppear(_ animated: Bool) {
     
        
        
        //gradient color to enhance the UI of the App
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.systemOrange.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
