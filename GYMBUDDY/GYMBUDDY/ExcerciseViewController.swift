//
//  ExcerciseViewController.swift
//  GYMBUDDY
//
//  Created by Manoj Polisetti on 10/25/17.
//  Copyright © 2017 Dhiman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class ExcerciseViewController: UIViewController {
    
    @IBOutlet var NameLabel: UILabel!
    
    @IBOutlet var MuscleLabel: UILabel!
    
    @IBOutlet var SetsLabel: UILabel!
    
    @IBOutlet var RepsLabel: UILabel!
    
    var excerciseDetails = [String]()
    
    var excerciseName: String = ""
    
    var workoutName: String = ""
    
    //    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference().child("Workouts/" + workoutName + "/" + excerciseName + "/")
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            let userDict = snapshot.value as? [String: Any]
            
            for (key, value) in userDict! {
                
                print("!!!!!!!!!!!!!!!!!!!!")
                print("\(key) -> \(value)")
                
                if (key == "name" || key == "name ") {
                    self.NameLabel.text = ("\(key) -> \(value)")
                }
                else if (key == "Muscle" || key == "Muscle ") {
                    self.MuscleLabel.text = ("\(key) -> \(value)")
                    
                }
                else if (key == "Sets" || key == "Sets ") {
                    self.SetsLabel.text = ("\(key) -> \(value)")
                    
                }
                else if (key == "Reps" || key == "Reps ") {
                    self.RepsLabel.text = ("\(key) -> \(value)")
                    
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
