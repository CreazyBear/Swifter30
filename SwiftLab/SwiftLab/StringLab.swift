//
//  StringLab.swift
//  SwiftLab
//
//  Created by 熊伟 on 2018/8/26.
//  Copyright © 2018年 Bear. All rights reserved.
//


import Cocoa

// [Swift 4 中的字符串](http://swift.gg/2018/08/09/swift-4-strings/)

class StringLab {
    
    func startTest() {

        let single = "Pok\u{00E9}mon"
        let double = "Poke\u{0301}mon"
        print(single.count)
        print(double.count)
        
        print("两个字符串相等\(single == double)")
        
        
        let nssingle = single as NSString
        print(nssingle.length)
        let nsdouble = double as NSString
        print(nsdouble.length) // → 8
        print(nssingle == nsdouble) // → false
        
        let chars: [Character] = [
            "\u{1ECD}\u{300}",      // ọ́
            "\u{F2}\u{323}",        // ọ́
            "\u{6F}\u{323}\u{300}", // ọ́
            "\u{6F}\u{300}\u{323}"  // ọ́
        ]
        chars.dropFirst().forEach { (ele) in
            print(ele == chars.first)
        }
        
        
        
        
        var greeting = "Hello, world!"
        if let comma = greeting.index(of: ",") {
            print(greeting[..<comma]) // → "Hello"
            greeting.replaceSubrange(comma..., with: " again.")
        }
        print(greeting)
    }
    
    

}



