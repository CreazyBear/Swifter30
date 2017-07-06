//
//  HeaderCollectionReusableView.swift
//  CollectionDemo
//
//  Created by Bear on 2017/7/6.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    lazy var titleLabel : UILabel = {
        let view : UILabel = UILabel.init(frame: self.bounds)
        view.textColor = UIColor.black
        view.font = UIFont.systemFont(ofSize: 14)
        view.textAlignment = .center
        view.text = "Header"
        return view
    }()
    
    func setupView() {
        self.addSubview(titleLabel)
        self.backgroundColor = UIColor.gray
        
    }
    
}
