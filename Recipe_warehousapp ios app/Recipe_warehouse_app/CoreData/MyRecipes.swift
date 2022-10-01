import CoreData

@objc(MyRecipes)
class MyRecipes: NSManagedObject{
    //recipe attributes saved in coredata
    @NSManaged var id: NSNumber!
    @NSManaged var name: String!
    @NSManaged var ingredients: String!
    @NSManaged var recipeSteps: String!
    @NSManaged var healthRating: String!
    @NSManaged var deletedDate: Date!
    

}
