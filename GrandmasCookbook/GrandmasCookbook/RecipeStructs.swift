//
//  RecipeStructs.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/18/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import Foundation

struct Recipes: Codable{
    var recipes: [Recipe]
}

struct Recipe: Codable{
    var vegetarian: Bool?
    var veryHealthy: Bool?
    var veryPopular: Bool?
    var id: Int?
    var readyInMinutes: Int?
    var title: String?
    var extendedIngredients: [Ingredient]?
    var image: String?
    var instructions: String
}

struct Ingredient: Codable{
    var id: Int?
    var name: String?
    var measures: Measure?
}

struct Measure: Codable{
    var us: Measurement?
    var metric: Measurement?
}

struct Measurement: Codable{
    var amount: Double?
    var unitShort: String?
    var unitLong: String?
}



