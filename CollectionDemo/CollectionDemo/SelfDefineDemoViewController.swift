//
//  SelfDefineDemoViewController.swift
//  CollectionDemo
//
//  Created by 熊伟 on 2017/7/8.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class SelfDefineDemoViewController: UIViewController {

    let headerId = "simpleHead"
    let footerId = "simpleFooter"
    lazy var imageArr : NSMutableArray = {
        let array = NSMutableArray()
        for i in 0..<100
        {
            array.add("\(i%20).jpg")
        }
        return array
    }()
    
    
    
    /// 创建collectionview
    lazy var collectionView : UICollectionView = {
        
        //自定义的layout，很多属性已经写好了默认值，所以这里就不再设置了。
        let flowLayout : WalterflowCollectionViewLayout = WalterflowCollectionViewLayout()
        flowLayout.delegate = self
        
        let view : UICollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: flowLayout)
        //cell复用
        view.register(WalterfallCollectionViewCell.self, forCellWithReuseIdentifier: String.init(describing: WalterfallCollectionViewCell.self))
        //head复用
        view.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: BGUICollectionElementKindSectionHeader, withReuseIdentifier: self.headerId)
        //foot复用
        view.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind: BGUICollectionElementKindSectionFooter, withReuseIdentifier: self.footerId)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.orange
        //手势，本例中用于找按移动
        let gesture = UILongPressGestureRecognizer.init(target: self, action: #selector(self.handleLongPressGesture(gesture:)))
        view.addGestureRecognizer(gesture)
        return view
    }()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        title = "自定义CellectionView"
        view.addSubview(collectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //处理长按移动cell
    func handleLongPressGesture(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            let touchItemIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView))
            guard touchItemIndexPath != nil else {
                return
            }
            self.collectionView.beginInteractiveMovementForItem(at: touchItemIndexPath!)
            
        case .changed:
            self.collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view))
        case .ended,.cancelled:
            self.collectionView.endInteractiveMovement()
        default:
            break
        }
    }

}

extension SelfDefineDemoViewController:UICollectionViewDelegate,UICollectionViewDataSource,WalterflowCollectionViewLayoutDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    
    //**********************************************************************************************
    //MARK: - start 移动
    //**********************************************************************************************
    //下面两个方法在本例中都需要实现，代理也不能干掉，否则会产生移动的cell会产生形变
    //在自定义的layout中被调用
    func collectionView(moveItemAtIndexPath sourceIndexPath: IndexPath,
                        toIndexPath destinationIndexPath: IndexPath) {
        if sourceIndexPath.row != destinationIndexPath.row {
            let value = imageArr[sourceIndexPath.row]
            imageArr.removeObject(at: sourceIndexPath.row)
            imageArr.insert(value, at: destinationIndexPath.row)
        }
    }
    //被系统调用
    func collectionView(_ collectionView: UICollectionView,
                        moveItemAt sourceIndexPath: IndexPath,
                        to destinationIndexPath: IndexPath)
    {

    }
    //**********************************************************************************************
    //MARK: - end 移动
    //**********************************************************************************************

    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: WalterfallCollectionViewCell.self), for: indexPath) as! WalterfallCollectionViewCell
        
        cell.bgImage.image = UIImage.init(named: imageArr[indexPath.row] as! String)
        cell.label.text = "\(indexPath.row)"
        return cell
    }
    
    //设置head foot视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind as NSString).isEqual(to: BGUICollectionElementKindSectionHeader)
        {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.headerId, for: indexPath) as! HeaderCollectionReusableView
            header.setupView()
            return header
        }
        else
        {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.footerId, for: indexPath) as! FooterCollectionReusableView
            footer.setupView()
            return footer
        }
    }
    
    
    /// 返回cell的高度
    func collectionView(_ collectionView:UICollectionView,
                        _ layout:WalterflowCollectionViewLayout,
                        heightOfItemAtIndexPath indexPath:IndexPath,
                        _ itemWidth:CGFloat) -> CGFloat {
        let image = UIImage.init(named: imageArr[indexPath.row] as! String)
        guard image != nil else {
            return 0
        }
        return (image?.size.height)! / (image?.size.width)! * itemWidth
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        cell.contentView.alpha = 0;
        cell.transform = CGAffineTransform(scaleX: 0, y: 0).rotated(by: 0);
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .layoutSubviews, animations: { 
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.8, animations: { 
                cell.contentView.alpha = 0.5
                cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2).rotated(by: 0)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.8, animations: { 
                cell.contentView.alpha = 1
                cell.transform = CGAffineTransform(scaleX: 1, y: 1).rotated(by: 0)
            })
            
        }) { (finished) in
            
        }
    }
    
}






