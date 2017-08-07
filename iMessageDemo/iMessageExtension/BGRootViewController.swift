//
//  BGRootViewController.swift
//  iMessageDemo
//
//  Created by Bear on 2017/8/7.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class BGRootViewController: UIViewController {

    lazy var stickerButton : UIButton = {
        let view : UIButton = UIButton()
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.5
        view.setTitle("sticker", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.addTarget(self, action: #selector(handleStickerButtonClick(sender:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    
    }()
    
    func handleStickerButtonClick(sender:UIButton) {
        let stickerVC = BGStickerBrowserViewController(stickerSize: .small)
        self.navigationController?.pushViewController(stickerVC, animated: true)
    }
    
    lazy var selfDefineButton : UIButton = {
        let view : UIButton = UIButton()
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.5
        view.setTitle("SelfDefine", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.addTarget(self, action: #selector(handleSelfDefineButtonClick(sender:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    func handleSelfDefineButtonClick(sender:UIButton) {
        let selfDefineButton = BGSelfDefineViewController()
        self.navigationController?.pushViewController(selfDefineButton, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor  = UIColor.white
        self.view.addSubview(stickerButton)
        self.view.addSubview(selfDefineButton)
        
        stickerButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        stickerButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stickerButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stickerButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -25).isActive = true

        selfDefineButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        selfDefineButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 25).isActive = true
        selfDefineButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        selfDefineButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}
