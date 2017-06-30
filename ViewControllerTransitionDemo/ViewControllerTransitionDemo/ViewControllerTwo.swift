//
//  ViewControllerTwo.swift
//  ViewControllerTransitionDemo
//
//  Created by Bear on 2017/6/29.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class ViewControllerTwo: UIViewController {

    var imageView : UIImageView!
    
    //FIXME: 将UINavigationViewControllerDelegate从VC中拆分出去后，实例的创建必须在这里，不能放到viewDidLoad or viewWillAppear里面。
    //error eg: 在viewDidLoad中添加：navigationController?.delegate = NavigationTransitionManager()是不行的。
    //至于为什么，我表示weak。。。。
    let fuck = NavigationTransitionManager()
    
    let modalTransitionManager = ModalTransitionMananger()
    
    let interactiveTransitionManager = InteractiveTransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加了这行代码后，左滑失效。为啥子呢？尴尬
//        navigationController?.isNavigationBarHidden = true
//        navigationController?.interactivePopGestureRecognizer.enabled = false
        view.backgroundColor = UIColor.gray
        
        imageView = UIImageView.init(image: #imageLiteral(resourceName: "Text"))
        imageView.center = view.center
        view.addSubview(imageView)
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onImageViewTaped))
        imageView.addGestureRecognizer(tapGesture)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        interactiveTransitionManager.panGesture = UIPanGestureRecognizer()
        interactiveTransitionManager.navigationController = navigationController
        navigationController?.delegate = interactiveTransitionManager
    }
    
    @objc
    func onImageViewTaped() {
        //MARK: navigationController auto transition
        //FIXME: 这行代码不要放到viewDidLoad里面，第一次生效后，第二次就尴尬了。可能是因为weak的原因吧。。。
//        navigationController?.delegate = fuck
//        navigationController?.popViewController(animated: true)
        
        //MARK: model transition
//        self.dismiss(animated: true, completion: nil)
        

        navigationController?.popViewController(animated: true)
    }
}
