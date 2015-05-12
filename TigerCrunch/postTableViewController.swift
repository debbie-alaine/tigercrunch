//
//  postTableViewController.swift
//  TigerCrunch
//
//  Created by Peter Yao on 4/30/15.
//  Copyright (c) 2015 Deborah Sandoval. All rights reserved.
//

import UIKit

class postTableViewController: UITableViewController, UITextFieldDelegate, UISearchBarDelegate {

    var data: NSArray = []
    var searchText: String? = "http://ec2-54-191-17-139.us-west-2.compute.amazonaws.com/getFood.php" {
        didSet {
            data = []
            tableView.reloadData()
            reload()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if searchText != nil {
            data = dataOfJson(searchText!)
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Helvetica", size: 24)!]
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 255/255, green: 153/255, blue: 0/255, alpha: 1.0)

    }
    
    // hide search bar when scrolling
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self.tableView {
            postSearchBar.resignFirstResponder()
            if postSearchBar.text.isEmpty {
                postSearchBar.setShowsCancelButton(false, animated: true)
            }
        }
    }
    
    func reload() {
        if searchText != nil {
            data = dataOfJson(searchText!)
        }
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
        self.postSearchBar.endEditing(true)
        super.touchesBegan(touches , withEvent:event)
    }
    
    func dataOfJson(url: String) -> NSArray {
        let URLContents = NSURL(string: url)
        if let realURLContents = URLContents {
            let data = NSData(contentsOfURL: realURLContents)
            if let realData = data {
                let json: AnyObject? = NSJSONSerialization.JSONObjectWithData(realData, options: nil, error: nil)
                if let realJson: AnyObject = json {
                    return realJson as! NSArray
                }
            }
        }
        return []
    }
    
    @IBOutlet weak var postSearchBar: UISearchBar! {
        didSet {
            postSearchBar.delegate = self
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if searchBar == postSearchBar {
            searchBar.resignFirstResponder()
            searchText = "http://ec2-54-191-17-139.us-west-2.compute.amazonaws.com/filter.php?search=" + searchBar.text
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        if searchBar == postSearchBar {
            searchBar.text = ""
            searchBar.resignFirstResponder()
            searchBar.setShowsCancelButton(false, animated: true)
            searchText = "http://ec2-54-191-17-139.us-west-2.compute.amazonaws.com/getFood.php"
            reload()
        }
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        if searchBar == postSearchBar {
            searchBar.setShowsCancelButton(true, animated: true)
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == searchTextField {
            textField.resignFirstResponder()
            searchText = "http://ec2-54-191-17-139.us-west-2.compute.amazonaws.com/filter.php?search=" + textField.text
        }
        return true
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
        var claim = maindata["claim"] as! String
        var elapsed = maindata["elapsed_time"] as? String
        var elapsedTime: String = "-"
        if let elapsedFormatted = elapsed {
            var elapsedSplit = split(elapsedFormatted) {$0 == ":"}
            elapsedTime = "Posted " + elapsedSplit[0] + "h " + elapsedSplit[1] + "m ago" 
        }

        var expiration = maindata["expiration"] as! String
        
        claim = claim + " left"
        
        cell.setCell(food, descriptionLabelText: description, buildingLabelText: building, locationLabelText: location, IDText: id, claimLabelText: claim, elapsedTimeLabelText: elapsedTime, expirationLabelText: expiration)
        
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


    struct segueIdentifier {
        let postDetailView = "PostDetailSegue"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let segueID = segueIdentifier()
        if segue.identifier == segueID.postDetailView {
            if let destination = segue.destinationViewController as? postDetailViewController {
                if let postIndex = tableView.indexPathForSelectedRow()?.row {
                    var postDetails = data[postIndex] as! NSDictionary
                    destination.food = postDetails["food"] as! String
                    destination.descriptionFood = postDetails["description"] as! String
                    destination.building = postDetails["building"] as! String
                    destination.room = postDetails["room_info"] as! String
                    var elapsed = postDetails["elapsed_time"] as? String
                    var elapsedTime: String = "-"
                    if let realElapsed = elapsed {
                        elapsedTime = realElapsed
                    }
                    destination.elapsedTime = elapsedTime
                    destination.time = postDetails["time_to_expire"] as! String
                    println(destination.time)
                    destination.claim = postDetails["claim"] as! String
                    destination.ID = postDetails["id"] as! String
                }
            }
        }
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
