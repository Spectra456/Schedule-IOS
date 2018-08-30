//
//  ViewController.swift
//  Schedule
//
//  Created by Ali Aliyev on 24.08.2018.
//  Copyright © 2018 Ali Aliyev. All rights reserved.
//

import UIKit
import SwiftyJSON



class ViewController: UIViewController {

    
    @IBAction func Push(_ sender: UIButton) {
        
        showText()
        
    }
    @IBOutlet weak var display: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    func showText(){
        let sch: Schedule = Schedule(url: "http://ruz2.spbstu.ru/api/v1/ruz/scheduler/26741", date: "2018-9-3")
        sch.getLessonType(lesson: 1, day: 0, schedule: sch, completionHandler: { result in
            self.display.text = result
        })
        
    }
    
    

}

