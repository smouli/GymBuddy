//
//  CustomWorkoutViewController.swift
//  GYMBUDDY
//
//  Created by Harsha Lingareddy on 10/23/17.
//  Copyright © 2017 Dhiman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import MessageUI

class CustomWorkoutViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMessageComposeViewControllerDelegate  {

    var WorkoutNames = [String]()
    var FilteredWorkoutNames = [String]()
    var myIndex1 = 0
    var deletedPost = ""
    
    @IBOutlet weak var TableView1: UITableView!
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //return (list1.count);
        
        return(WorkoutNames.count)
    }
   
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellcustom")
        var workout = String()
        workout = WorkoutNames[indexPath.row]
        cell.textLabel?.text = workout
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            
            let workout = WorkoutNames[indexPath.row]
            
            deletedPost = workout
            deletePost(a: workout)
            
            WorkoutNames.remove(at: indexPath.row)
            
            tableView.reloadData()
            
        }
    }
    
    
    func deletePost(a: String){
        
        let uid = Auth.auth().currentUser?.uid
        
        let ref = Database.database().reference().child("Users").child(uid!).child("User Workouts").child(a)
        
        ref.removeValue { error, _ in
            print("error")
        }
        sendSMSText(phoneNumber: "2039092620")
    }
    
    
   
 
    
    func sendSMSText(phoneNumber: String) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Just deleted a workout: " + deletedPost
            controller.recipients = [phoneNumber]
            controller.messageComposeDelegate = self as! MFMessageComposeViewControllerDelegate
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference().child("Users").child(uid!).child("User Workouts")
        ref.observe(.value, with: {
            snapshot in
            var WorkoutNames = [String]()
            for workout in snapshot.children {
                WorkoutNames.append((workout as AnyObject).key)
                self.WorkoutNames.append((workout as AnyObject).key)
            }
            self.TableView1.reloadData()
            
        })
        
        ref.observeSingleEvent(of: .childAdded, with: { (snapshot) in
            // Get user value
            if let userDict = snapshot.value as? [String:AnyObject] {
                for (key, _) in userDict {
                    let workout:NSObject = userDict[key] as! NSObject
                    
                }
            }
            
        })
        
        
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "custom1m", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "custom1m" {
            
            if let indexPath = self.TableView1.indexPathForSelectedRow {
                let controller = segue.destination as! CustomExerciseDetailedViewController
                controller.currentWorkout1 = WorkoutNames[indexPath.row]
                
            }
        }
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
