//
//  postTableViewController.swift
//  TigerCrunch
//
//  Created by Peter Yao on 4/30/15.
//  Copyright (c) 2015 Deborah Sandoval. All rights reserved.
//

import UIKit

class postTableViewController: UITableViewController {

    var data: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = dataOfJson("http://ec2-54-191-17-139.us-west-2.compute.amazonaws.com/getFood.php")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @IBAction func reload() {
        data = dataOfJson("http://ec2-54-191-17-139.us-west-2.compute.amazonaws.com/getFood.php")
        self.tableView.reloadData()
    }
    
    @IBAction func refresh(sender: UIRefreshControl) {
        if refreshControl != nil {
            refreshControl?.beginRefreshing()
        }
        reload()
        
        refreshControl?.endRefreshing()
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
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.data.count;
    }
    
    // creates a cell for each element in the database
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("post") as! CustomCell
        
        var maindata = (data[indexPath.row] as! NSDictionary)
        var food = maindata["food"] as! String
        var description = maindata["description"] as! String
        var building = maindata["building"] as! String
        var location = maindata["room_info"] as! String
        var id = maindata["id"] as! String
        
        cell.setCell(food, descriptionLabelText: description, buildingLabelText: building, locationLabelText: location, IDText: id)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // delete cell from database when you slide and click the delete button
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
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


    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
