
import UIKit
import FirebaseAuth
import FirebaseCore
import SwiftUI

//this view controller has some default values demonstrating delegation and the use of collection views


// Thanks to channel Emanuel Okwara: https://youtu.be/aU_kTzMZHQ8
// Learned more in depth about collection views from this tutorial. none of the code is used however this was a learning resource.
class ViewController: UIViewController{
   
    
    var defaultrecipes = ["kebabs",
                    "chicken rice",
                    "spaghetti",
                    "thai curry",
                    "pizza",
                    "lamb chops"
      ]

    
    
    

    @IBAction func signOut(_ sender: Any) {
        Task{
            do{
                try Auth.auth().signOut()
            } catch {
                print("Log out error: \(error.localizedDescription)")
            }
            navigationController?.popViewController(animated: true)
        }
    }
    
    //
    @IBOutlet weak var collectionView: UICollectionView!
//
//
    override func viewDidLoad() {
        super.viewDidLoad()
        

    collectionView.delegate = self
    collectionView.collectionViewLayout = UICollectionViewFlowLayout()

    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return defaultrecipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DataCollectionViewCell
        cell?.img.image = UIImage(named: defaultrecipes[indexPath.row])
        cell?.lbl.text = defaultrecipes[indexPath.row]
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc =  storyboard?.instantiateViewController(withIdentifier: "RecipeDetailViewController") as? RecipeDetailViewController
        vc?.name = defaultrecipes[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
}



extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        return CGSize(width: bounds.width/2-10 , height: bounds.height/3) //Makes the size constant for any device

    }
}


