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


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var list = [String]()
    var data = [String]()
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?

    @IBAction func submit(_ sender: Any) {
        dump(data)
    }
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
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
    
    @IBAction func logOutAction(sender: AnyObject) {
        
    }


}

