//
//  BGStickerBrowserViewController.swift
//  iMessageDemo
//
//  Created by Bear on 2017/8/7.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit
import Messages

class BGStickerBrowserViewController: MSStickerBrowserViewController {

    var dataSource : Array<MSSticker> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sticker"
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = UIColor.white
        let stickerUrls = Bundle.main.urls(forResourcesWithExtension: ".gif", subdirectory: "")
        guard stickerUrls != nil ,(stickerUrls?.count)!>0 else {
            return
        }
        for ele in stickerUrls! {
            let sticker = try? MSSticker(contentsOfFileURL: ele, localizedDescription: ele.path)
            guard sticker != nil else {
                continue
            }
            dataSource.append(sticker!)
        }
    }
    
    override func numberOfStickers(in stickerBrowserView: MSStickerBrowserView) -> Int {
        return dataSource.count
    }
    
    override func stickerBrowserView(_ stickerBrowserView: MSStickerBrowserView, stickerAt index: Int) -> MSSticker {
        return dataSource[index]
    }
}
