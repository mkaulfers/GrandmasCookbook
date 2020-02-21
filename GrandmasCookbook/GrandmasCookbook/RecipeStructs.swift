//
//  RecipeStructs.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/18/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import Foundation

class Recipes {
    var recipes: [Recipe]
    
    init()
    {
        self.recipes = [Recipe]()
    }
    
    init(recipes: [Recipe])
    {
        self.recipes = recipes
    }
}

class Recipe {
    var vegetarian: Bool?
    var veryHealthy: Bool?
    var veryPopular: Bool?
    var id: Int?
    var readyInMinutes: Int?
    var title: String?
    var extendedIngredients: [Ingredient]?
    var image: String?
    var instructions: String?
    
    init()
    {
        vegetarian = false
        veryHealthy = false
        veryPopular = false
        id = 0
        readyInMinutes = 0
        title = "Unknown"
        extendedIngredients = [Ingredient]()
        image = "No Image"
        instructions = "No Instructions"
    }
    
    init(vegetarian: Bool, veryHealthy: Bool, veryPopular: Bool, id: Int, readyInMinutes: Int, title: String, extendedIngredients: [Ingredient], image: String, instructions: String)
    {
        self.vegetarian = vegetarian
        self.veryHealthy = veryHealthy
        self.veryPopular = veryPopular
        self.id = id
        self.readyInMinutes = readyInMinutes
        self.title = title
        self.extendedIngredients = extendedIngredients
        self.image = image
        self.instructions = instructions
    }
}

class Ingredient{
    var id: Int
    var name: String
    var measures: Measure
    
    init()
    {
        id = 0
        name = "Unknown"
        measures = Measure()
    }
    
    init(id: Int, name: String, measures: Measure)
    {
        self.id = id
        self.name = name
        self.measures = measures
    }
}

class Measure{
    var us: Measurement
    var metric: Measurement
    
    init()
    {
        us = Measurement()
        metric = Measurement()
    }
    
    init(us: Measurement, metric: Measurement)
    {
        self.us  = us
        self.metric = metric
    }
}

class Measurement{
    var amount: Double
    var unitShort: String
    var unitLong: String
    
    init()
    {
        amount = 0.0
        unitShort = "???"
        unitLong = "Unknown"
    }
    
    init(amount: Double, unitShort: String, unitLong: String)
    {
        self.amount = amount
        self.unitShort = unitShort
        self.unitLong = unitLong
    }
}



