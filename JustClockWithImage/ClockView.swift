//
//  ClockView.swift
//  JustClockWithImage
//
//  Created by Jiyoung.Jiwon on 2018. 7. 25..
//  Copyright © 2018년 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class ClockView: UIView {
    var backgroundView: UIView!
    var yearLabel: UILabel!
    var dateLabel: UILabel!
    var timeLabel: UILabel!
    var timeBG: UIView!
    var timeLabelBlank: UILabel!
    var secondCircle: UIView!
    var secondHand: UIView!
    var secondHandBG: UIView!
    
    let CIRCLE_DIAMETER: CGFloat = 280

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        secondCircle = UIView()
        secondCircle.frame.size = CGSize(width: CIRCLE_DIAMETER, height: CIRCLE_DIAMETER)
        secondCircle.center = CGPoint(x: frame.width / 2, y: frame.height / 2 - CIRCLE_DIAMETER / 3)
        secondCircle.backgroundColor = UIColor.clear
        secondCircle.layer.cornerRadius = CIRCLE_DIAMETER / 2
        secondCircle.layer.borderColor = UIColor.white.cgColor
        secondCircle.layer.borderWidth = 2
        addSubview(secondCircle)
        
        secondHandBG = UIView()
        secondHandBG.frame = CGRect(x: CIRCLE_DIAMETER / 2 - 7.5, y: 2, width: 15, height: CIRCLE_DIAMETER - 4)
        secondHandBG.backgroundColor = UIColor.clear
        secondCircle.addSubview(secondHandBG)
        
        secondHand = UIView()
        secondHand.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        secondHand.layer.cornerRadius = 7.5
        secondHand.backgroundColor = UIColor.red
        secondHandBG.addSubview(secondHand)
        
        bringSubview(toFront: secondHandBG)
        

        timeLabel = UILabel()
//        timeLabel.backgroundColor = UIColor.magenta
        let timeAttributes: [NSAttributedStringKey: Any] = [.kern: 15, .foregroundColor: UIColor.clear, .font: UIFont.monospacedDigitSystemFont(ofSize: 65, weight: .light)]
        let defaultString = NSAttributedString(string: "10 01", attributes: timeAttributes)
        timeLabel.attributedText = defaultString
        timeLabel.sizeToFit()
        
        timeLabelBlank = UILabel()
//        timeLabelBlank.backgroundColor = UIColor.cyan

        timeBG = UIView()
//        timeBG.backgroundColor = UIColor.blue
        timeBG.frame.size = CGSize(width: timeLabel.frame.width + 15, height: timeLabel.frame.height)
        addSubview(timeBG)
        
        timeBG.addSubview(timeLabelBlank)
        timeBG.addSubview(timeLabel)
        
        timeLabelBlank.frame = CGRect(x: 0, y: 0, width: 15, height: timeLabel.frame.height)
        timeLabel.frame.origin = CGPoint(x: 15, y: 0)
        timeBG.center = CGPoint(x: secondCircle.center.x, y: secondCircle.frame.origin.y + CIRCLE_DIAMETER * 1.3)
        
        
        dateLabel = UILabel()
        dateLabel.textColor = UIColor.clear
        dateLabel.text = "07월 25일 목요일"
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 30, weight: .ultraLight)
        dateLabel.sizeToFit()
        dateLabel.center.x = secondCircle.center.x
        dateLabel.frame.origin.y = timeBG.frame.origin.y + timeBG.frame.height * 1.1
        addSubview(dateLabel)
        
//        dateLabel.backgroundColor = UIColor.lightGray
        
        yearLabel = UILabel()
        yearLabel.textColor = UIColor.clear
        yearLabel.text = "0000"
        yearLabel.textAlignment = .center
        yearLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 33, weight: .light)
        yearLabel.sizeToFit()
        yearLabel.center = CGPoint(x: CIRCLE_DIAMETER / 2, y: CIRCLE_DIAMETER / 2)
        secondCircle.addSubview(yearLabel)
        
        
        _ = Timer.scheduledTimer(withTimeInterval: TimeInterval(1.0), repeats: true, block: { (_) in
            DispatchQueue.main.async {
                self.updateTime()
            }
        })
    }
    
//    func setupPortrait() {
//        secondCircle.center = CGPoint(x: frame.width / 2, y: frame.height / 2 - CIRCLE_DIAMETER / 3)
//        timeBG.center = CGPoint(x: secondCircle.center.x, y: secondCircle.frame.origin.y + CIRCLE_DIAMETER * 1.3)
//        dateLabel.center.x = secondCircle.center.x
//    }
//
//    func setupLandscape() {
//        secondCircle.center = CGPoint(x: frame.width / 4, y: frame.height / 2)
//        timeBG.center = CGPoint(x: frame.width / 4 * 3, y: secondCircle.frame.origin.y + CIRCLE_DIAMETER * 0.3)
//        dateLabel.center.x = timeBG.center.x
//    }
//
    
    func updateTime() {
        let (hour, min, second) = Date().timeComponents
        let (year, month, date, day) = Date().dateComponents
        
        let timeForm = { String(format: "%02d", $0) }
        
        yearLabel.textColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
        yearLabel.text = "\(year)"
        
        dateLabel.text = "\(timeForm(month))월 \(timeForm(date))일 \(day)요일"
        dateLabel.textColor = UIColor.white
        dateLabel.sizeToFit()
        
        let timeAttributes: [NSAttributedStringKey: Any] = [.kern: 15, .foregroundColor: UIColor.white, .font: UIFont.monospacedDigitSystemFont(ofSize: 65, weight: .light)]
        let timeString = NSAttributedString(string: "\(timeForm(hour)) \(timeForm(min))", attributes: timeAttributes)
        timeLabel.attributedText = timeString
        timeLabel.sizeToFit()
        
//        timeBG.center.x = secondCircle.center.x

        
        UIView.animate(withDuration: TimeInterval(2.3)) {
            self.secondHandBG.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi) / 30 * CGFloat(second))
        }
    }
}
