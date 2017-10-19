//
//  DetailedWorkoutTableViewController.swift
//  GYMBUDDY
//
//  Created by Harsha Lingareddy on 10/18/17.
//  Copyright © 2017 Dhiman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


var pets = ["dog","cat","frog"]
var myIndex = 0


class DetailedWorkoutTableViewController: UITableViewController {
    
    var WorkoutNames = [String]()
    
    
    
    @IBOutlet var Hi: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = Database.database().reference().child("Workouts")
        
        
        ref.observe(.value, with: {
            
            snapshot in
            
            for workout in snapshot.children {
                
                self.WorkoutNames.append((workout as AnyObject).key)
                
                self.WorkoutNames.append((workout as AnyObject).key)
                
            }
            
            //self.TableView.backgroundColor = UIColor.green
            
            self.Hi.reloadData()
            
        })
        
        ref.observeSingleEvent(of: .childAdded, with: { (snapshot) in
            
            // Get user value
            
            if let userDict = snapshot.value as? [String:AnyObject] {
                
                print(userDict)
                
                //Do not cast print it directly may be score is Int not string
                
                for (key, _) in userDict {
                    
                    print(key)
                    
                    let workout:NSObject = userDict[key] as! NSObject
                    
                    
                    
                    let firstName:String! = workout.value(forKey: "name") as? String
                    
                    print(firstName)
                    
                }
                
                
                
            }

        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return pets.count
        return(WorkoutNames.count)

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "2ndcell", for: indexPath)
        cell.textLabel?.text = WorkoutNames[indexPath.row]
        
        return cell
    }
    
             

  
}
