//
//  ViewController.swift
//  Timer
//
//  Created by 熊伟 on 2017/6/24.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

enum TimerStatue {
    case inited
    case running
    case stoped
    
}

class BGTimer :NSObject{
    var counter: Double
    var timer: Timer
    
    override init() {
        counter = 0.0
        timer = Timer()
    }
}

class ViewController: UIViewController {

    var mainLabel:UILabel = UILabel()
    var lapLabel:UILabel = UILabel()
    
    var playPauseButton:UIButton!
    var lapResetButton:UIButton!
    var tableView:UITableView!
    
    var mainTimer:BGTimer!
    var lapTimer:BGTimer!
    
    
    var timerStatue:TimerStatue = .inited
    let cellIdentify :String = "cell"
    
    var laps:Array<String> = Array.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
        self.setupTimeLabel()
        self.setupButtons()
        self.setupTableView()
        self.setupTimers()
        
        
        
    }
    
    
    func setupTimers() {
        mainTimer = BGTimer.init()
        mainTimer.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(self.updateMainTimer), userInfo: nil, repeats: true)
        lapTimer = BGTimer.init()
        lapTimer.timer = Timer.scheduledTimer(timeInterval: 0.035, target: self, selector: #selector(self.updateLapTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(mainTimer.timer, forMode: .commonModes)
        RunLoop.current.add(lapTimer.timer, forMode: .commonModes)
        mainTimer.timer.fireDate = Date.distantFuture
        lapTimer.timer.fireDate = Date.distantFuture
    }
    
    func resetTimer(_ timer: BGTimer, label: UILabel) {
        timer.counter = 0.0
        label.text = "00:00:00"
    }
    
    func updateMainTimer() {
        ViewController.updateLabel(mainTimer, label: mainLabel)
    }
    
    func updateLapTimer() {
        ViewController.updateLabel(lapTimer, label: lapLabel)
    }
    
    func setupTableView() {
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 200, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-200))
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentify)
        self.view.addSubview(tableView)
    }

    func setupButtons() {
        playPauseButton = UIButton.init(frame: CGRect.init(x: 30, y: 150, width: 100, height: 50))
        playPauseButton.setTitleColor(UIColor.black, for: .normal)
        playPauseButton.setTitle("Start", for: .normal)
        playPauseButton.layer.borderColor = UIColor.gray.cgColor
        playPauseButton.layer.cornerRadius = 5
        playPauseButton.layer.borderWidth = 1
        playPauseButton.addTarget(self, action: #selector(self.handlePlayPauseButtonClicked(sender:)), for: .touchUpInside)
        self.view.addSubview(playPauseButton)
        
        
        lapResetButton = UIButton.init(frame: CGRect.init(x: UIScreen.main.bounds.width-130, y: 150, width: 100, height: 50))
        lapResetButton.setTitleColor(UIColor.gray, for: .normal)
        lapResetButton.setTitle("Lap", for: .normal)
        lapResetButton.layer.borderColor = UIColor.gray.cgColor
        lapResetButton.layer.cornerRadius = 5
        lapResetButton.layer.borderWidth = 1
        lapResetButton.isEnabled = false
        lapResetButton.addTarget(self, action: #selector(self.handleLapResetButtonClicked(sender:)), for: .touchUpInside)
        self.view.addSubview(lapResetButton)
        
    }
    
    func setupTimeLabel() {
        mainLabel.frame = CGRect.init(x: 0, y: 80, width: UIScreen.main.bounds.width, height: 20)
        mainLabel.textAlignment = .center
        mainLabel.textColor = UIColor.black
        mainLabel.text = "00:00:00"
        mainLabel.font = UIFont.systemFont(ofSize: 18)
        self.view.addSubview(mainLabel)
        
        
        lapLabel.frame = CGRect.init(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 16)
        lapLabel.textAlignment = .center
        lapLabel.textColor = UIColor.black
        lapLabel.text = "00:00:00"
        lapLabel.font = UIFont.systemFont(ofSize: 14)
        self.view.addSubview(lapLabel)
    }
    
    func updateButtonStatue() {
        switch timerStatue {
        case .inited:
            playPauseButton.setTitle("Start", for: .normal)
            lapResetButton.setTitle("Lap", for: .normal)
            lapResetButton.isEnabled = false
            lapResetButton.setTitleColor(UIColor.gray, for: .normal)
            
        case .running:
            playPauseButton.setTitle("Stop", for: .normal)
            lapResetButton.setTitle("Lap", for: .normal)
            lapResetButton.isEnabled = true
            lapResetButton.setTitleColor(UIColor.black, for: .normal)
            
        case .stoped:
            playPauseButton.setTitle("Start", for: .normal)
            lapResetButton.setTitle("Reset", for: .normal)
            lapResetButton.isEnabled = true
            lapResetButton.setTitleColor(UIColor.black, for: .normal)
            
        }
    }
    
    //MARK: - Button actions
    @objc
    func handlePlayPauseButtonClicked(sender:UIButton) {
        if(timerStatue == .inited)
        {
            timerStatue = .running
            self.updateButtonStatue()
            mainTimer.timer.fireDate = Date.distantPast
            lapTimer.timer.fireDate = Date.distantPast
        }
        else if(timerStatue == .running)
        {
            timerStatue = .stoped
            self.updateButtonStatue()
            mainTimer.timer.fireDate = Date.distantFuture
            lapTimer.timer.fireDate = Date.distantFuture
        }
        else if(timerStatue == .stoped)
        {
            timerStatue = .running
            self.updateButtonStatue()
            mainTimer.timer.fireDate = Date.distantPast
            lapTimer.timer.fireDate = Date.distantPast
        }
    }
    
    @objc
    func handleLapResetButtonClicked(sender:UIButton) {
        if(timerStatue == .running)
        {
            laps.append(lapLabel.text ?? "")
            self.resetTimer(lapTimer, label: lapLabel)
            tableView.reloadData()
        }
        else if(timerStatue == .stoped)
        {
            timerStatue = .inited
            self.updateButtonStatue()
            laps.removeAll()
            tableView.reloadData()
            self.resetTimer(mainTimer, label: mainLabel)
            self.resetTimer(lapTimer, label: lapLabel)
        }
    }
    
    
    class func updateLabel(_ stopwatch:BGTimer, label:UILabel) {
        stopwatch.counter = stopwatch.counter + 0.035
        
        var minutes: String = "\((Int)(stopwatch.counter / 60))"
        if (Int)(stopwatch.counter / 60) < 10 {
            minutes = "0\((Int)(stopwatch.counter / 60))"
        }
        
        var seconds: String = String(format: "%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        
        label.text = minutes + ":" + seconds
    }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentify, for: indexPath)
        guard laps.count>indexPath.row else { return cell }
        cell.textLabel?.text = laps[indexPath.row]
        return cell
    }
}
















