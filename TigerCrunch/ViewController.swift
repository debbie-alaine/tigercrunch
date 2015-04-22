//
//  ViewController.swift
//  TigerCrunch
//
//  Created by Deborah Sandoval on 4/20/15.
//  Copyright (c) 2015 Deborah Sandoval. All rights reserved.
//

import UIKit

struct Post {
    var food: String?
    var description: String?
    var building: String?
    var location: String?
    }

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var data: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = dataOfJson("http://ec2-54-191-17-139.us-west-2.compute.amazonaws.com/getFood.php")
        println(data)
        
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
    }
    
    @IBAction func reload() {
        data = dataOfJson("http://ec2-54-191-17-139.us-west-2.compute.amazonaws.com/getFood.php")
        self.myTableView.reloadData()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            self.view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    func dataOfJson(url: String) -> NSArray {
        let data = NSData(contentsOfURL: NSURL(string: url)!)
        println(data)
        return (NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSArray)
    }
    
    // this array should be replaced by the json array
    //let tableData = [
      //  Post(food: "Pizza", description: "Freakin' Awesome", building: "Frist", location: "Rm 212"),
      //  Post(food: "Ice Cream", description: "chocolate", building: "Friend", location: "Rm 402"),
    // Post(food: "Popcorn", description: "Salty", building: "1901", location: "Outside My Room"),
    //    Post(food: "Chicken", description: "Fried", building: "McCosh", location: "Rm 212"),
    //    ]

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // finds the number of elements in array to find number of rows needed
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.data.count;
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomCell
        
        var maindata = (data[indexPath.row] as! NSDictionary)
        var food = maindata["food"] as! String
        var description = maindata["description"] as! String
        var building = maindata["building"] as! String
        var location = maindata["room_info"] as! String
        
        cell.setCell(food, descriptionLabelText: description, buildingLabelText: building, locationLabelText: location)
        
        return cell
    }

}

