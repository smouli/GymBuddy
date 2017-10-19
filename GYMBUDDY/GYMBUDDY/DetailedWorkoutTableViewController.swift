//
//  DetailedWorkoutTableViewController.swift
//  GYMBUDDY
//
//  Created by Harsha Lingareddy on 10/18/17.
//  Copyright © 2017 Dhiman. All rights reserved.
//

import UIKit

var pets = ["dog","cat","frog"]
var myIndex = 0

class DetailedWorkoutTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return pets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "2ndcell", for: indexPath)
        cell.textLabel?.text = pets[indexPath.row]
        
        return cell
    }
    
             

  
}
