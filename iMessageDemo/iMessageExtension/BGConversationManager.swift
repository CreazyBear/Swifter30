//
//  BGConversationManager.swift
//  iMessageDemo
//
//  Created by Bear on 2017/8/7.
//  Copyright © 2017年 Bear. All rights reserved.
//

import UIKit
import Messages

final class BGConversationManager: NSObject {
    static let shared = BGConversationManager()
    var appDeleagte: MSMessagesAppViewController?
    private override init() {}
}
