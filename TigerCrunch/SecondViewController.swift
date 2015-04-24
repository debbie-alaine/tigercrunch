//
//  SecondViewController.swift
//  TigerCrunch
//
//  Created by Deborah Sandoval on 4/22/15.
//  Copyright (c) 2015 Deborah Sandoval. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    // TextFields
    @IBOutlet weak var FoodText: UITextField!
    @IBOutlet weak var DescriptionText: UITextField!
    @IBOutlet weak var BuildingText: UITextField!
    @IBOutlet weak var RoomText: UITextField!
    
    
    // loading the view
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // when you touch the screen, hide the keyboard
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            self.view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    
    // upload the things inside the text fields to the database
    @IBAction func uploadToDatabase() {
        // the php script to add post to database
        var urlString = "http://ec2-54-191-17-139.us-west-2.compute.amazonaws.com/addFood.php?building=BUILDING&room_info=ROOM_INFO&food=FOOD&description=DESCRIPTION"
        // replace attributes with strings in textbox
        urlString = urlString.stringByReplacingOccurrencesOfString("FOOD", withString: FoodText.text)
        urlString = urlString.stringByReplacingOccurrencesOfString("DESCRIPTION", withString: DescriptionText.text)
        urlString = urlString.stringByReplacingOccurrencesOfString("BUILDING", withString: BuildingText.text)
        urlString = urlString.stringByReplacingOccurrencesOfString("ROOM_INFO", withString: RoomText.text)
        
        // run php script
        let urlPost = NSURL(string:urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
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
