//
//  NewsTableViewCell.swift
//  AppleNews
//
//  Created by 熊伟 on 2017/6/27.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let titleFontSize = CGFloat( 16)
    static let dateFontSize = CGFloat(13)
    static let contentFontSize = CGFloat(14)
    
    
    lazy var title : UILabel = {
        let title : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
        title.textColor = UIColor.black
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: titleFontSize)
        title.textAlignment = .center
        return title
    }()
    
    lazy var date : UILabel = {
        let date : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
        date.textColor = UIColor.gray
        date.numberOfLines = 1
        date.font = UIFont.systemFont(ofSize: dateFontSize)
        date.textAlignment = .right
        return date
    }()
    
    lazy var content : UILabel = {
        let content : UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
        content.textColor = UIColor.black
        content.numberOfLines = 0
        content.font = UIFont.systemFont(ofSize: contentFontSize)
        return content
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(self.title)
        contentView.addSubview(self.date)
        contentView.addSubview(self.content)
    }
    
    static func cellId()->String
    {
        return String(describing: self)
    }
    
    func bindData(model:(title: String, description: String, pubDate: String))
    {
        self.title.text = model.title
        self.date.text = model.pubDate
        self.content.text = model.description
        
        let titleHeight = model.title.heightWithConstrainedWidth(width: UIScreen.main.bounds.width, font: UIFont.systemFont(ofSize: NewsTableViewCell.titleFontSize))
        let dateHeight = model.pubDate.heightWithConstrainedWidth(width: UIScreen.main.bounds.width, font: UIFont.systemFont(ofSize: NewsTableViewCell.dateFontSize))
        let contentHeight = model.description.heightWithConstrainedWidth(width: UIScreen.main.bounds.width, font: UIFont.systemFont(ofSize: NewsTableViewCell.contentFontSize))
        
        self.title.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: titleHeight)
        self.date.frame = CGRect.init(x: 0, y: titleHeight + 10, width: UIScreen.main.bounds.width, height: dateHeight)
        self.content.frame = CGRect.init(x: 0, y: titleHeight+dateHeight + 20, width: UIScreen.main.bounds.width, height: contentHeight)

    }

    static func heightForCell(model:(title: String, description: String, pubDate: String)) ->CGFloat
    {
        let titleHeight = model.title.heightWithConstrainedWidth(width: UIScreen.main.bounds.width, font: UIFont.systemFont(ofSize: titleFontSize))
        let dateHeight = model.pubDate.heightWithConstrainedWidth(width: UIScreen.main.bounds.width, font: UIFont.systemFont(ofSize: dateFontSize))
        let contentHeight = model.description.heightWithConstrainedWidth(width: UIScreen.main.bounds.width, font: UIFont.systemFont(ofSize: contentFontSize))
        return CGFloat( titleHeight + dateHeight + contentHeight + 30)
    }
    

}

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
}
