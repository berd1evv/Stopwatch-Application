//
//  ViewController.swift
//  StopWatch-Application
//
//  Created by Eldiiar on 26/1/22.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    var sec = 0
    var min = 0
    var hour = 0
    
    var sec1 = 0
    var min1 = 0
    var hour1 = 0
    
    var picker = 0
    var timer = Timer()
    var arr: [String] = []
    
    func lazy() {
        for i in 0...59 {
            arr.append(String(i))
        }
    }
    
    
    @IBOutlet weak var startButton: UIImageView!
    @IBOutlet weak var pauseButton: UIImageView!
    @IBOutlet weak var resetButton: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lazy()
        label.text = "00:00:00"
        pickerView.isHidden = true
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
// MARK: PickerView
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arr[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let val1 = arr[pickerView.selectedRow(inComponent: 0)]
        let val2 = arr[pickerView.selectedRow(inComponent: 1)]
        let val3 = arr[pickerView.selectedRow(inComponent: 2)]
        hour1 = Int(val1) ?? 0
        min1 = Int(val2) ?? 0
        sec1 = Int(val3) ?? 0
        
    }

// MARK: IBActions

    @IBAction func didChangeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            pickerView.isHidden = false
            sec = 0
            min = 0
            hour = 0
            
            sec1 = 0
            min1 = 0
            hour1 = 0
            
            picker = 1
            label.text = "00:00:00"
            timer.invalidate()
        } else if sender.selectedSegmentIndex == 0 {
            pickerView.isHidden = true
            sec = 0
            min = 0
            hour = 0
            
            sec1 = 0
            min1 = 0
            hour1 = 0
            
            picker = 0
            label.text = "00:00:00"
            timer.invalidate()
        }
    }
    
    @IBAction func didPressStartButton(_ sender: UIButton) {
        timer.invalidate()
        startButton.image = UIImage(systemName: "play.circle")
        pauseButton.image = UIImage(systemName: "pause.circle.fill")
        resetButton.image = UIImage(systemName: "stop.circle.fill")
        if picker == 1 {
            pickerView.isHidden = true
            hour = hour1
            min = min1
            sec = sec1
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    
    @IBAction func didPressPauseButton(_ sender: UIButton) {
        timer.invalidate()
        startButton.image = UIImage(systemName: "play.circle.fill")
        pauseButton.image = UIImage(systemName: "pause.circle")
        resetButton.image = UIImage(systemName: "stop.circle.fill")
        if picker == 1 {
            pickerView.isHidden = false
            
            pickerView.selectRow(hour, inComponent: 0, animated: true)
            pickerView.selectRow(min, inComponent: 1, animated: true)
            pickerView.selectRow(sec, inComponent: 2, animated: true)
            
            hour1 = hour
            min1 = min
            sec1 = sec
        }
    }
    
    @IBAction func didPressResetButton(_ sender: UIButton) {
        timer.invalidate()
        startButton.image = UIImage(systemName: "play.circle.fill")
        pauseButton.image = UIImage(systemName: "pause.circle.fill")
        resetButton.image = UIImage(systemName: "stop.circle")
        if picker == 1 {
            pickerView.isHidden = false
        }
        pickerView.selectRow(0, inComponent: 0, animated: true)
        pickerView.selectRow(0, inComponent: 1, animated: true)
        pickerView.selectRow(0, inComponent: 2, animated: true)
        sec = 0
        min = 0
        hour = 0
        
        sec1 = 0
        min1 = 0
        hour1 = 0
        label.text = "00:00:00"
    }

// MARK: Functions

    func conditions() {
        if min >= 10 && sec >= 10 && hour >= 10 {
            label.text = "\(hour):\(min):\(String(sec))"
        }else if hour >= 10 && sec >= 10{
            label.text = "\(hour):0\(min):\(String(sec))"
        }else if hour >= 10 && min >= 10{
            label.text = "\(hour):\(min):0\(String(sec))"
        }else if hour >= 10{
            label.text = "\(hour):0\(min):0\(String(sec))"
        }else if min >= 10 && sec >= 10{
            label.text = "0\(hour):\(min):\(String(sec))"
        }else if min >= 10  {
            label.text = "0\(hour):\(min):0\(String(sec))"
        }else if sec >= 10 {
            label.text = "0\(hour):0\(min):\(String(sec))"
        } else {
            label.text = "0\(hour):0\(min):0\(String(sec))"
        }
    }
    
    @objc func update() {
        if picker == 0 {
            sec += 1
            if min == 59 && sec == 60 {
                min = 0
                sec = 0
                hour += 1
            }else if sec == 60 {
                sec = 0
                min += 1
            }
        } else if picker == 1 && sec != 0 || min != 0 || hour != 0{
            if min == 0 && sec == 0 {
                min = 59
                sec = 60
                hour -= 1
            }else if sec == 0 {
                sec = 60
                min -= 1
            }
            sec -= 1
        }
        conditions()
    }
}



