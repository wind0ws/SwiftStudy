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

/**
 * 现在我们来学习递归枚举
 * 递归枚举需要在enum关键词前加入indrect来标记这个枚举是递归的
 */


indirect enum ArithmeticExpression {
    //注意： 如果case语句（条件）不在同一行（换行），不需要在case语句后面加逗号！！！ 这个和java的习惯是不同的！！！！
    //只有当 case在同一行，需要用逗号分隔case内容。
    case Number(Int)
    case Add(first:ArithmeticExpression,second:ArithmeticExpression)
    case Multiply(multiplier:ArithmeticExpression,multiplicand:ArithmeticExpression)
}


func evaluate(expression:ArithmeticExpression) -> Int {
    switch expression {
    case let  .Number(number):
        return number
    case let .Add(exp1,exp2):
        return evaluate(exp1) + evaluate(exp2)
    case let .Multiply(exp1,exp2):
        return evaluate(exp1) * evaluate(exp2)
    }
}


func testIndirectEnum() -> Void {
    // (4+5)*2
    let four = ArithmeticExpression.Number(4)
    let five = ArithmeticExpression.Number(5)
    let sum = ArithmeticExpression.Add(first: four, second: five)
    let two = ArithmeticExpression.Number(2)
    let multipy = ArithmeticExpression.Multiply(multiplier: sum, multiplicand: two)
    let result = evaluate(multipy)
    print("\(result)")
}

//testIndirectEnum()