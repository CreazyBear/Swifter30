//
//  BGSelfDefineViewController.swift
//  iMessageDemo
//
//  Created by Bear on 2017/8/7.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit
import Messages

class BGSelfDefineViewController: UIViewController {

    //创建消息并插入
    func handleSendButtonClick(sender:UIButton) {
        //BGConversationManager.shared.appDeleagte这个就是MSMessagesAppViewController的实例。
        if let image = createImageForMessage(), let conversation = BGConversationManager.shared.appDeleagte?.activeConversation {
            //layout还有很多别的属性值可以设置，详细请查看文档
            let layout = MSMessageTemplateLayout()
            layout.image = image
            layout.caption = "Stepper Value"
            
            let message = MSMessage()
            message.layout = layout
            
            message.shouldExpire = true
            message.accessibilityLabel = "accessibilityLabel"
            message.summaryText = "summaryText"
            
            
            guard let components = NSURLComponents(string: "data://") else {
                fatalError("Invalid base url")
            }
            
            let size = URLQueryItem(name: "Size", value: "Large")
            let count = URLQueryItem(name: "Topping_Count", value: "2")
            let cheese = URLQueryItem(name: "Topping_0", value: "Cheese")
            let pepperoni = URLQueryItem(name: "Topping_1", value: "Pepperoni")
            components.queryItems = [size, count, cheese, pepperoni]
            
            guard let url = components.url  else {
                fatalError("Invalid URL components.")
            }
            
            message.url = url
            
            
            
            
            
            
            //收起页面，以展示插入的消息
            BGConversationManager.shared.appDeleagte?.requestPresentationStyle(.compact)
            conversation.insert(message, completionHandler: { (error) in
                print(error ?? "")
            })
            
//    其它的消息类型
//    conversation.insert(<#T##message: MSMessage##MSMessage#>, completionHandler: <#T##((Error?) -> Void)?##((Error?) -> Void)?##(Error?) -> Void#>)   //发送自定义消息
//    conversation.insertText(<#T##text: String##String#>, completionHandler: <#T##((Error?) -> Void)?##((Error?) -> Void)?##(Error?) -> Void#>)     //发送文本消息
//    conversation.insert(<#T##sticker: MSSticker##MSSticker#>, completionHandler: <#T##((Error?) -> Void)?##((Error?) -> Void)?##(Error?) -> Void#>)   //发送sticker消息
//    发送url: 图片，音频，视频的链接，详细使用请查看文档
//   conversation.insertAttachment(<#T##URL: URL##URL#>, withAlternateFilename: <#T##String?#>, completionHandler: <#T##((Error?) -> Void)?##((Error?) -> Void)?##(Error?) -> Void#>)
        }
    }


    //将view转换成图片插入，这不是重点。
    func createImageForMessage() -> UIImage? {
        let background = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        background.backgroundColor = UIColor.white
        
        let label = UILabel(frame: CGRect(x: 75, y: 75, width: 150, height: 150))
        label.font = UIFont.systemFont(ofSize: 56.0)
        label.backgroundColor = UIColor.red
        label.textColor = UIColor.white
        label.text = "1"
        label.textAlignment = .center
        label.layer.cornerRadius = label.frame.size.width/2.0
        label.clipsToBounds = true
        
        background.addSubview(label)
        background.frame.origin = CGPoint(x: view.frame.size.width, y: view.frame.size.height)
        view.addSubview(background)
        
        UIGraphicsBeginImageContextWithOptions(background.frame.size, false, UIScreen.main.scale)
        background.drawHierarchy(in: background.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        background.removeFromSuperview()
        
        return image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Self Define"
        navigationController?.navigationBar.isHidden = false
        
        view.addSubview(sendButton)
        sendButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -25).isActive = true
    }
    
    //在界面止添加一个按键，用来触发消息的生成与插入
    lazy var sendButton : UIButton = {
        let view : UIButton = UIButton()
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 0.5
        view.setTitle("Send", for: .normal)
        view.setTitleColor(UIColor.black, for: .normal)
        view.addTarget(self, action: #selector(handleSendButtonClick(sender:)), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
}
