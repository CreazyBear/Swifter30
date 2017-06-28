//
//  ZoomPhotoViewController.swift
//  PhotoScroll
//
//  Created by Bear on 2017/6/28.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ZoomPhotoViewController: UIViewController {

    var photoName : String
    lazy var scrollView : UIScrollView = {
        let view : UIScrollView = UIScrollView.init(frame: self.view.bounds)
        view.backgroundColor = UIColor.white
        view.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
        view.delegate = self
        view.isMultipleTouchEnabled = true
        return view
    }()
    
    lazy var image : UIImageView = {
        let view : UIImageView = UIImageView.init(frame: self.view.bounds)
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        photoName = ""
        super.init(coder: aDecoder)
    }
    
    init(phtotoName : String) {
        self.photoName = phtotoName
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = photoName
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        scrollView.addSubview(image)
        image.image = UIImage(named: photoName)
        updateMinZoomScale(forSize: view.bounds.size)
        
    }
    
    fileprivate func updateMinZoomScale(forSize size: CGSize) {
        let widthScale = size.width / image.bounds.width
        let heightScale = size.height / image.bounds.height
        let minScale = min(widthScale, heightScale)
        //这里不能少
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 2
        scrollView.zoomScale = minScale
    }
}

extension ZoomPhotoViewController: UIScrollViewDelegate {
    
    /// Tell the delegate that the imageView will be made smaller or bigger.
    ///
    /// - Parameter scrollView: scrollView delegate to current view controller
    /// - Returns: the view is zoomed in and out
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return image
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        //形变后图片保持中心
        image.center = view.center
    }
}

