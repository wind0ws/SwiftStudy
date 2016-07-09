//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"
//print(str)

/**
 
 • 定义属性用于存储值
 • 定义方法用于提供功能
 • 定义附属脚本用于访问值
 • 定义构造器用于生成初始化值
 • 通过扩展以增加默认实现的功能 • 实现协议以提供某种标准功能
 */

struct Resolution {
    //结构体无需（当然也可以定义）定义构造函数，他会自动生成构造函数给调用者
    
    var width:Int
    var height:Int
    
    
}

//结构体是值类型。 cinema是将hd的值拷贝一份过来的
//let hd = Resolution(width: 1920, height: 1080)
//var cinema = hd

// === 恒等于  （引用地址相同）
// !== 恒不等于 （引用地址不同，即使值相同）

/**
 * 存储属性需要赋初值
 */

class VideoMode{
    var resolution: Resolution = Resolution(width: 320,height:  480)
    var interlacesd = false
    var name: String?
    var frameRate: Int = 0
    
}

/**
 * 原始值 （Raw Values）
 * 枚举可以继承其他数据类型
 */
enum ASCIIControlCharacter: Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}

/**
 * 关联值 （Associated Values）
 */
enum Barcode {
    case UPCA(Int,Int,Int,Int)
    case QRCode(content: String)
}

enum Month: Int{
    case January = 1,Feberary,March,April,May,June,July,Arguest,September,October,November,December
}

/*
 *递归枚举
 */
//enum ArithmeticExpression {
//    case Number(Int)
//    indirect case Addition(ArithmeticExpression,ArithmeticExpression)
//    indirect case Multiplication(ArithmeticExpression,ArithmeticExpression)
//}

/**
 * 递归枚举
 * 在枚举类型开头加入 indirect 也是可以的
 */
indirect enum ArithmeticExpression {
    case Number(Int)  //纯数字
    case Addition(ArithmeticExpression,ArithmeticExpression)  //两个表达式相加
    case Multiplication(ArithmeticExpression,ArithmeticExpression)  //两个表达式相乘
}




