//
//  SummerHoursViewController.swift
//  GYMBUDDY
//
//  Created by Harsha Lingareddy on 10/25/17.
//  Copyright © 2017 Dhiman. All rights reserved.
//

import UIKit

class SummerHoursViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var lavel: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    let corec = ["Select a Option","CoRec","Comp & Dive Pools","Rec Pool","Bouldering Wall","Climbing Wall","Admin Suite","Wellness & Physical Therapy","Fuel","TREC"]
    
    let timingt1 = ["N/A","Mon–Fri 5:30a-9p","Mon–Fri  6a-9a,11a-2p, 5-10p","Mon–Fri 2-10p","Mon–Fri 5:30-9p","Mon–Thur 5-9p","Mon–Fri 8a–5p","Mon–Fri 8a-5p","Mon–Fri 8a-5p","Mon, Wed, Fri 4-9p  Tue, Thur 11a–2p, 4-9p"]
    
    let timingt2 = ["N/A","Sat & Sun 10a-6p","Sat & Sun 11a-4p","Sat & Sun 2–10p","Sat & Sun 10a-6p","Sat & Sun 12:30-6p","Sat & Sun Closed","Sat & Sun Closed","Sat & Sun Closed","Sat & Sun Closed"]
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1;
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return corec[row]
    }
    
    open func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return corec.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lavel.text = timingt1[row]
        label2.text = timingt2[row]
        
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

