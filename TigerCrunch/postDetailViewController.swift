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
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var claimLabel: UILabel!
    @IBOutlet weak var claim_submit: UIButton!
    
    
    var food = String()
    var building = String()
    var room = String()
    var descriptionFood = String()
    
    var elapsedTime = String()
    var time = String()
    var claim = String()
    var ID = String()
    
    override func viewWillAppear(animated: Bool) {
        foodLabel.text = food
        buildingLabel.text = building
        roomLabel.text = room
        descriptionLabel.text = descriptionFood
        
        if elapsedTime != "-" {
            var elapsedSplit = split(elapsedTime) {$0 == ":"}
            elapsedTime = elapsedSplit[0] + "h " + elapsedSplit[1] + "m " + elapsedSplit[2] + "s"
        }
        
        elapsedTimeLabel.text = "Posted " + elapsedTime + " ago"
        var timeToExpirationSplit = split(time) {$0 == ":"}
        timeLabel.text = timeToExpirationSplit[0] + "h " + timeToExpirationSplit[1] + "m " + timeToExpirationSplit[2] + "s"
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
    
    
    @IBAction func claim_press(sender: AnyObject) {
        var urlString = "http://ec2-54-191-17-139.us-west-2.compute.amazonaws.com/claimFood.php?id=ID"
        urlString = urlString.stringByReplacingOccurrencesOfString("ID", withString: ID)
        let urlPost = NSURL(string:urlString)
        let request = NSURLRequest(URL:urlPost!)
        var response: NSURLResponse? = nil
        var error: NSError? = nil
        let reply = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&error)
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
