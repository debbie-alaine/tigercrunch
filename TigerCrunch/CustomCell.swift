//
//  CustomCell.swift
//  TigerCrunch
//
//  Created by Deborah Sandoval on 4/20/15.
//  Copyright (c) 2015 Deborah Sandoval. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet var foodLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var buildingLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(foodLabelText: String, descriptionLabelText: String, buildingLabelText: String, locationLabelText: String)
    {
        self.foodLabel.text = foodLabelText
        self.descriptionLabel.text = descriptionLabelText
        self.buildingLabel.text = buildingLabelText
        self.locationLabel.text = locationLabelText
    
    }

}
