//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"
/**
 * Swfit中的可空类型本质上是Optional型
 * 有值时相当于 Optional.SomeValue
 * 无值时(也就是nil的时候)相当于 Optional.None
 */

enum Month : Int {
    case January=1,Febuary,March,April,May,June,July,Arguest,September,October,December
}

func testEnum() -> Void {
    var month = Month.init(rawValue: 5)  //可选型
//    var month:Month? = Month.init(rawValue: 5)
    print("\(month)")
    // 此时这个month就是可空型
    // 类似 let month:Month? = Month.init(rawValue: 5)
    month = nil  //这里转换为nil时就会解包失败
    print("\(month)")
    if let month = month {  //if let 解包语法
        print("解包成功。当前月份是\(month)")
    }else{
        print("month 解包失败")
    }
}

//testEnum()

func testOptional() -> Void {
    var month:Optional<Month> = nil
    print("\(month)")
    month = Optional.Some(Month.December)
    print("\(month)")
    month = Optional.None
    print("\(month)")
    month = Month.Arguest
    print("\(month)")
}


//testOptional()