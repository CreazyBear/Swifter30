//
//  clearMyProject.swift
//  CATClearProjectTool
//
//  Created by Bear on 2017/5/10.
//  Copyright © 2017年 catch. All rights reserved.
//

import Foundation

class FindUnUsedClass {
    
    var path:String = ""
    var _pbxprojPath:String = ""
    var _objects:NSDictionary = NSMutableDictionary.init()
    var _projectDir:String = ""
    var _allClasses:NSMutableDictionary = NSMutableDictionary.init()
    var _usedClasses:NSMutableDictionary = NSMutableDictionary.init()
    var _unUsedClasses:NSMutableDictionary = NSMutableDictionary.init()
    
    func startSearchWithXcodeprojFilePath(path:String) {
        guard path.characters.count>0 , path.hasSuffix(".xcodeproj") else {
            print("please input correct xcodeproj path!")
            return;
        }
        
        _pbxprojPath = NSString.init(string: path).strings(byAppendingPaths: ["project.pbxproj"])[0]
        
        let pbxprojDic = NSDictionary(contentsOfFile: _pbxprojPath)
        guard pbxprojDic != nil else {
            print(path)
            print("can not get the content of project file")
            return
        }
        
        _objects = pbxprojDic?.object(forKey: "objects") as! NSDictionary
        let rootObjectUuid = pbxprojDic?.object(forKey: "rootObject") as! String
        
        
        guard rootObjectUuid.characters.count>0 else {
            print("cann't get the root obj")
            return
        }
        let projectObject:NSDictionary = _objects.object(forKey: rootObjectUuid) as! NSDictionary
        let mainGroupUuid:String = projectObject.object(forKey: "mainGroup") as! String
        let mainGroupDic:NSDictionary = _objects.object(forKey: mainGroupUuid) as! NSDictionary
        
        _projectDir = NSString.init(string: path).deletingLastPathComponent
        self._searchAllClasses(dir: _projectDir, mainGroupDic: mainGroupDic, uuid: mainGroupUuid)
        self._searchUsedClasses(dir: _projectDir, mainGroupDic: mainGroupDic, uuid: mainGroupUuid)
        _unUsedClasses = NSMutableDictionary.init(dictionary: _allClasses)
        for key in _usedClasses.allKeys {
            _unUsedClasses.removeObject(forKey: key)
        }
        
        let sortUnusedClass = _unUsedClasses.allKeys.sorted { (ele1, ele2) -> Bool in
            return String(describing: ele1)<String(describing: ele2)
        }
        
        for key in sortUnusedClass {
            print(key)
        }
        
    }
    
    func _searchAllClasses(dir:String, mainGroupDic:NSDictionary, uuid:String) {
        let children:NSArray? = mainGroupDic.object(forKey: "children") as? NSArray
        let path:String? = mainGroupDic.object(forKey: "path") as? String
        let sourceTree:String = mainGroupDic.object(forKey: "sourceTree") as! String
        var innerDir:String = dir
        
        if path != nil && (path?.characters.count)! > 0
        {
            if NSString.init(string: sourceTree).isEqual(to: "<group>")
            {
                innerDir = NSString.init(string: dir).appendingPathComponent(path!)
            }
            else if NSString.init(string: sourceTree).isEqual(to: "SOURCE_ROOT") {
                innerDir = NSString.init(string: _projectDir).appendingPathComponent(path!)
            }
            
        }
        
        
        if children == nil || children?.count == 0 {
            let pathExtension = NSString.init(string: innerDir).pathExtension
            if NSString.init(string: pathExtension).isEqual(to: "h") ||
                NSString.init(string: pathExtension).isEqual(to: "m") ||
                NSString.init(string: pathExtension).isEqual(to: "mm") ||
                NSString.init(string: pathExtension).isEqual(to: "xib")
            {
                let fileName:String = NSString.init(string: NSString.init(string: innerDir).lastPathComponent).deletingPathExtension
                
                var classInfo:NSMutableDictionary? = _allClasses.object(forKey: fileName) as? NSMutableDictionary
                if (classInfo == nil)
                {
                    classInfo = NSMutableDictionary.init()
                    _allClasses.setValue(classInfo, forKey: fileName)
                    classInfo?.setValue(NSMutableArray.init(), forKey: "paths")
                    classInfo?.setValue(NSMutableArray.init(), forKey: "keys")
                }
                (classInfo?.object(forKey: "paths") as! NSMutableArray).add(innerDir)
                (classInfo?.object(forKey: "keys") as! NSMutableArray).add(uuid)
            }
        }
        else
        {
            for key in children! {
                let childrenDic:NSDictionary = _objects.object(forKey: key) as! NSDictionary
                self._searchAllClasses(dir: innerDir, mainGroupDic: childrenDic, uuid: key as! String)
            }
        }
    }
    
    func _searchUsedClasses(dir:String, mainGroupDic:NSDictionary, uuid:String) {
        let children:NSArray? = mainGroupDic.object(forKey: "children") as? NSArray
        let path:String? = mainGroupDic.object(forKey: "path") as? String
        let sourceTree:String = mainGroupDic.object(forKey: "sourceTree") as! String
        var innerDir:String = dir
        if path != nil && ((path?.characters.count)!>0) {
            if NSString.init(string: sourceTree).isEqual(to: "<group>") {
                innerDir = NSString.init(string: dir).appendingPathComponent(path!)
            }
            else if NSString.init(string: sourceTree).isEqual(to: "SOURCE_ROOT") {
                innerDir = NSString.init(string: _projectDir).appendingPathComponent(path!)
            }
        }
        
        if children == nil || children?.count == 0
        {
            let pathExtension = NSString.init(string: innerDir).pathExtension
            if NSString.init(string: pathExtension).isEqual(to: "h") ||
                NSString.init(string: pathExtension).isEqual(to: "m") ||
                NSString.init(string: pathExtension).isEqual(to: "mm") ||
                NSString.init(string: pathExtension).isEqual(to: "xib")
            {
                self._checkClass(dir: innerDir)
            }
        }
        else
        {
            for key in children! {
                let childrenDic:NSDictionary = _objects.object(forKey: key) as! NSDictionary
                self._searchUsedClasses(dir: innerDir, mainGroupDic: childrenDic, uuid: key as! String)
            }
            
        }
    }
    
    func _checkClass(dir:String) {
        
        let mFileName = NSString.init(string: NSString.init(string: dir).lastPathComponent).deletingPathExtension
        let contentFile = try? String.init(contentsOfFile: dir, encoding: String.Encoding.utf8)
        guard contentFile != nil , contentFile!.characters.count > 0 else {
            print("Can't find file \(mFileName) or this file is empty")
            return;
        }
        
        let regularStr = "\"(\\\\\"|[^\"^\\s]|[\\r\\n])+\""
        let regex = try! NSRegularExpression.init(pattern: regularStr, options: .caseInsensitive)
        let matches:NSArray = regex.matches(in: contentFile!, options: .reportProgress, range: NSMakeRange(0, contentFile!.characters.count)) as NSArray
        
        for match in matches {
            let ele = match as! NSTextCheckingResult
            var range = ele.range
            range.location += 1
            range.length -= 2
            let subStr = NSString.init(string: contentFile!).substring(with: range)
            let fileName = NSString.init(string: subStr).deletingPathExtension
            if NSString.init(string: fileName).isEqual(to: mFileName) {
                continue
            }
            let usedClass = _allClasses.object(forKey: fileName)
            _usedClasses.setValue(usedClass, forKey: fileName)
            
        }
        
    }
    
    
}






























