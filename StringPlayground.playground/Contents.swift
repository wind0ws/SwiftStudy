//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"

func stringIndex() -> Void {
    let str = "Hello, Swift"
    let startIndex = str.startIndex
    let endIndex = str.endIndex
    let spaceIndex = startIndex.advancedBy(6)
    print("输出位置1的值：\(str[startIndex.successor()])")
    print("字符串长度\(str.characters.count)")
    print("输出空格:\(str[endIndex.advancedBy(-6)])")
    print("输出从空格之后的数据:\(str[spaceIndex.successor()..<endIndex])")
    print("最后一个字符:\(str[endIndex.predecessor()])")
}


func stringRange(str:String) -> Void {
    var str = str
    let hello = "Hello"
    guard str.containsString(hello) && str.characters.count>10 else{
        print("You need put str where has prefix or suffix of \" \(hello) \" and length should bigger than 10")
        return
    }
    let helloRange = str.rangeOfString(hello)
    if let helloRange = helloRange {
        print("找到HelloRange，\(helloRange)")
        str.replaceRange(helloRange, with: "Hi")
        print("See the new string:\(str)")
    }
    str.appendContentsOf("------End-------")
    print("\(str)")
    str.insert("!", atIndex: str.startIndex.advancedBy(2))
    print("在位置2插入了一个感叹号，现在是 \(str)")
    print("删除最后一个字符：\(str.removeAtIndex(str.endIndex.predecessor())) 现在str是：\(str)")
    print("删除最后3个字符：\(str.removeRange(str.endIndex.advancedBy(-3)..<str.endIndex)) 现在str是：\(str)")
    //stringByTrimmingCharactersInSet 只会移除结尾里的指定字符
    let trimmedStr = str.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString:"-"))
    print("Trimed str is :\(trimmedStr) and original str is still \(str)")
    
}

//stringRange("Hello,Swift")