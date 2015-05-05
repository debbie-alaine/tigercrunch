//
//  SecondViewController.swift
//  TigerCrunch
//
//  Created by Deborah Sandoval on 4/22/15.
//  Copyright (c) 2015 Deborah Sandoval. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // TextFields
    @IBOutlet weak var FoodText: UITextField!
    @IBOutlet weak var DescriptionText: UITextField!
    @IBOutlet weak var RoomText: UITextField!
    @IBOutlet weak var DisplayLabel: UILabel!
    @IBOutlet weak var BuildingLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    let pickerData = ["Mozzarella","Gorgonzola","Provolone","Brie","Maytag Blue","Sharp Cheddar","Monterrey Jack","Stilton","Gouda","Goat Cheese", "Asiago"]
    
    // loading the view
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.delegate = self
        picker.dataSource = self
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
        if FoodText.text != "" && RoomText.text != "" {
        urlString = urlString.stringByReplacingOccurrencesOfString("FOOD", withString: FoodText.text)
        urlString = urlString.stringByReplacingOccurrencesOfString("DESCRIPTION", withString: DescriptionText.text)
        urlString = urlString.stringByReplacingOccurrencesOfString("ROOM_INFO", withString: RoomText.text)
        urlString = urlString.stringByReplacingOccurrencesOfString("BUILDING", withString: BuildingLabel.text!)
        
        // run php script
        let urlPost = NSURL(string:urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        let request = NSURLRequest(URL:urlPost!)
        var response: NSURLResponse? = nil
        var error: NSError? = nil
        let reply = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&error)
            
        performSegueWithIdentifier("submit", sender: self)
            
        }
            
        else {
            DisplayLabel.textColor = UIColor.redColor()
            DisplayLabel.text = "Missing Required Field"
        }
    }
    
    //MARK: - Delegates and data sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        BuildingLabel.text = pickerData[row]
    }
}
