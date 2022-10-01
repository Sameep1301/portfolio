

import UIKit
import FirebaseAuth
import FirebaseCore


//login functionality 
class AuthViewController: UIViewController {
    
    
    var authController: Auth
    
    var authHandle: AuthStateDidChangeListenerHandle?
    

    //initialization of variables
    required init?(coder aDecoder: NSCoder){
        authController = Auth.auth()
        super.init(coder: aDecoder)
    }
    
 
        


    
    
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //thanks to FIT3178 week 10 firebase lab for the login funcionality. The code has been modified for the purpose of my app
    @IBAction func registerAccount(_ sender: Any) {
        guard let password = passwordTextField.text else {
        displayMessage(title: "Error", message: "Please enter a password")
            return
        }
        guard let email = emailTextField.text else {
            displayMessage(title: "Error", message: "Please enter an email")
            return
        }
        
        Task{
            do{
                let AuthDataresult = try wait
                authController.createUser(withEmail: email, password: password)
            }
        }
    }
    
    //click on the button logs the user into the app
    @IBAction func loginToAccount(_ sender: Any) {
        guard let password = passwordTextField.text else {
        displayMessage(title: "Error", message: "Please enter a password")
            return
        }
        guard let email = emailTextField.text else {
            displayMessage(title: "Error", message: "Please enter an email")
            return
        }
        Task {
            do{
                let AuthDataresult = try wait
                authController.signIn(withEmail: email, password: password)
            } catch {
                displayMessage(title: "error", message: "Firebase Authentication failed with error :\(String(describing: error))")
                
                
            }
            
        }
    }
    //for displaying error messages 
    func displayMessage(title: String, message: String){
        let alertController = UIAlertController(title: title, message:message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        authHandle = Auth.auth().addStateDidChangeListener(){
            (auth, user) in
            guard user != nil else {return}
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }
        
        //gradient color to enhance the UI of the App
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.systemOrange.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let authHandle = authHandle else { return }
        Auth.auth().removeStateDidChangeListener(authHandle)
            
        }

    }
    
//    override func viewDidLoad() {
//
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

//}
