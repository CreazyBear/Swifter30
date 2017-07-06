//
//  SimpleCellCollectionViewCell.swift
//  CollectionDemo
//
//  Created by Bear on 2017/7/6.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class SimpleCellCollectionViewCell: UICollectionViewCell {
    lazy var titleLabel : UILabel = {
        let view : UILabel = UILabel.init(frame: self.bounds)
        view.textColor = UIColor.black
        view.font = UIFont.systemFont(ofSize: 14)
        view.textAlignment = .center
        
        return view
    }()
    
    func setupView(num:Int) {
        self.addSubview(titleLabel)
        self.backgroundColor = UIColor.white
        titleLabel.text = "\(num)"
    }
}
