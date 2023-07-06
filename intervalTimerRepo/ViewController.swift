//
//  ViewController.swift
//  intervalTimerRepo
//
//  Created by willhcodes on 6/20/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerTextLabel: UILabel!
    @IBOutlet weak var timerButtonPressed: UIButton! {
        didSet {
            timerButtonPressed.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 31.0)
        }
        
    }
    
    let notificationCenter = NotificationCenter.default
    
    var timeLeft: Date?
    weak var timer: Timer?
    var number = 100
    
    @objc func timerSpecifications() {

        if number == 0 {
            timer?.invalidate()
            buttonTitle()
            return
        }
        number -= 1
        timerTextLabel.text = "\(number)"
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        timerButtonPressed.addTarget(self, action: #selector(timerButtonPressedSpecification), for: .touchUpInside)
        addingObserver()
    }
    
    
    @objc func timerButtonPressedSpecification () {
        if timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerSpecifications), userInfo: nil, repeats: true)
            buttonTitle()
        } else if timer != nil {
            buttonTitle()
        }
        
    }
    
    
}

extension ViewController {
    
    func buttonTitle() {
        
        DispatchQueue.main.async { [self] in
            switch timerButtonPressed.titleLabel?.text {
            case "Start":
                timerButtonPressed.setTitle("Stop", for: .normal)
                
            case "Stop":
                timer?.invalidate()
                timerButtonPressed.setTitle("Start", for: .normal)
            default:
                return
            }
        }

    }
}

