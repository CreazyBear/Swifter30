//
//  ToDoItem.swift
//  TODO
//
//  Created by 熊伟 on 2017/6/25.
//  Copyright © 2017年 Bear. All rights reserved.
//

import Foundation

class ToDoItem: NSObject {
    var id: String
    var image: String
    var title: String
    var date: Date
    
    init(id: String, image: String, title: String, date: Date) {
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
}
