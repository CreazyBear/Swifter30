//
//  ArtistTableViewCell.swift
//  ArtList
//
//  Created by Bear on 2017/6/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    
    lazy var photo : UIImageView = {
        let photo = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 80, height: 100))
        return photo
    }()
    
    lazy var name : UILabel = {
        let name = UILabel.init(frame: CGRect.init(x: 0, y: 100, width: 80, height: 60))
        name.textColor = UIColor.black
        name.backgroundColor = UIColor.white
        name.numberOfLines = 0
        name.textAlignment = .center
        name.font = UIFont.systemFont(ofSize: 13)
        return name
    }()

    lazy var bio : UILabel = {
        let bio = UILabel.init(frame: CGRect.init(x: 100, y: 0, width: UIScreen.main.bounds.width-110, height: 160))
        bio.textColor = UIColor.black
        bio.backgroundColor = UIColor.white
        bio.numberOfLines = 0
        bio.textAlignment = .center
        bio.font = UIFont.systemFont(ofSize: 13)
        return bio
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() {
        contentView.addSubview(self.photo)
        contentView.addSubview(self.name)
        contentView.addSubview(self.bio)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)

        // Configure the view for the selected state
    }
    
    func bindData(model:Artist) {
        self.photo.image = model.image
        self.name.text = model.name
        self.bio.text = model.bio
    }

}
