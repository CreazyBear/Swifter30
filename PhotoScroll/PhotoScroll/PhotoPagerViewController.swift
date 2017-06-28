//
//  PhotoPagerViewController.swift
//  PhotoScroll
//
//  Created by Bear on 2017/6/28.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class PhotoPagerViewController: UIPageViewController {
    
    var photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    var currentIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let viewController = viewPhotoCommentController(index: currentIndex ?? 0)
        {
            let viewControllers = [viewController]
            setViewControllers (
                viewControllers,
                direction: .forward,
                animated: false,
                completion: nil
            )
        }
        
    }
    
    fileprivate func viewPhotoCommentController(index: Int) -> PhotoCommentViewController?
    {
        let page = PhotoCommentViewController()
        page.photoName = photos[index]
        page.photoIndex = index
        return page
    }
    
}

extension PhotoPagerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? PhotoCommentViewController {
            guard let index = viewController.photoIndex, index != 0 else {
                return nil
            }
            return viewPhotoCommentController(index: index - 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewController = viewController as? PhotoCommentViewController {
            guard let index = viewController.photoIndex, index != photos.count - 1 else {
                return nil
            }
            return viewPhotoCommentController(index: index + 1)
        }
        return nil
    }
    
    /// MARK: UIPageControl
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return photos.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex ?? 0
    }
}
