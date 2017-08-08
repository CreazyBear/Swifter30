//
//  main.swift
//  SwiftCommandProject
//
//  Created by Bear on 2017/3/30.
//  Copyright © 2017年 Bear. All rights reserved.
//

import Foundation

//enum CommandOptions:String {
//    case encode = "-encode"
//    case decode = "-decoce"
//}
//
//
//for ele in CommandLine.arguments {
//    let optEle = CommandOptions.init(rawValue: ele)!
//    switch optEle{
//    case .encode:
//        OpenurlUtils.encode()
//    case .decode:
//        OpenurlUtils.decode()
//    }
//}



//let interpreter = CommandInterpreter()
//
//interpreter.start()
//
//let enterUrl = stdin
//print(enterUrl)
//
//
//
//print(Path.current)

let path = NSString.init(string: NSHomeDirectory()).appendingPathComponent(".cocoapods/repos")
let pathKit = Path.init(path)


let tnPaths:Array<Path> = try! pathKit.children()
for key in tnPaths
{
    let repoPath = key.absolute().path
    
    if NSString.init(string: repoPath).lastPathComponent.hasPrefix("BG")
    {
        for ele in Path.init(repoPath).enumerated()
        {
            let pathEle:String = String.init(describing: ele.element)
            if pathEle.hasSuffix(".xcodeproj")
            {
                print("--------------------------------------------------------------------------")
                print("----Start searching dev: \(pathEle)")
                print("--------------------------------------------------------------------------")
                var instance = FindUnUsedClass.init()
                instance.startSearchWithXcodeprojFilePath(path: pathEle)
                print("\n\n\n")
            }
        }
    }
}
print("------------------End----------------------")




