//: Playground - noun: a place where people can play

// [Swift 4 中的字符串](http://swift.gg/2018/08/09/swift-4-strings/)

import Cocoa

var str = "Hello, playground" as NSString
var str1 = "Hello, playground1" as NSString
//str.compare(str1)


let single = "Pok\u{00E9}mon"
let double = "Poke\u{0301}mon"

single.count
double.count

single == double


let nssingle = single as NSString
nssingle.length // → 7
let nsdouble = double as NSString
nsdouble.length // → 8
nssingle == nsdouble // → false

let chars: [Character] = [
    "\u{1ECD}\u{300}",      // ọ́
    "\u{F2}\u{323}",        // ọ́
    "\u{6F}\u{323}\u{300}", // ọ́
    "\u{6F}\u{300}\u{323}"  // ọ́
]
let allEqual = chars.dropFirst().all(matching: { $0 == chars.first }) // → true
