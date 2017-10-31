//
//  ViewController.swift
//  GYMBUDDY
//
//  Created by Dhiman on 9/19/17.
//  Copyright © 2017 Dhiman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class UserWorkoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var list = [String]()
    var data = [String]()
    var sets = 0
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var string = ""
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBAction func submit(_ sender: Any) {
        self.post()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBOutlet weak var counter_label: UILabel!
    
    @IBAction func plus_button(_ sender: Any) {
        sets = sets + 1
        string = String(sets)
        counter_label.text? = string
    }
    
    @IBAction func minus_button(_ sender: Any) {
        if (sets > 0){
            sets = sets - 1
        }
        string = String(sets)
        counter_label.text? = string
    }
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
    }
    
    func post(){
        let uid = Auth.auth().currentUser?.uid
        let exer1 : [String : [String]] = [nameField.text! : data]
        let exer2 : [String : String] = ["Reps" : "Reps: " + string, "Sets: " : "Sets: " + string]
        let databaseRef = Database.database().reference()
        databaseRef.child("Users").child(uid!).child("User Workouts").updateChildValues(exer1)
        databaseRef.child("Users").child(uid!).child("User Workouts").child(nameField.text!).updateChildValues(exer2)
        
        dump(data)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell_1")
        cell.textLabel?.text = list[indexPath.row]
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            if (data.contains(list[indexPath.row])){
                data.remove(at: data.index(of: list[indexPath.row])!)
            }
            
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
            if (!data.contains(list[indexPath.row])){
                var i = 0
                data.insert(list[indexPath.row], at: i)
                i = i + 1
            }
        }
        dump(data)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()
        databaseHandle = ref?.child("Exercises").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? String
            if let actualPost = post{
                self.list.append(actualPost)
                self.tableView.reloadData()
            }

        })
        dump(list)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutAction(_ sender: AnyObject) {
        
    }


}

