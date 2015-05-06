//
//  postDetailViewController.swift
//  TigerCrunch
//
//  Created by Peter Yao on 5/4/15.
//  Copyright (c) 2015 Deborah Sandoval. All rights reserved.
//

import UIKit

class postDetailViewController: UIViewController {

    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var claimLabel: UILabel!
    
    
    var food = String()
    var building = String()
    var room = String()
    var descriptionFood = String()
    
    var postTime = String()
    var time = String()
    var claim = String()
    
    override func viewWillAppear(animated: Bool) {
        foodLabel.text = food
        buildingLabel.text = building
        roomLabel.text = room
        descriptionLabel.text = descriptionFood
        
        postTimeLabel.text = postTime + "minutes ago"
        timeLabel.text = time
        claimLabel.text = claim
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
