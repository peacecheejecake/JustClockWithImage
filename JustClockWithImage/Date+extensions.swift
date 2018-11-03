//
//  Date+HMS.swift
//  JustClockWithImage
//
//  Created by Jiyoung.Jiwon on 2018. 7. 25..
//  Copyright © 2018년 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

extension Date {
    var timeComponents: (Int, Int, Int) {
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: self)
        guard let hour = components.hour, let minute = components.minute, let second = components.second else {
            fatalError()
        }
        
        return (hour, minute, second)
    }
    
    var dateComponents: (Int, Int, Int, String) {
        let components = Calendar.current.dateComponents([.year, .month, .day, .weekday], from: self)
        
        guard let year = components.year, let month = components.month, let date = components.day, let day = components.weekday else {
            fatalError()
        }
        
        return (year, month, date, weekToString(day))
    }
    
    func weekToString(_ weekday: Int) -> String {
        switch weekday {
        case 1: return "일"
        case 2: return "월"
        case 3: return "화"
        case 4: return "수"
        case 5: return "목"
        case 6: return "금"
        case 7: return "토"
        default: return "?"
        }
    }
}
