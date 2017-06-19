//
//  PhoneDetail.swift
//  PhoneHistory
//
//  Created by 熊伟 on 2017/6/19.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class PhoneDetail: UIViewController {
    
    lazy var text :UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 100))
        label.backgroundColor = UIColor.white
        label.textColor = UIColor.black
        label.text = "hello phone~! I am to lazy to write something down"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.yellow
        self.view.addSubview(self.text)
    }
    
    
}
