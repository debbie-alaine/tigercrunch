//
//  SecondViewController.swift
//  TigerCrunch
//
//  Created by Deborah Sandoval on 4/22/15.
//  Copyright (c) 2015 Deborah Sandoval. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Labels
    @IBOutlet weak var foodLabel: UILabel!
    @IBOutlet weak var roomLabel: UILabel!
    
    // Text Fields
    @IBOutlet weak var FoodText: UITextField!
    @IBOutlet weak var RoomText: UITextField!
    @IBOutlet weak var DescriptionText: UITextField!

    @IBOutlet weak var buildingPicker: UIPickerView!
    @IBOutlet weak var expirationPicker: UIPickerView!
    @IBOutlet weak var portionPicker: UIPickerView!
    
    var building: String = "106 Alexander St."
    var expirationTimeMinutes: String = "60"
    var numberOfPortions: String = "1"
    
    
    let buildingPickerData = [
        "106 Alexander St.",
        "116 Prospect Ave.",
        "130 University Place",
        "171 Broadmead St.",
        "185 Nassau St.",
        "185 Nassau St.",
        "1879 Hall",
        "2 Dickinson St.",
        "20 Washington Road",
        "200 Elm Drive",
        "201 Nassau St.",
        "36 University Place",
        "48 University Place",
        "5 Ivy Lane",
        "58 Prospect Ave. Renovation and Addition",
        "71 University Place",
        "86 Olden St.",
        "87 Prospect Ave.",
        "91 Prospect Ave.",
        "Alexander Hall",
        "Architecture Building",
        "Architecture Laboratory",
        "Art Museum",
        "Baker Hall",
        "Baker Rink",
        "Bendheim Center for Finance",
        "Bendheim Hall",
        "Berlind Theatre",
        "Blair Hall",
        "Bloomberg Hall",
        "Bobst Hall",
        "Bogle Hall",
        "Bowen Hall",
        "Brown Hall",
        "Burr Hall",
        "Buyers Hall",
        "Caldwell Field House",
        "Campbell Hall",
        "Campus Club Renovation",
        "Campus Club",
        "Cannon Club Renovation",
        "Cannon Club",
        "Center for Jewish Life",
        "Chancellor Green",
        "Chilled Water Plant",
        "Class of 1886 Clubhouse",
        "Class of 1887 Boathouse",
        "Class of 1901 Hall",
        "Class of 1903 Hall",
        "Class of 1912 Pavilion",
        "Class of 1915 Hall",
        "Class of 1927-Clapp Hall",
        "Class of 1937 Hall",
        "Class of 1938 Hall",
        "Class of 1939 Hall",
        "Class of 1952 Stadium",
        "Class of 1967 Hall",
        "Class of 1976 Hall",
        "Class of 1981 Hall",
        "Clio Hall",
        "Cogeneration Plant",
        "Community Hall",
        "Computer Science Building",
        "Cooling Towers",
        "Cordish Family Pavilion",
        "Corwin Hall",
        "Cuyler Hall",
        "DeNunzio Pool",
        "Dickinson Hall",
        "Dillon Court (East and West)",
        "Dillon Gymnasium",
        "Dod Hall",
        "Dodge Hall",
        "Dodge-Osborn Hall",
        "East Pyne Hall",
        "Edwards Hall",
        "Elementary Particles Laboratory",
        "Energy Research Laboratory",
        "Engineering Quadrangle A-F Wings",
        "Eno Hall",
        "EQuad J Wing",
        "Feinberg Hall",
        "Fine Hall",
        "Firestone Library",
        "Fisher Hall (Prospect Avenue)",
        "Fisher Hall (Whitman College)",
        "FitzRandolph Gate",
        "FitzRandolph Observatory",
        "Forbes College Annex",
        "Forbes College",
        "Foulke Hall",
        "Frick Chemistry Laboratory",
        "Friend Center",
        "Frist Campus Center",
        "Gauss Hall",
        "Graduate College-North Court",
        "Graduate College",
        "Green Hall",
        "Guyot Hall",
        "Hamilton Hall",
        "Hargadon Hall",
        "Henry Hall",
        "Henry House",
        "High-performance Computing Research Center",
        "Holder Hall",
        "Hoyt Laboratory",
        "Icahn Laboratory",
        "Jadwin Gymnasium",
        "Jadwin Hall",
        "Joline Hall",
        "Jones Hall",
        "Laughlin Hall",
        "Lauritzen Hall",
        "Lenz Tennis Center",
        "Lewis Library",
        "Little Hall",
        "Lockhart Hall",
        "Lowrie House",
        "Maclean House",
        "MacMillan Building",
        "Madison Hall",
        "Marx Hall",
        "McCarter Theatre",
        "McCormick Hall",
        "McCosh Hall",
        "McCosh Health Center",
        "McDonnell Hall",
        "Moffett Laboratory",
        "Mudd Manuscript Library",
        "Murley-Pivirotto Family Tower",
        "Murray Theater",
        "Nassau Hall",
        "New Graduate College",
        "New South Building Renovation",
        "New South Building",
        "Nassau Hall",
        "North Garage",
        "Olden House",
        "Palmer House",
        "Palmer Stadium",
        "Patton Hall",
        "Peretsman Scully Hall",
        "Peyton Hall",
        "Princeton Neuroscience Institute",
        "Princeton Stadium",
        "Princeton Station",
        "Prospect House",
        "Pyne Hall",
        "Roberts Stadium",
        "Robertson Hall",
        "Scheide Caldwell House",
        "Schultz Laboratory",
        "Scully Hall",
        "Shea Rowing Center",
        "Sherrerd Hall",
        "Spelman Halls",
        "Stanhope Hall",
        "Streicker Bridge",
        "Tennis Pavilion",
        "Thomas Laboratory",
        "University Chapel",
        "Von Neumann Hall",
        "Walker Hall",
        "Wallace Hall",
        "Wendell Hall",
        "West College",
        "West Garage",
        "Whig Hall",
        "Wilcox Hall",
        "Wilf Hall",
        "Witherspoon Hall",
        "Woolworth Music Center",
        "Wright Hall",
        "Wu Hall",
        "Wyman House",
        "Yoseloff Hall"
        ]
    
    let expirationPickerData = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20",
        "21",
        "22",
        "23",
        "24"
    ]
    
    let portionPickerData = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20"
    ]
    
    // loading the view
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buildingPicker.delegate = self
        buildingPicker.dataSource = self
        expirationPicker.delegate = self
        expirationPicker.dataSource = self
        portionPicker.delegate = self
        portionPicker.dataSource = self
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
        var urlString = "http://ec2-54-191-17-139.us-west-2.compute.amazonaws.com/addFood.php?building=BUILDING&room_info=ROOMINFO&food=PUTFOOD&description=DESCRIBE&claim=PORTION&expiration=NUM_IN_MINUTES"
    
        // replace attributes with strings in textbox
        if FoodText.text != "" && RoomText.text != "" {
            
            urlString = urlString.stringByReplacingOccurrencesOfString("PUTFOOD", withString: FoodText.text)
            urlString = urlString.stringByReplacingOccurrencesOfString("DESCRIBE", withString: DescriptionText.text)
            urlString = urlString.stringByReplacingOccurrencesOfString("ROOMINFO", withString: RoomText.text)
            urlString = urlString.stringByReplacingOccurrencesOfString("BUILDING", withString: building)
            urlString = urlString.stringByReplacingOccurrencesOfString("PORTION", withString: numberOfPortions)
            urlString = urlString.stringByReplacingOccurrencesOfString("NUM_IN_MIN", withString: expirationTimeMinutes)
            
            // run php script
            let urlPost = NSURL(string:urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
            let request = NSURLRequest(URL:urlPost!)
            var response: NSURLResponse? = nil
            var error: NSError? = nil
            let reply = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&error)
                
            performSegueWithIdentifier("submit", sender: self)
            
        }
            
        else {
            foodLabel.textColor = UIColor.blackColor()
            roomLabel.textColor = UIColor.blackColor()
            
            if FoodText.text == "" {
                foodLabel.textColor = UIColor.redColor()
            }
            
            if RoomText.text == "" {
                roomLabel.textColor = UIColor.redColor()
            }
        }
    }
    
    //MARK: - Delegates and data sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case buildingPicker:
            return buildingPickerData.count
        case expirationPicker:
            return expirationPickerData.count
        case portionPicker:
            return portionPickerData.count
        default:
            return 0
        }
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        switch pickerView {
        case buildingPicker:
            return buildingPickerData[row]
        case expirationPicker:
            return expirationPickerData[row]
        case portionPicker:
            return portionPickerData[row]
        default:
            return ""
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case buildingPicker:
            building = buildingPickerData[row]
        case expirationPicker:
            expirationTimeMinutes = expirationPickerData[row]
            var hr2Minutes: Int! = expirationTimeMinutes.toInt()
            hr2Minutes = hr2Minutes * 60
            expirationTimeMinutes = "\(hr2Minutes)"
        case portionPicker:
            numberOfPortions = portionPickerData[row]
        default:
            return
        }
    }
    
}
