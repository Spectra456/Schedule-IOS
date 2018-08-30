//
//  schedule.swift
//  Schedule
//
//  Created by Ali Aliyev on 24.08.2018.
//  Copyright © 2018 Ali Aliyev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON


class Schedule{
    var _url: String
    var _weekLength: Int = 0
    var _date: String
    // DON'T FORGET ABOUT DATE
    
    init(url: String, date: String) {
        self._url = url
        self._date = date
        
    }
    
    // Returning a json of week in async thread(completionHandler)
    
    func getWeekSchedule(completionHandler: @escaping ((JSON) -> ())) {
        let parameters: Parameters = [
            "date":"\(self._date)"
        ]
        Alamofire.request(self._url,method: .get, parameters: parameters).responseSwiftyJSON{ response in
            guard response.result.isSuccess else {
                print("Get request Error \(String(describing: response.result.error))")
                return
            }
            completionHandler(response.value!)

          }
    
        }
    
    // Returning a json of day in async thread(completionHandler)
    
    func getDaySchedule(schedule: Schedule, day: Int, completionHandler: @escaping ((JSON) -> ())){
        schedule.getWeekSchedule(completionHandler: { result in
            if (result["text"].string?.range(of: "Группа") == nil) {
                completionHandler(result["days"][day])
                
            } else {
                completionHandler(result)
            }
        
    })
    

    }
    
    // Returning a time of lesson(String) in async thread(completionHandler)
    
    func getTime(lesson:Int, day:Int,schedule: Schedule,completionHandler: @escaping((String) ->())){
        schedule.getDaySchedule(schedule: schedule, day: day, completionHandler:{ result in
            if(result["lessons"][0]["time_start"] != JSON.null){
            completionHandler("\(result["lessons"][0]["time_start"].string!) - \(result["lessons"][0]["time_end"].string!)")
            } else {
                print("Error. Problems with lesson time data: \(result)")
            }
            
        })
    }
    
    // Returning a lesson type(String) in async thread(completionHandler)
    
    func getLessonType(lesson:Int, day:Int,schedule: Schedule,completionHandler: @escaping((String) ->())){
        schedule.getDaySchedule(schedule: schedule, day: day, completionHandler:{ result in
            if(result["lessons"][0]["typeObj"]["name"] != JSON.null){
                completionHandler("\(result["lessons"][0]["typeObj"]["name"].string!)")
                
            } else {
                print("Error. Problems with lesson type data: \(result)")
            }
            
        })
    }
    
    func getLessonType(lesson:Int, day:Int,schedule: Schedule,completionHandler: @escaping((String) ->())){
        schedule.getDaySchedule(schedule: schedule, day: day, completionHandler:{ result in
            if(result["lessons"][0]["typeObj"]["name"] != JSON.null){
                completionHandler("\(result["lessons"][0]["typeObj"]["name"].string!)")
                
            } else {
                print("Error. Problems with lesson type data: \(result)")
            }
            
        })
    }
}
    

