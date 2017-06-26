//
//  DetailViewController.swift
//  SearchCandy
//
//  Created by Bear on 2017/6/26.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    lazy var detailDescriptionLabel : UILabel = {
        let detailDescriptionLabel = UILabel.init(frame: CGRect.init(x: 0, y: 70, width: UIScreen.main.bounds.width, height: 34))
        detailDescriptionLabel.textColor = UIColor.black
        detailDescriptionLabel.numberOfLines = 1
        detailDescriptionLabel.font = UIFont.systemFont(ofSize: 18)
        return detailDescriptionLabel
    }()
    
    lazy var candyImageView : UIImageView = {
        let candyImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 80, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 80))
        candyImageView.contentMode = .scaleAspectFit
        return candyImageView
    }()
    
    
    var detailCandy: Candy? {
        didSet {
            configureView()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(self.detailDescriptionLabel)
        view.addSubview(self.candyImageView)
        configureView()
    }
    
    func configureView()
    {
        if let detailCandy = detailCandy
        {
            detailDescriptionLabel.text = detailCandy.name
            candyImageView.image = UIImage(named: detailCandy.name)
            title = detailCandy.category

        }
    }

}
