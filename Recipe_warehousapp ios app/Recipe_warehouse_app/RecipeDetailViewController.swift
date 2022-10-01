

import UIKit
//this view controller displays the image and recipe name passed from the home view controller
class RecipeDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var img: UIImageView!
  
    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    let ingredients = ["1. onion 2x", "2. lemon 1x", "3. chicken breast 400gm ", "4. tomatoes 3x"]
    let recipeSteps  = ["1. Chop onions", "2. Shallow fry onions", "3. marinate chicken breast", "4. fry chicken breast"]
    
    
    
    
    var name = ""
    
    var recipeDetail = ""
    
   
        
    override func viewDidLoad() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.systemOrange.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
 
        super.viewDidLoad()
        lbl.text = name
        img.image = UIImage(named: name)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch SegmentedControl.selectedSegmentIndex {
        case 0:
            return ingredients.count
            
        case 1:
            return recipeSteps.count
        default:
            break
        }
        
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch SegmentedControl.selectedSegmentIndex {
        case 0:
            cell.textLabel?.text = ingredients[indexPath.row]
            
        case 1:
            cell.textLabel?.text = recipeSteps[indexPath.row]
            default:
            break
            
        }
        return cell 
    }
    
    
    @IBAction func segmentedChanged(_ sender: Any) {
        tableView.reloadData()
    }
    

    

}
