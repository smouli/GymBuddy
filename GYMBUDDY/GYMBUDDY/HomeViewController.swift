//
//  HomeViewController.swift
//  GYMBUDDY
//
//  Created by Harsha Lingareddy on 9/30/17.
//  Copyright © 2017 Dhiman. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import UserNotifications

class HomeViewController: UIViewController {

    @IBAction func SendNotif(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Daily Workout Reminder"
        content.subtitle = "Gym Buddy"
        content.body = "Its time to workout"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
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
//    @IBAction func logout() {
//        try! Auth.auth().signOut()
//        if let storyboard = self.storyboard {
//            let vc = storyboard.instantiateViewController(withIdentifier: "Login") as! UINavigationController
//            self.present(vc, animated: false, completion: nil)
//        }
//    }
    
}
