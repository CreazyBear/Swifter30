找出项目中没有被引用的类文件
eg:

```swift
print("Start searching dev:XXXXX.xcodeproj")
var instance = FindUnUsedClass.init()
instance.startSearchWithXcodeprojFilePath(path: "PATH/TO/THE/PROJECT.xcodeproj")
print("\n\n\n")
```

or:

```swift
let path = NSString.init(string: NSHomeDirectory()).appendingPathComponent(".cocoapods/repos")
let pathKit = Path.init(path)
let tnPaths:Array<Path> = try! pathKit.children()
for key in tnPaths
{
    let repoPath = key.absolute().path    
    if NSString.init(string: repoPath).lastPathComponent.hasPrefix("BG") ||
        NSString.init(string: repoPath).lastPathComponent.hasPrefix("BEAR") ||
        NSString.init(string: repoPath).lastPathComponent.hasPrefix("XW")
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

```