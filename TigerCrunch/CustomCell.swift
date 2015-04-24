//
//  CustomCell.swift
//  TigerCrunch
//
//  Created by Deborah Sandoval on 4/20/15.
//  Copyright (c) 2015 Deborah Sandoval. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    // variables to be filled in by the JSON
    @IBOutlet var foodLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var buildingLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    // ID string related to cell, used for deletion
    var ID = "" as String
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setCell(foodLabelText: String, descriptionLabelText: String, buildingLabelText: String, locationLabelText: String, IDText: String)
    {
        self.foodLabel.text = foodLabelText
        self.descriptionLabel.text = descriptionLabelText
        self.buildingLabel.text = buildingLabelText
        self.locationLabel.text = locationLabelText
        self.ID = IDText
    }
    
}