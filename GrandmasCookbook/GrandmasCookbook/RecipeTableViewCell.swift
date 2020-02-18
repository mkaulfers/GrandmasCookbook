//
//  RecipeTableViewCell.swift
//  GrandmasCookbook
//
//  Created by Matthew Kaulfers on 2/18/20.
//  Copyright © 2020 Matthew Kaulfers. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    //MARK: - Cell Variables
    @IBOutlet var ribbons: [UIImageView]!
    @IBOutlet var stars: [UIImageView]!
    @IBOutlet var foodImage: UIImageView!
    @IBOutlet var recipeName: UILabel!
    @IBOutlet var cart: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
