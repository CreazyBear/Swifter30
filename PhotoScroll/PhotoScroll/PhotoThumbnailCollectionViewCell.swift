//
//  PhotoThumbnailCollectionViewCell.swift
//  PhotoScroll
//
//  Created by Bear on 2017/6/28.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class PhotoThumbnailCollectionViewCell: UICollectionViewCell {
    lazy var image : UIImageView = {
        let image = UIImageView.init(frame: self.contentView.bounds)
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func bindData(imageName:String) {
        image.image = UIImage(named: imageName)
    }
}
