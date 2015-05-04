//
//  ViewController.swift
//  TigerCrunch
//
//  Created by Deborah Sandoval on 4/20/15.
//  Copyright (c) 2015 Deborah Sandoval. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    var data: NSArray = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        data = dataOfJson("http://ec2-54-191-17-139.us-west-2.compute.amazonaws.com/getFood.php")
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
        if data!.length == 0 {return []}
        else {return (NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSArray)}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // finds the number of elements in array to find number of rows needed
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.data.count;
    }
    
    // creates a cell for each element in the database
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! CustomCell
        
        var maindata = (data[indexPath.row] as! NSDictionary)
        var food = maindata["food"] as! String
        var description = maindata["description"] as! String
        var building = maindata["building"] as! String
        var location = maindata["room_info"] as! String
        var id = maindata["id"] as! String
        
        cell.setCell(food, descriptionLabelText: description, buildingLabelText: building, locationLabelText: location, IDText: id)
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // delete cell from database when you slide and click the delete button
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)]
            
            let ID = data[indexPath.row]["id"] as! String
            print(ID)
            var urlString = "http://ec2-54-191-17-139.us-west-2.compute.amazonaws.com/removeFood.php?id=ID"
            urlString = urlString.stringByReplacingOccurrencesOfString("ID", withString: ID)
            let urlPost = NSURL(string:urlString)
            let request = NSURLRequest(URL:urlPost!)
            var response: NSURLResponse? = nil
            var error: NSError? = nil
            let reply = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&error)
            
            reload()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        reload()
    }
}

