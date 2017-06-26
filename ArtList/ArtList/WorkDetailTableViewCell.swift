//
//  WorkDetailTableViewCell.swift
//  ArtList
//
//  Created by Bear on 2017/6/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class WorkDetailTableViewCell: UITableViewCell {

    lazy var title:UILabel = {
        let title = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20))
        title.numberOfLines = 1
        title.textColor = UIColor.black
        title.font = UIFont.systemFont(ofSize: 15)
        title.textAlignment = .center
        return title
    
    }()
    
    lazy var workImage : UIImageView = {
        let workImage = UIImageView.init(frame: CGRect.init(x: 10, y: 20, width: UIScreen.main.bounds.width-60, height: UIScreen.main.bounds.width-50))
        workImage.layer.cornerRadius = 4
        workImage.contentMode = .scaleAspectFit
        return workImage
    }()
    
    lazy var info : UILabel = {
        let infolable = UILabel.init(frame: CGRect.init(x: 10, y: UIScreen.main.bounds.width+30, width: UIScreen.main.bounds.width-20, height: 20))
        infolable.numberOfLines = 0
        infolable.textAlignment = .center
        infolable.textColor = UIColor.white
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

        // Configure the view for the selected state
    }
    
    func setupViews() {
        contentView.addSubview(self.title)
        contentView.addSubview(self.workImage)
        contentView.addSubview(self.info)
    }
    
    func bindData(model:Work) {
        title.text = model.title
        workImage.image = model.image
        if model.isExpanded
        {
            info.text = model.info
        }
        else{
            info.text = "Click to See More Info!"
        }
        
    }
}
