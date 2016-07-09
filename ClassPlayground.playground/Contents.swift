//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"

/**
 * 类
 * swift中的类有几种属性：存储属性／计算属性／类属性
 *
 */

class Person{
    //存储属性需要赋初值;如果没有在声明的时候赋初值，那么在构造函数必须赋初值
    //对于有lazy修饰的属性 这个表示只有在第一次使用的时候他才初始化.而且lazy相当于执行一个没有参数的闭包。
    var age = 20
    var name:String
    lazy var pet:String = {
        return "Dog"
    }()
    
    init(name:String){
        self.name = name
    }
    
    func sleep() -> String {
        return "\(name) is \(age) years old,and has a pet which name is \(pet)"
    }
    
    
}

