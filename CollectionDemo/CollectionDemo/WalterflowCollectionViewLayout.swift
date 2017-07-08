//
//  WalterflowCollectionViewLayout.swift
//  CollectionDemo
//
//  Created by 熊伟 on 2017/7/8.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

let BGUICollectionElementKindSectionHeader = "BG_HeadView";
let BGUICollectionElementKindSectionFooter = "BG_FootView";

protocol WalterflowCollectionViewLayoutDelegate {
    
    func collectionView(_ collectionView:UICollectionView,
                        _ layout:WalterflowCollectionViewLayout,
                        heightOfItemAtIndexPath indexPath:IndexPath,
                        _ itemWidth:CGFloat  )
        -> CGFloat;
    
    
    func collectionView(moveItemAtIndexPath sourceIndexPath:IndexPath,
                        toIndexPath destinationIndexPath:IndexPath );

}

class WalterflowCollectionViewLayout: UICollectionViewLayout {
    var numberOfColumns = 2
    var cellDistance:CGFloat = 10
    var topAndBottomDistance:CGFloat = 10
    var headerViewHeight:CGFloat = 40
    var footerViewHeight:CGFloat = 40
    var delegate:WalterflowCollectionViewLayoutDelegate?
    
    var cellLayoutInfo : Dictionary<IndexPath,UICollectionViewLayoutAttributes> = Dictionary()
    var headLayoutInfo : Dictionary<IndexPath,UICollectionViewLayoutAttributes> = Dictionary()
    var footLayoutInfo : Dictionary<IndexPath,UICollectionViewLayoutAttributes> = Dictionary()
    var startY : CGFloat = 0
    var maxYForColumn : Dictionary<Int,CGFloat> = Dictionary()
    var shouldanimationArr : Array<IndexPath> = Array()
    
    
    
    /// 主要是这个方法，在这里计算了所有cell的布局
    override func prepare() {
        super.prepare()
        cellLayoutInfo.removeAll()
        headLayoutInfo.removeAll()
        footLayoutInfo.removeAll()
        startY = 0
        let viewWidth = collectionView?.frame.width ?? 0
        let itemWidth = (viewWidth - cellDistance*CGFloat(numberOfColumns+1))/CGFloat( numberOfColumns)
        
        let sectionsCount = collectionView?.numberOfSections ?? 0
        
        for section in 0..<sectionsCount {
            let supplementaryViewIndexPath = IndexPath.init(row: 0, section: section)
            
            if headerViewHeight > 0
            {
                let attribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: BGUICollectionElementKindSectionHeader, with: supplementaryViewIndexPath)
                attribute.frame = CGRect.init(x: 0, y: startY, width: collectionView?.frame.width ?? 0, height: CGFloat( headerViewHeight))
                
                self.headLayoutInfo[supplementaryViewIndexPath] = attribute;
                startY = startY + headerViewHeight + topAndBottomDistance
            }
            else
            {
                startY += topAndBottomDistance;
            }
            
            //将Section第一排cell的frame的Y值进行设置
            for i in 0..<numberOfColumns {
                maxYForColumn[i] = self.startY
            }
            
            let rowsCount = collectionView?.numberOfItems(inSection: section) ?? 0
            for row in 0..<rowsCount {
                let cellIndexPath = IndexPath.init(row: row, section: section)
                let attribute = UICollectionViewLayoutAttributes.init(forCellWith: cellIndexPath)
                
                var minY = maxYForColumn[0] ?? 0
                var currentRow = 0
                for i in 0..<numberOfColumns {
                    if Int(maxYForColumn[i] ?? 0) < Int(minY) {
                        minY = maxYForColumn[i] ?? 0
                        currentRow = i;
                    }
                }
                
                let x = self.cellDistance + CGFloat(self.cellDistance + itemWidth) * CGFloat(currentRow);
                
                let cellHeight = delegate?.collectionView(collectionView!, self, heightOfItemAtIndexPath: cellIndexPath, itemWidth) ?? 0
                
                
                attribute.frame = CGRect.init(x: x, y: minY, width: itemWidth, height: cellHeight)
                
                minY = minY + self.cellDistance + cellHeight;
                maxYForColumn[currentRow] = minY;
                cellLayoutInfo[cellIndexPath] = attribute;

                
                if row == (rowsCount - 1)
                {
                    var maxY = maxYForColumn[0] ?? 0
                    for i in 1..<numberOfColumns {
                        if (maxYForColumn[i] ?? 0) > maxY {
                            maxY = maxYForColumn[i] ?? 0
                        }
                    }
                    startY = maxY - cellDistance + topAndBottomDistance;
                }
            }
            
            if footerViewHeight > 0
            {
                let attribute = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: BGUICollectionElementKindSectionFooter, with: supplementaryViewIndexPath)
                
                attribute.frame = CGRect.init(x: 0, y: startY, width: collectionView?.frame.width ?? 0, height: CGFloat( footerViewHeight))
                
                self.footLayoutInfo[supplementaryViewIndexPath] = attribute;
                startY = startY + footerViewHeight
            }
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var allAttributes : Array<UICollectionViewLayoutAttributes> = Array()
        //添加当前屏幕可见的cell的布局
        for (_,value) in cellLayoutInfo {
            if rect.intersects(value.frame)
            {
                allAttributes.append(value)
            }
        }
        
        
        for (_,value) in headLayoutInfo {
            if rect.intersects(value.frame)
            {
                allAttributes.append(value)
            }
        }
        
