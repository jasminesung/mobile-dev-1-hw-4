//
//  ViewController.swift
//  Clock
//
//  Created by Jasmine Sung on 3/2/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countdownTimer: UIDatePicker!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    var timeLeft: Int = 0
    var timer = Timer()
    var currentTimer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTimeLabel.text = ""
        timeRemainingLabel.text = ""
        countdownTimer.datePickerMode = .countDownTimer
        currentTimer.invalidate()
        currentTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(getCurrentTimeAndUpdateBackground), userInfo: nil, repeats: true)
    }
    @IBAction func onStartTimer(_ sender: Any) {
                timer.invalidate()
                timeLeft = Int(countdownTimer.countDownDuration)
        if timeLeft > 0 {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startCountDown), userInfo: nil, repeats: true)
        }
    }

    func timeString(hours: Int, minutes: Int, seconds: Int) -> String {
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    @objc func getCurrentTimeAndUpdateBackground() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM YYYY HH:mm:ss"
        let currentDateTime = dateFormatter.string(from: date)
        self.dateTimeLabel.text = currentDateTime
         self.updateBackground()
    }
    
    @objc func startCountDown() {
        if timeLeft >= 0 {
            let (countdownHour, countdownMinute, countdownSecond)  = self.secondsToHoursMinutesSeconds(timeLeft)
            timeRemainingLabel.text = "Time Remaining: " + self.timeString(hours: countdownHour, minutes: countdownMinute, seconds: countdownSecond)
            timeLeft -= 1
            
        } else {
            timer.invalidate()
        }
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func updateBackground()
        {
            let hour = Calendar.current.component(.hour, from: Date())

            switch hour {
            case 0..<12 :
                backgroundImage.image = UIImage(named: "daylight")
            default:
                backgroundImage.image = UIImage(named: "night")
            }
        }


}

