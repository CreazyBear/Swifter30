//
//  ViewController.swift
//  PhotoScroll
//
//  Created by Bear on 2017/6/28.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    fileprivate let reuseIdentifier = "PhotoCell"
    
    fileprivate let thumbnailSize:CGFloat = 70.0
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 10, left: 5.0, bottom: 10.0, right: 5.0)
    
    fileprivate let photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    
    lazy var collectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: self.thumbnailSize, height: self.thumbnailSize)
        layout.sectionInset = self.sectionInsets
        let collectionView : UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(PhotoThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
        return collectionView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "PhotoScroll"
        view.backgroundColor = UIColor.white
        view.addSubview(collectionView)
    }
    
}


extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.reuseIdentifier, for: indexPath) as! PhotoThumbnailCollectionViewCell
        cell.bindData(imageName: photos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pager = PhotoPagerViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pager.currentIndex = indexPath.row
        navigationController?.pushViewController(pager, animated: true)
    }
    
}
