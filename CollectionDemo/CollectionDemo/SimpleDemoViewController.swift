//
//  SimpleDemoViewController.swift
//  CollectionDemo
//
//  Created by Bear on 2017/7/6.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class SimpleDemoViewController: UIViewController {

    let headerId = "simpleHead"
    let footerId = "simpleFooter"
    
    var dataSourceOne : Array<Int> = Array()
    var dataSourceTwo : Array<Int> = Array()
    var dataSource : Array<Array<Int>> = Array()
    
    lazy var collectionView : UICollectionView = {
        let flowLayout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        //滚动方向
        flowLayout.scrollDirection = .vertical
        //cell的大小
        flowLayout.itemSize = CGSize(width: 80, height: 80)
        //滚动方向的垂直方向上，单元格之间的间隔
        flowLayout.minimumInteritemSpacing = 10
        //滚动方向，单元格之间的间隔
        flowLayout.minimumLineSpacing = 10
        //头部的大小，只会读取滚动方向的值：水平滚动的话，读取宽度；垂直滚动，读取高度；
        flowLayout.headerReferenceSize = CGSize(width: 60, height: 40)
        //同上
        flowLayout.footerReferenceSize = CGSize(width: 60, height: 40)
        
        let view : UICollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: flowLayout)
        view.register(SimpleCellCollectionViewCell.self, forCellWithReuseIdentifier: String.init(describing: SimpleCellCollectionViewCell.self))
        view.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.headerId)
        view.register(FooterCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: self.footerId)
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = UIColor.orange
        let gesture = UILongPressGestureRecognizer.init(target: self, action: #selector(self.handleLongPressGesture(gesture:)))
        view.addGestureRecognizer(gesture)
        return view
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Simple Demo"
        view.backgroundColor = UIColor.white
        
        for ele in 0...49 {
            self.dataSourceOne.append(ele)
            self.dataSourceTwo.append(ele)
        }
        dataSource.append(dataSourceOne)
        dataSource.append(dataSourceTwo)
        
        view.addSubview(collectionView)
    }
    
    
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

extension SimpleDemoViewController : UICollectionViewDelegate,UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    //设置head foot视图
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind as NSString).isEqual(to: UICollectionElementKindSectionHeader)
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
    
    //设置每个单元格
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: SimpleCellCollectionViewCell.self), for: indexPath) as! SimpleCellCollectionViewCell
        cell.setupView(num: dataSource[indexPath.section][indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //设置选中高亮时的颜色
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.red
    }
    //设置取消高亮时的颜色
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.white
    }
    
    //长按是否弹出菜单，和长按移动单元格冲突~！
    func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    //单元格是否可以被选中，只对下面的didSelectItemAt进行控件。高亮什么的都不归这货管
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if indexPath.row%2 == 0
        {
            return false
        }
        else
        {
            return true
        }
    }
    //单元格被选中后的事件
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
    //响应哪些菜单项
    func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        let selectorStr = NSStringFromSelector(action) as NSString
        if selectorStr.isEqual(to: "cut:")
        {
            return true
        }
        else if selectorStr.isEqual(to: "copy:")
        {
            return true
        }
        else if selectorStr.isEqual(to: "paste")
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    //响应长按菜单
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        let selectorStr = NSStringFromSelector(action) as NSString
        if selectorStr.isEqual(to: "cut:")
        {
            let array = [indexPath]
            dataSource[indexPath.section].remove(at: indexPath.row)
            collectionView.deleteItems(at: array)
        }
        else if selectorStr.isEqual(to: "copy:")
        {
            
        }
        else if selectorStr.isEqual(to: "paste")
        {
            
        }
        else
        {
            
        }
    }
    
    
    //配合手势移动使用
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let value = dataSource[sourceIndexPath.section][sourceIndexPath.row]
        dataSource[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        dataSource[destinationIndexPath.section].insert(value, at: destinationIndexPath.row)
    }
}
































