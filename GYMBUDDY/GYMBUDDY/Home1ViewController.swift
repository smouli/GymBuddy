//
//  Home1ViewController.swift
//  GYMBUDDY
//
//  Created by Harsha Lingareddy on 10/12/17.
//  Copyright © 2017 Dhiman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class Home1ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var TableView: UITableView!
    
    let list1 = ["milk", "honey", "bread"];
    var WorkoutNames = [String]()
    var myIndex1 = 0
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //return (list1.count);
        return(WorkoutNames.count)
    }
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        let cell =  UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
//        cell.textLabel?.text = list1[indexPath.row]
//        
//        return cell;
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = WorkoutNames[indexPath.row]
        
        
        //cell.backgroundColor = UIColor.lightGray
        return (cell)

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex1 = indexPath.row
        performSegue(withIdentifier: "segueHome2nd", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference().child("Workouts")
        ref.observe(.value, with: {
            snapshot in
            var WorkoutNames = [String]()
            for workout in snapshot.children {
                WorkoutNames.append((workout as AnyObject).key)
                self.WorkoutNames.append((workout as AnyObject).key)
            }
            //self.TableView.backgroundColor = UIColor.green
            self.TableView.reloadData()
            
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
        
                            //print(firstName)
        
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
