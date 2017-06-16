//
//  ViewController.swift
//  PhoneHistory
//
//  Created by Bear on 2017/6/15.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var navigationTitle :String
    
    
    init() {
        navigationTitle = "PhoneList"
        super.init(nibName: nil, bundle: nil)
        
    }
    
    convenience init(title:String)
    {
        //未初始化时，属性是不被赋值的，因为其内存空间不存在
        //so,下面两行代码不能对调
        self.init()
        navigationTitle = title
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        navigationTitle = "PhoneList"
        super.init(coder: aDecoder);
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        self.title = navigationTitle
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