        for (_,value) in footLayoutInfo {
            if rect.intersects(value.frame)
            {
                allAttributes.append(value)
            }
        }
        
        return allAttributes
        
    }
    
    //插入cell的时候系统会调用改方法
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attribute : UICollectionViewLayoutAttributes = cellLayoutInfo[indexPath] ?? UICollectionViewLayoutAttributes.init()
        return attribute
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        var attribute:UICollectionViewLayoutAttributes
        if elementKind == BGUICollectionElementKindSectionHeader {
            attribute = headLayoutInfo[indexPath] ?? UICollectionViewLayoutAttributes.init()
        }
        else{
            attribute = footLayoutInfo[indexPath] ?? UICollectionViewLayoutAttributes.init()
        }
        
        return attribute
        
        
    }
    
    override var collectionViewContentSize: CGSize{
        get{
            return CGSize.init(width: collectionView?.frame.width ?? 0, height: max(startY, collectionView?.frame.height ?? 0))
        }
    }
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare(forCollectionViewUpdates: updateItems)
        
        var indexPaths : Array<IndexPath> = Array()
        for ele in updateItems
        {
            switch ele.updateAction {
            case .insert:
                indexPaths.append(ele.indexPathAfterUpdate ?? IndexPath.init())
            case .delete:
                indexPaths.append(ele.indexPathBeforeUpdate ?? IndexPath.init())
            case .move:
                break
            default:
                break
            }
        }
        shouldanimationArr = indexPaths
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        if shouldanimationArr.contains(itemIndexPath)
        {
            let attr = cellLayoutInfo[itemIndexPath]!
            attr.transform = CGAffineTransform(scaleX: 0.2, y: 0.2).rotated(by: CGFloat(Double.pi));
            attr.center = CGPoint.init(x: collectionView?.frame.midX ?? 0, y: collectionView?.frame.midY ?? 0)
            attr.alpha = 1;
            
            for i in 0  ..< shouldanimationArr.count
            {
                if(shouldanimationArr[i] == itemIndexPath)
                {
                    shouldanimationArr.remove(at: i)
                    break
                }
            }
            
            return attr;

        }
        
        return nil
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if shouldanimationArr.contains(itemIndexPath)
        {
            let attr = cellLayoutInfo[itemIndexPath]!
            attr.transform = CGAffineTransform(scaleX: 2, y: 2).rotated(by: CGFloat(0));
            attr.alpha = 0;
            
            for i in 0  ..< shouldanimationArr.count
            {
                if(shouldanimationArr[i] == itemIndexPath)
                {
                    shouldanimationArr.remove(at: i)
                    break
                }
            }
            
            return attr;
            
        }
        
        return nil
    }
    
    override func finalizeCollectionViewUpdates() {
        self.shouldanimationArr.removeAll()
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let oldBounds = collectionView?.bounds
        if oldBounds?.size == newBounds.size {
            return false
        }
        return true
    }
    
    override func invalidationContext(forInteractivelyMovingItems targetIndexPaths: [IndexPath],
                                      withTargetPosition targetPosition: CGPoint,
                                      previousIndexPaths: [IndexPath],
                                      previousPosition: CGPoint)
        -> UICollectionViewLayoutInvalidationContext
    {
        let context = super.invalidationContext(forInteractivelyMovingItems: targetIndexPaths, withTargetPosition: targetPosition, previousIndexPaths: previousIndexPaths, previousPosition: previousPosition)

        self.delegate?.collectionView(moveItemAtIndexPath: previousIndexPaths[0], toIndexPath: targetIndexPaths[0])
        return context
        
        
    }
    
    override func invalidationContextForEndingInteractiveMovementOfItems(toFinalIndexPaths indexPaths: [IndexPath], previousIndexPaths: [IndexPath], movementCancelled: Bool) -> UICollectionViewLayoutInvalidationContext {
        return super.invalidationContextForEndingInteractiveMovementOfItems(toFinalIndexPaths: indexPaths, previousIndexPaths: previousIndexPaths, movementCancelled: movementCancelled)
    }
    
    
    
}
