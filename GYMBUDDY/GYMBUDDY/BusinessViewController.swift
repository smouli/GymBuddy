//
//  BussinessViewController.swift
//  GYMBUDDY
//
//  Created by Harsha Lingareddy on 10/26/17.
//  Copyright © 2017 Dhiman. All rights reserved.
//

import Foundation
//
//  BusinessesViewController.swift
//  Yelp
//.
//

import UIKit

class BusinessViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var businesses: [Business]!
    var output: [Business]!
    
   
    @IBOutlet weak var tableView1: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView1.delegate = self
        tableView1.dataSource = self
        tableView1.estimatedRowHeight = 120
        tableView1.rowHeight = UITableViewAutomaticDimension
        
        let searchBar = UISearchBar()
        searchBar.delegate = self as? UISearchBarDelegate
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        //tableView.reloadData()
        //searchBar.delegate = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshBusinesses(_:)), for: UIControlEvents.valueChanged)
        tableView1.insertSubview(refreshControl, at: 0)
        refreshBusinesses(refreshControl)
        //searchBar.delegate = self;
    }
    
    func refreshBusinesses(_ refreshControl: UIRefreshControl) {
        businesses.searchWithTerm(term: "Gym", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.output = businesses
            self.tableView1.reloadData()
            refreshControl.endRefreshing()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
        }
        )}
    
    
    
    
    /* Example of Yelp search with more search options specified
     Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
     self.businesses = businesses
     
     for business in businesses {
     print(business.name!)
     print(business.address!)
     }
     }
     */
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil {
            return businesses!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView1.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell;
    }
    
    
    // called when text changes (including clear)
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        Business.searchWithTerm(term: searchBar.text!, completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView1.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
        }
        )
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
