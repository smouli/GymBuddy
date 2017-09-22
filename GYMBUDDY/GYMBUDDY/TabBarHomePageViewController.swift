//
//  TabBarHomePageViewController.swift
//  GYMBUDDY
//
//  Created by Harsha Lingareddy on 9/21/17.
//  Copyright © 2017 Dhiman. All rights reserved.
//

import UIKit

class TabBarHomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let list = ["Preset Workout 1", "Preset Workout 2", "Preset Workout 3", "Preset Workout 4", "Preset Workout 5"]
    var myIndex = 0
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return(list.count)
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "segue1", sender: self)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        

        // Do any additional setup after loading the view.
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
