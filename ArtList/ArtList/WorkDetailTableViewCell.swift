//
//  WorkDetailTableViewCell.swift
//  ArtList
//
//  Created by Bear on 2017/6/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class WorkDetailTableViewCell: UITableViewCell {

    var model:Work?
    lazy var title:UILabel = {
        let title = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
        title.numberOfLines = 1
        title.textColor = UIColor.black
        title.font = UIFont.systemFont(ofSize: 15)
        title.textAlignment = .center
        return title
    
    }()
    
    lazy var workImage : UIImageView = {
        let workImage = UIImageView.init(frame: CGRect.init(x: (UIScreen.main.bounds.width-200)/2, y: 20, width: 200, height: 200))
        workImage.layer.cornerRadius = 4
        workImage.contentMode = .scaleAspectFit
        return workImage
    }()
    
    lazy var info : UILabel = {
        let infolable = UILabel.init(frame: CGRect.init(x: 10, y: 230, width: UIScreen.main.bounds.width-20, height: 20))
        infolable.numberOfLines = 0
        infolable.textAlignment = .center
        infolable.textColor = UIColor.black
        infolable.font = UIFont.systemFont(ofSize: 13)
        return infolable
    }()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupViews() {
        contentView.addSubview(self.title)
        contentView.addSubview(self.workImage)
        contentView.addSubview(self.info)
    }
    
    func bindData(model:Work) {
        self.model = model
        title.text = model.title
        workImage.image = model.image
        if model.isExpanded
        {
            UIView.animate(withDuration: 0.3, animations: { 
                self.info.text = model.info
                var frame = self.info.frame
                frame.size.height = 140
                self.info.frame = frame
    
            })
        }
        else{
            UIView.animate(withDuration: 0.3, animations: { 
                var frame = self.info.frame
                frame.size.height = 20
                self.info.frame = frame
                self.info.text = "Click to See More Info!"
        
            })
            
        }
        
    }
}
