//
//  VolumeData.swift
//  Recipe_warehouse_app
//
//  Created by Sameep Rastogi on 12/6/2022.
//

import UIKit
//structure of volume data
class VolumeData: NSObject, Decodable {
    
    var recipes: [RecipeData]?
    private enum CodingKeys: String, CodingKey {
        case recipes = "recipes"
    }
    
}
