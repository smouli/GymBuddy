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



class Home1ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var TableView: UITableView!

    var WorkoutNames = [String]()
    var FilteredWorkoutNames = [String]()
    var myIndex1 = 0
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //return (list1.count);
        if isFiltering() {
            return FilteredWorkoutNames.count
        }
        return(WorkoutNames.count)
    }
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        FilteredWorkoutNames = WorkoutNames.filter({( workout : String) -> Bool in
            return workout.contains(searchText.lowercased())
            
        })
        
        TableView.reloadData()
    }
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        var workout = String()
        if isFiltering() {
            workout = FilteredWorkoutNames[indexPath.row]
        } else {
            workout = WorkoutNames[indexPath.row]
        }
        cell.textLabel?.text = workout
        return (cell)

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex1 = indexPath.row
        performSegue(withIdentifier: "segueHome2nd", sender: self)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Workouts"
        navigationItem.titleView = searchController.searchBar
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        let ref = Database.database().reference().child("Workouts")
        ref.observe(.value, with: {
            snapshot in
            var WorkoutNames = [String]()
            for workout in snapshot.children {
                WorkoutNames.append((workout as AnyObject).key)
                self.WorkoutNames.append((workout as AnyObject).key)
            }
            self.TableView.reloadData()
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueHome2nd" {
            
            if let indexPath = self.TableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailedWorkoutTableViewController
                if isFiltering() {
                  controller.currentWorkout = FilteredWorkoutNames[indexPath.row]
                } else {
                    controller.currentWorkout = WorkoutNames[indexPath.row]
                }

            }
        }
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
extension Home1ViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
