//
//  RecipeData.swift
//  Recipe_warehouse_app
//
//  Created by Sameep Rastogi on 12/6/2022.
//

import UIKit
//structure of the recipe object
class RecipeData: NSObject,Decodable {
    
    var title: String
    var id: String?
    var publishedId: String?
    var sourceUrl: String?
    
    
    required init(from decoder: Decoder) throws {
        let recipeContainer = try decoder.container(keyedBy:RecipeKeys.self )
        
        //get recipe information
        title = try recipeContainer.decode(String.self, forKey: .title)
        id = try recipeContainer.decode(String.self, forKey: .id)
        publishedId = try recipeContainer.decode(String.self, forKey: .publishedId)
        sourceUrl = try recipeContainer.decode(String.self, forKey: .sourceUrl)
    }
    
    
    private enum RecipeKeys: String, CodingKey{
        case title
        case id
        case publishedId
        case sourceUrl
    }

}
