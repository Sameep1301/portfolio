//
//  SearchRecipesTableViewController.swift
//  Recipe_warehouse_app
//
//  Created by Sameep Rastogi on 12/6/2022.
//

import UIKit
// Thanks to FIT3178 lab 05. The code has been modified to work with my recipe API.

//Thanks to Recipe heruko app for the API.https://recipesapi.herokuapp.com/
class SearchRecipesTableViewController: UITableViewController, UISearchBarDelegate {

    let CELL_RECIPE = "recipeCell"
    let REQUEST_STRING = "https://recipesapi.herokuapp.com/api/v2/recipes?q="
    
    let MAX_ITEMS_PER_REQUEST = 40
    let MAX_REQUESTS = 10
    var currentRequestIndex: Int = 0
    
    
    var newrecipes = [RecipeData]()
    
    var indicator = UIActivityIndicatorView()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Ingredients/Recipes for recommendations "
        searchController.searchBar.showsCancelButton = false
        navigationItem.searchController = searchController
        
        // Makes sure that the search bar is visible at all times
        navigationItem.hidesSearchBarWhenScrolling = false

    
        //loading indicator
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo:
            view.safeAreaLayoutGuide.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        

        
    
    }
    
    
    func requestRecipesNamed(_ recipeName:String) async {
        

    //The URLComponents class allows us to neatly build URLs from its various components
        var searchURLComponents = URLComponents()
        searchURLComponents.scheme = "https"
        searchURLComponents.host = "recipesapi.herokuapp.com"
        searchURLComponents.path = "/api/v2/recipes"
        searchURLComponents.queryItems = [
            URLQueryItem(name: "maxResults", value: "\(MAX_ITEMS_PER_REQUEST)"),
            URLQueryItem(name: "StartIndex", value: "\(currentRequestIndex * MAX_ITEMS_PER_REQUEST)"),
            URLQueryItem(name: "q", value: recipeName)
        ]
        
        
        guard let postRequest = searchURLComponents.url else {
            print("Invalid URL.")
            return
        }
        
        
        //code for parsing json
        let urlRequest = URLRequest(url: postRequest)
        
        do {
            let(data, _) = try await URLSession.shared.data(for: urlRequest)
            DispatchQueue.main.async{
                self.indicator.stopAnimating()
            }
            
            
            do {
                let decoder = JSONDecoder()
                let volumeData = try decoder.decode(VolumeData.self, from: data)
                
                print(volumeData.recipes)
                if let recipes = volumeData.recipes {
                    newrecipes.append(contentsOf: recipes)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    if recipes.count == MAX_ITEMS_PER_REQUEST,  currentRequestIndex + 1 < MAX_REQUESTS {
                        
                        currentRequestIndex += 1
                        await requestRecipesNamed(recipeName)
                    }
                }
            } catch let error {
                print(error)
            }
        }
        catch let error {
            print(error)
        }
        
        
        
        
               
                                                                       
                                                                       
                                                                       
                                        
    }
    
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        newrecipes.removeAll()
        tableView.reloadData()
        
        
        guard let searchText = searchBar.text?.lowercased()else{
            return}
        
        if searchText != ""{
        navigationItem.searchController?.dismiss(animated: true)
        indicator.startAnimating()
        Task {
            URLSession.shared.invalidateAndCancel()
            await requestRecipesNamed(searchText)
        }
        }
    }
        
        
        
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newrecipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath)
        
        //configuring the cell
        let recipe = newrecipes[indexPath.row]
        cell.textLabel?.text = recipe.title
        cell.detailTextLabel?.text = recipe.publishedId
        //add more attributes later
//        cell.detailTextLabel?.
        return cell
    }

   

}
