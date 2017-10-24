//
//  CustomExerciseDetailedViewController.swift
//  GYMBUDDY
//
//  Created by Sanat Mouli on 10/24/17.
//  Copyright © 2017 Dhiman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class CustomExerciseDetailedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableview97: UITableView!
    var WorkoutNames = [String]()
    var FilteredWorkoutNames = [String]()
    var myIndex1 = 0
    var currentWorkout1: String = ""

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //return (list1.count);
        
        return(WorkoutNames.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellcustom")
        var workout = String()
        workout = WorkoutNames[indexPath.row]
        cell.textLabel?.text = workout
        return (cell)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference().child("Users").child(uid!).child("User Workouts").child(currentWorkout1)
        ref.observe(.value, with: {
            snapshot in
            var WorkoutNames = [String]()
            for workout in snapshot.children {
                WorkoutNames.append((workout as AnyObject).value)
                self.WorkoutNames.append((workout as AnyObject).value)
            }
            self.tableview97.reloadData()
            dump(WorkoutNames)
        })
        
        ref.observeSingleEvent(of: .childAdded, with: { (snapshot) in
            // Get user value
            if let userDict = snapshot.value as? [String:AnyObject] {
                for (key, _) in userDict {
                    let workout:NSObject = userDict[key] as! NSObject
                    let firstName:String! = workout.value(forKey: "name") as? String
                    print(firstName)
                    
                }
            }
            
        })
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
