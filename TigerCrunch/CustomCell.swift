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
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var claimLabel: UILabel!
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    
    var elapsed: String!
    var elapsed_num: Int!

    
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
    
    func setCell(foodLabelText: String, descriptionLabelText: String, buildingLabelText: String, locationLabelText: String, IDText: String, claimLabelText: String, elapsedTimeLabelText: String, expirationLabelText: String)
    {
        self.foodLabel.text = foodLabelText
        self.descriptionLabel.text = descriptionLabelText
        self.buildingLabel.text = buildingLabelText
        self.locationLabel.text = locationLabelText
        self.ID = IDText
        self.claimLabel.text = claimLabelText
        
//        elapsed = elapsedTimeLabelText
//        
//        if elapsed != "-" {
//            let endIndex = advance(elapsed.startIndex, 5)
//            elapsed = elapsed.substringToIndex(endIndex)
//            
//            let startIndex = advance(elapsed.startIndex, 3)
//            elapsed = elapsed.substringFromIndex(startIndex)
//        }
        self.elapsedTimeLabel.text = elapsedTimeLabelText
    }
    
}