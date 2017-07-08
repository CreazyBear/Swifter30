//
//  WalterfallCollectionViewCell.swift
//  CollectionDemo
//
//  Created by 熊伟 on 2017/7/8.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class WalterfallCollectionViewCell: UICollectionViewCell {
    
    var bgImage = UIImageView()
    var label = UILabel()
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        bgImage.frame = self.contentView.bounds
        bgImage.contentMode = .scaleToFill
        label.frame = CGRect.init(x: 0, y: 0, width: contentView.bounds.width, height: 30)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.gray
        label.alpha = 0.5
        contentView.addSubview(bgImage)
        contentView.addSubview(label)
    }
    
    //复用时，frame会改变，需要重新设置
    override func layoutSubviews() {
        super.layoutSubviews()
        bgImage.frame = self.contentView.bounds
        label.frame = CGRect.init(x: 0, y: 0, width: contentView.bounds.width, height: 30)
        
    }
        
}
