import UIKit
import CoreData

var myRecipeList = [MyRecipes]()

class RecipeTableViewController: UITableViewController {
           
    //Thanks to youtube channel Code with Cal!
    //link to the video: https://youtu.be/35mKM4IkHS8
    //The code from the video has been modified to fit my app. The main features implemented from the video are Adding,editing and deleting data from coredata
    var firstLoad = true
    
    func nonDeletedRecipes() ->[MyRecipes]
    {
        var NoDeletdmyRecipeList = [MyRecipes]()
        for recipe in myRecipeList
        {
            if(recipe.deletedDate == nil)
            {
                NoDeletdmyRecipeList.append(recipe)
            }
        }
        
        return NoDeletdmyRecipeList
    }
    
    
    override func viewDidLoad() {
        

        if (firstLoad)
        {
            firstLoad = false
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName:"MyRecipes")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let MyRecipes = result as! MyRecipes
                    myRecipeList.append(MyRecipes)
                    
                }
                
            }
            catch
            {
                
                print("Fetch Failed ")
            }
            
        }
        
     
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let RecipeCell = tableView.dequeueReusableCell(withIdentifier: "recipeCellID", for: indexPath) as! RecipeCell
        
        let thisRecipe:MyRecipes!
        
        thisRecipe = nonDeletedRecipes()[indexPath.row]
        
        RecipeCell.namelabel.text = thisRecipe.name
        RecipeCell.healthratinglabel.text = thisRecipe.healthRating
        RecipeCell.ingredientslabel.text = thisRecipe.ingredients
        RecipeCell.recipestepslabel.text = thisRecipe.recipeSteps
        
        
        return RecipeCell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return nonDeletedRecipes().count
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editRecipe", sender: self)
    }
    //if the user clicks on a saved recipe on table view, they are directed to the recipe input form where they can edit the recipe information
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "editRecipe" ){
            let indexPath = tableView.indexPathForSelectedRow!
            
            let recipeDetail = segue.destination as? MyRecipesViewController
            
            let selectedRecipe : MyRecipes!
            selectedRecipe = nonDeletedRecipes()[indexPath.row]
            recipeDetail!.selectedRecipe = selectedRecipe
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}
