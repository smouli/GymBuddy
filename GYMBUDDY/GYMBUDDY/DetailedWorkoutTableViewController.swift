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
    var ExpandedList = [String]()
    var currentWorkout: String = ""

    
    
    
    @IBOutlet var Hi: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentWorkout)
        let ref = Database.database().reference().child("Workouts/" + currentWorkout)
        
        ref.observe(.value, with: {
            
            snapshot in
            
            for workout in snapshot.children {
                
                self.WorkoutNames.append((workout as AnyObject).key)
                
            }
            
            self.Hi.reloadData()
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return(WorkoutNames.count)

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "2ndcell", for: indexPath)
        cell.textLabel?.text = WorkoutNames[indexPath.item]
        return cell
    }
    
             

  
}
