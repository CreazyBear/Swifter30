//
//  Product.swift
//  PhoneHistory
//
//  Created by 熊伟 on 2017/6/18.
//  Copyright © 2017年 Bear. All rights reserved.
//
import Foundation

class Product {
    var name: String?
    var cellImageName: String?
    var fullscreenImageName: String?
    
    init(name: String, cellImageName: String, fullscreenImageName: String) {
        self.name = name
        self.cellImageName = cellImageName
        self.fullscreenImageName = fullscreenImageName
    }
}
