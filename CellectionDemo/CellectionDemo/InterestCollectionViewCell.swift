//
//  InterestCollectionViewCell.swift
//  CellectionDemo
//
//  Created by 熊伟 on 2017/6/27.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell {
    lazy var imageView : UIImageView = {
        let view = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: self.contentView.bounds.width, height: self.contentView.bounds.height))
        return view
    }()
    
    lazy var labelName : UILabel = {
        let lableName : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: self.contentView.bounds.height - 40, width: self.contentView.bounds.width, height: 40))
        lableName.textColor = UIColor.black
        lableName.numberOfLines = 0
        lableName.font = UIFont.systemFont(ofSize: 14)
        lableName.textAlignment = .center
        lableName.backgroundColor = UIColor.white
        return lableName
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(labelName)
    }
    
    var interest: Interest! {
        didSet {
            updateUI()
        }
    }
    
    
    fileprivate func updateUI() {
        labelName.text = interest.title
        imageView.image = interest.featuredImage
    }
    
    // MARK: - refactor layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
    }

    
    static func cellId ()->String
    {
        return String(describing: self)
    }
    
    
    
}
