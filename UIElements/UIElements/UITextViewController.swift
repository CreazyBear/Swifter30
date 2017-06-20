//
//  UITextViewController.swift
//  UIElements
//
//  Created by 熊伟 on 2017/6/20.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit

class UITextViewController: UIViewController {

    var text:UITextView = UITextView.init()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.yellow
        self.title = "Text"
        self.text.frame = CGRect.init(x: 10, y: 100, width: UIScreen.main.bounds.width-20, height: 300)
        self.text.backgroundColor = UIColor.white
        self.text.font = UIFont.systemFont(ofSize: 14)
        self.text.textColor = UIColor.black
        self.text.delegate = self
        self.view.addSubview(self.text)
        
        //MARK: 这行代码使得光标从text的左上角开始~
        self.automaticallyAdjustsScrollViewInsets = false
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(resign))
        self.view.addGestureRecognizer(tapGesture)
    }
    @objc
    func resign() {
        self.text.resignFirstResponder()
    }
}




extension  UITextViewController:UITextViewDelegate
{
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        print("--textViewShouldBeginEditing---\(textView.text)")
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        print("--textViewShouldEndEditing---\(textView.text)")
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("--textViewDidBeginEditing---\(textView.text)")
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("--textViewDidEndEditing---\(textView.text)")
        
    }
    func textViewDidChange(_ textView: UITextView) {
        print("--textViewDidChange---\(textView.text)")
    }
    func textViewDidChangeSelection(_ textView: UITextView) {
        print("--textViewDidChangeSelection---\(textView.text)")
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("--replacementText---\(text)")
        return true
    }
}
