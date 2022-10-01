//
//  RecipeDetailViewController.swift
//  Recipe_warehouse_app
//
//  Created by Sameep Rastogi on 4/6/2022.
//

import UIKit
import CoreData

class MyRecipesViewController: UIViewController {
//input field categories of recipe information that can be stored in coredata
    @IBOutlet weak var HealthRatingTF: UITextField!
    @IBOutlet weak var IngredientsTV: UITextView!
    @IBOutlet weak var RecipeStepsTV: UITextView!
    @IBOutlet weak var NameTF: UITextField!
    
    var selectedRecipe: MyRecipes? = nil 
    
   
    static let NOTIFICATION_IDENTIFIER = "Recipe.warehouse.notifications"
    lazy var appDelegate = {
       return UIApplication.shared.delegate as! AppDelegate
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        if let response = UserDefaults.standard.string(forKey: "response") {
            print("There was a stored response: \(response)")
        }
        else {
            print("No stored response")
        }
        
        if (selectedRecipe != nil )
        {
            NameTF.text = selectedRecipe?.name
            IngredientsTV.text = selectedRecipe?.ingredients
            RecipeStepsTV.text = selectedRecipe?.recipeSteps
            HealthRatingTF.text = selectedRecipe?.healthRating
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.systemOrange.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)


       
    }
    //Thanks to youtube channel Code with Cal!
    //link to the video: https://youtu.be/35mKM4IkHS8
    //The code from the video has been modified to fit my app. The main features implemented from the video are Adding,editing and deleting data from coredata

    
    
    @IBAction func saveAction(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        if (selectedRecipe == nil)
        {
        let entity = NSEntityDescription.entity(forEntityName: "MyRecipes", in: context)
        let newRecipe = MyRecipes(entity: entity!, insertInto: context)
        newRecipe.id = myRecipeList.count as NSNumber
        newRecipe.name = NameTF.text
        newRecipe.healthRating = HealthRatingTF.text
        newRecipe.ingredients = IngredientsTV.text
        newRecipe.recipeSteps = RecipeStepsTV.text
        
        do{
            
           try context.save()
            myRecipeList.append(newRecipe)
            navigationController?.popViewController(animated: true)

        }
        catch {
            print("Context save error ")
        }
        }
        else //edit the recipe
        {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName:"MyRecipes")
            do {
                let results:NSArray = try context.fetch(request) as NSArray
                for result in results {
                    let MyRecipes = result as! MyRecipes
                    if (MyRecipes == selectedRecipe)
                    {
                        MyRecipes.name = NameTF.text
                        MyRecipes.healthRating = HealthRatingTF.text
                        MyRecipes.recipeSteps = RecipeStepsTV.text
                        MyRecipes.ingredients = IngredientsTV.text
                        try context.save()
                        navigationController?.popViewController(animated: true)
                    }
                }
                
            }
            catch
            {
                
                print("Fetch Failed ")
            }
        }
        guard appDelegate.notificationsEnabled == true else {
            print("Notifications are disabled")
            return
        }
        //Thanks to FIT3178 week 10 pre-class resources for Local notifications. Video/pdf uploaded by cheif examiner Michael Wybrow. The resource was used to implement local noitifications within the recipe warehouse app. The functionality has been modified according to my app.
        let content = UNMutableNotificationContent()
        //the notification content to be displayed to the user
        content.title = "Hey User!"
        content.body = "Just a reminder to go grocery shopping for the recipes you have decided to cook : )"
        
        //When the user clicks on the save button, the recipe is saved to coredata. 5 seconds after the recipe is saved, the user gets a notification to go grocery shopping for the recipe ingredients.
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: MyRecipesViewController.NOTIFICATION_IDENTIFIER, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        print("Notification scheduled.")
       
        
        
        
        
    }
// the delete button deletes the recipes from coredata and removes them from the my recipes table view
    @IBAction func DeleteRecipe(_ sender: Any)
    
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"MyRecipes")
        do {
            let results:NSArray = try context.fetch(request) as NSArray
            for result in results {
                let MyRecipes = result as! MyRecipes
                if (MyRecipes == selectedRecipe)
                {
                    MyRecipes.deletedDate = Date()
                    try context.save()
                    navigationController?.popViewController(animated: true)
                }
            }
            
        }
        catch
        {
            
            print("Fetch Failed ")
        }
    }
}
