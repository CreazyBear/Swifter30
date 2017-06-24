//
//  UIMassiveViewController.swift
//  UIElements
//
//  Created by Bear on 2017/6/21.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class UIMassiveViewController: UIViewController {

    //**********************************************************************************************
    //MARK: -  start segment controller
    //**********************************************************************************************

    lazy var segmentController :UISegmentedControl = {
        let segmentArray = ["1","2","3","4"]
        let segmentController:UISegmentedControl = UISegmentedControl.init(items: segmentArray)
        segmentController.frame = CGRect.init(x: 10, y: 100, width: UIScreen.main.bounds.width-20, height: 30)
        segmentController.addTarget(self, action: #selector(self.handleSegmentClicked(sender:)), for: .valueChanged)
        return segmentController
    }()
    
    lazy var segmentModifyButton :UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 10, y: 150, width: 130, height: 40))
        button.setTitle("修改Seg", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(self.modifySegmentController), for: .touchUpInside)
        return button
    
    }()
    
    lazy var segmentNaviButton :UIButton = {
        let button = UIButton.init(frame: CGRect.init(x: 200, y: 150, width: 130, height: 40))
        button.setTitle("放到导航栏上", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(self.naviSegment), for: .touchUpInside)
        return button
        
    }()
    
    @objc
    func modifySegmentController() {
        //添加一个分段(在指定下标下插入,并设置动画效果)
        self.segmentController.insertSegment(withTitle: "插入的", at: 2, animated: false)
        //移除一个分段(根据下标)
        self.segmentController.removeSegment(at: 3, animated: true)
        
        //根据下标修改分段标题(修改下标为2的分段)
        self.segmentController.setTitle("hello", forSegmentAt: 0)
        //根据内容定分段宽度
        self.segmentController.apportionsSegmentWidthsByContent = true;
        //开始时默认选中下标(第一个下标默认是0)
        self.segmentController.selectedSegmentIndex = 2
        //控件渲染色(也就是外观字体颜色)
        self.segmentController.tintColor = UIColor.blue
        //按下是否会自动释放：
        self.segmentController.isMomentary = true
    }
    @objc
    func naviSegment() {
        self.navigationItem.titleView = segmentController
    }
    @objc
    func handleSegmentClicked(sender:UISegmentedControl) {
        
        print("\(String(describing: sender.titleForSegment(at: sender.selectedSegmentIndex)))")
    }


    //**********************************************************************************************
    //MARK: -    end segment controller
    //**********************************************************************************************

    
    //**********************************************************************************************
    //MARK: -    start slider
    //**********************************************************************************************
    lazy var slider:UISlider = {
        let slider = UISlider.init(frame: CGRect.init(x: 30, y: 210, width: UIScreen.main.bounds.width-60, height: 10))
        slider.maximumValue = 100
        slider.minimumValue = 0
        //是否值一改变就调用valueChanged
        slider.isContinuous = true
        slider.addTarget(self, action: #selector(self.handleSliderChanged(sender:)), for: .valueChanged)
        return slider
        
    
    }()
    
    @objc
    func handleSliderChanged(sender:UISlider) {
        print("\(sender.value)")
        let persenValue:Float = sender.value/100
        self.progressView.setProgress(persenValue, animated: true)
    }
    
    //**********************************************************************************************
    //MARK: -    end slider
    //**********************************************************************************************

    
    
    //**********************************************************************************************
    //MARK: -    start switch view
    //**********************************************************************************************

    lazy var switchView :UISwitch = {
        let switchView :UISwitch = UISwitch.init()
        switchView.center = CGPoint.init(x: 50, y: 250)
        switchView.addTarget(self, action: #selector(self.handleSwitchChanged(sender:)), for: .valueChanged)
        return switchView
    }()
    
    @objc
    func handleSwitchChanged(sender:UISwitch)  {
        print("\(sender.isOn)")
        if(sender.isOn)
        {
            self.activityIndicatorView.startAnimating()
        }
        else{
            self.activityIndicatorView.stopAnimating()
        }
    }
    //**********************************************************************************************
    //MARK: -    end switch view
    //**********************************************************************************************

    
    //**********************************************************************************************
    //MARK: -    start activity indicator view
    //**********************************************************************************************
    lazy var activityIndicatorView :UIActivityIndicatorView = {
        let activityIndicatorView:UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.center = CGPoint.init(x: 150, y: 250)
        
        activityIndicatorView.activityIndicatorViewStyle = .gray
        activityIndicatorView.color = UIColor.blue
        activityIndicatorView.hidesWhenStopped = false
        return activityIndicatorView
    }()
    
 
    //**********************************************************************************************
    //MARK: -    end activity indicator view
    //**********************************************************************************************

    
    
    //**********************************************************************************************
    //MARK: -    start progress view
    //**********************************************************************************************
    lazy var progressView:UIProgressView = {
        let progressView:UIProgressView = UIProgressView.init(progressViewStyle: .default)
        progressView.frame = CGRect.init(x: 30, y: 280, width: UIScreen.main.bounds.width-60, height: 10)
        progressView.trackTintColor = UIColor.red
        progressView.progress = 0.7
        progressView.progressTintColor = UIColor.blue
        return progressView
    }()
    
    //**********************************************************************************************
    //MARK: -    end progress view
    //**********************************************************************************************

    
    //**********************************************************************************************
    //MARK: -    start stepper
    //**********************************************************************************************
    lazy var stepper:UIStepper = {
        //设置位置，宽高不能改变
        let _stepper :UIStepper = UIStepper.init(frame: CGRect.init(x: 30, y: 310, width: 100, height: 30))
        //改变边框和+和-的颜色，默认是浅蓝色
        _stepper.tintColor = UIColor.red
        
        //设置步进器的最小值
        _stepper.minimumValue=0;
        
        //设置步进器的最大值
        _stepper.maximumValue=100;
        
        //设置步进器的当前值，默认值为0
        _stepper.value=99;
        
        //设置步进值，每次向前或者向后步进的步伐值
        _stepper.stepValue=1;
        
        //是否可以重复响应的事件操作,按住+或者-会一直加或者减
        _stepper.autorepeat=true;
        
        //是否将步进结果通过事件函数响应出来
        _stepper.isContinuous=true;
        _stepper.addTarget(self, action: #selector(self.handleStepperChange(sender:)), for: .valueChanged)
        return _stepper
    
    }()
    @objc
    func handleStepperChange(sender:UIStepper) {
        print("\(sender.value)")
        if(sender.value == sender.maximumValue)
        {
            self.showAlertView()
        }
    }
    
    //**********************************************************************************************
    //MARK: -    end stepper
    //**********************************************************************************************

    
    
    //**********************************************************************************************
    //MARK: -   start alert view
    //**********************************************************************************************
    func showAlertView() {
        let alertView :UIAlertController = UIAlertController.init(title: "Warning", message: "步进器已到上限", preferredStyle: .alert)
        let alertActionOne :UIAlertAction = UIAlertAction.init(title: "知道了", style: .default) { (sender:UIAlertAction) in
            print("\(String(describing: sender.title))")
        }
        let alertActionTwo :UIAlertAction = UIAlertAction.init(title: "oh,On", style: .default) { (sender:UIAlertAction) in
            print("\(String(describing: sender.title))")
        }
        alertView.addAction(alertActionOne)
        alertView.addAction(alertActionTwo)
        self.present(alertView, animated: true) { 
            
        }
    }
    
    //**********************************************************************************************
    //MARK: -    end alert view
    //**********************************************************************************************

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "Massive"
        
    
        self.view.addSubview(self.segmentController)
        self.view.addSubview(self.segmentModifyButton)
        self.view.addSubview(self.segmentNaviButton)
        self.view.addSubview(self.slider)
        self.view.addSubview(self.switchView)
        self.view.addSubview(self.activityIndicatorView)
        self.view.addSubview(self.progressView)
        self.view.addSubview(self.stepper)

     
    }

}
