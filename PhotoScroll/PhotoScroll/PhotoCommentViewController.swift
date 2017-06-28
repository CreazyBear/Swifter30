//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Created by Bear on 2017/6/28.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class PhotoCommentViewController: UIViewController {

    public var photoName: String!
    public var photoIndex: Int!
    
    lazy var scrollView: UIScrollView = {
        let view : UIScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64))
        view.backgroundColor = UIColor.white
        view.contentSize = CGSize.init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64)
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    lazy var commontView: UITextView = {
        let view : UITextView = UITextView.init(frame: CGRect.init(x: 50, y: 320, width: UIScreen.main.bounds.width-100, height: 30))
        view.textColor = UIColor.white
        view.font = UIFont.systemFont(ofSize: 14)
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 4
        return view
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(commontView)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let generalTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.generateTap))
        view.addGestureRecognizer(generalTapGesture)
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleImageTapgesture))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageTapGesture)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShowHandler(notify:)),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillHideHandler(notify:)),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
    }
    
    @objc
    func handleImageTapgesture() {
        let zoomVC = ZoomPhotoViewController(phtotoName: self.photoName)
        navigationController?.pushViewController(zoomVC, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imageView.image = UIImage(named: photoName)
    }
    
    @objc
    func keyboardWillHideHandler(notify:Notification) {
        adjustInsetForKeyboard(isShow: false, notification: notify)
    }
    
    @objc
    func keyboardWillShowHandler(notify:Notification) {
        adjustInsetForKeyboard(isShow: true, notification: notify)
    }
    
    
    fileprivate func adjustInsetForKeyboard(isShow: Bool, notification: Notification) {
        guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame = value.cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 20) * (isShow ? 1 : -1)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
        if isShow
        {
            scrollView.contentOffset.y += adjustmentHeight
        }
        else
        {
            scrollView.contentOffset.y = 0
        }
        
    }
    
    @objc
    func generateTap() {
        view.endEditing(true)
    }


}
