//
//  AboutMeViewController.swift
//  PhoneHistory
//
//  Created by 熊伟 on 2017/6/18.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class AboutMeViewController: UIViewController {
    var test:Int = 12
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRect.zero)
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
    
    lazy var headerImageView:UIImageView = {
        let headerImageView = UIImageView(frame:CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 125))
        headerImageView.image = UIImage.init(named: "header-contact")
        return headerImageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.scrollView.frame = self.view.bounds
        self.view.addSubview(self.scrollView)
        self.headerImageView.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 125)
        self.scrollView.addSubview(self.headerImageView)

    }
}
