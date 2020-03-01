//
//  IngredientTableViewCell.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/29/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet var ingredientName: UILabel!
    @IBOutlet var quantityValue: UILabel!
    @IBOutlet var quantityDescription: UILabel!
    @IBOutlet var ingredientStepper: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
