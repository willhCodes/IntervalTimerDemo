//
//  Notification.swift
//  intervalTimerRepo
//
//  Created by willhcodes on 6/20/23.
//

import UIKit


extension ViewController {
    
    func addingObserver() {
        
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeGround), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        //        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        
    }
    @objc func appMovedToForeGround() {
        if let timeLeft = timeLeft {
            number = number - timeSince(whenPaused: timeLeft)
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerSpecifications), userInfo: nil, repeats: true)
            
        }
        
    }
    @objc func appMovedToBackground() {
        // assigning the current time upon moving out of the app
        timeLeft = Date()
        timer?.invalidate()
        
        
    }
    func timeSince(whenPaused input: Date) -> Int {
        let currentDate = Date()
        let timeInterval = currentDate.timeIntervalSince(input)
        let accumulatedTime = Int(round(timeInterval))
        return accumulatedTime
    }
    
    
    
}
