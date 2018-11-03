//
//  ClockViewController.swift
//  JustClockWithImage
//
//  Created by Jiyoung.Jiwon on 2018. 7. 25..
//  Copyright © 2018년 Jiyoung.Jiwon. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {

    var clockView = ClockView()
    var alp: CGFloat = 0.1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let clockView = ClockView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        view.addSubview(clockView)
        self.clockView = clockView
        
        view.backgroundColor = UIColor.black
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        clockView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            clockView.secondCircle.center = CGPoint(x: clockView.frame.width / 2 - clockView.CIRCLE_DIAMETER / 2, y: clockView.frame.height / 2)
            clockView.timeBG.center = CGPoint(x: clockView.secondCircle.center.x + clockView.CIRCLE_DIAMETER * 1.1, y: clockView.frame.height / 2 - clockView.timeBG.frame.height / 3)
            clockView.dateLabel.center.x = clockView.timeBG.center.x
            clockView.dateLabel.frame.origin.y = clockView.timeBG.frame.origin.y + clockView.timeBG.frame.height * 1.1
        case .portrait:
            clockView.secondCircle.center = CGPoint(x: clockView.frame.width / 2, y: clockView.frame.height / 2 - clockView.CIRCLE_DIAMETER / 3)
            clockView.timeBG.center = CGPoint(x: clockView.secondCircle.center.x, y: clockView.secondCircle.frame.origin.y + clockView.CIRCLE_DIAMETER * 1.3)
            clockView.dateLabel.center.x = clockView.secondCircle.center.x
            clockView.dateLabel.frame.origin.y = clockView.timeBG.frame.origin.y + clockView.timeBG.frame.height * 1.1
        default:
            print("default \(clockView.frame.width) \(view.frame.width)")
//            clockView.setupPortrait()

        }
    }



}

