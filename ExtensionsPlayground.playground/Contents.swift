//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"
/*
    扩展 Extensions
 不管你激不激动 ，我反正激动了。。。
 扩展是对原有的类、结构体、枚举或者协议进行扩充以添加新功能。
 
 
 可以提供的功能有：
 1. 提供计算属性和静态计算属性
 2. 提供新的构造器
 3. 定义实例方法和类型方法（class func）
 4. 定义下标（subscript 附属脚本）
 5. 使一个已有类型符合某个协议
 6. 定义和使用心得嵌套类型
 
 注意：扩展是对一个类型添加新功能，而不能重写原有的功能
 */

/*
 
 扩展 语法
 
 extension SomeType{
    //在这里添加新功能
 }
 
 extension SomeType:SomeProtocol,AnotherProtocol{
    //在这里编写协议的实现
 }
 
 注意：如果你定义一个扩展向一个已有类型添加了新功能，那么这个新功能对该类型的所有实例都是可用的，哪怕这个类型定义在你的扩展之前定义的。

 */

/*
 扩展构造器
    扩展可以向类添加便利构造器，但是不能添加指定构造器和析构器。指定构造器和析构器必须由原始的类提供。
 但是如果你使用扩展向一个值类型添加一个构造器,在该值类型已经向所有的存储属性提供默认值,
 而且没有定义任何定制构造器(custom initializers)时,你可以在值类型的扩展构造器中调用
 默认构造器(default initiali zers)和逐一成员构造器(memberwise initializers)。
 正如在值类型的构造器代理中描述的,如果你已经把构造器写成值类型原始实现的一部分,上述规则不再适用。
 */

class Person{
    let name:String
    var age:Int
    
    init(name:String,age:Int){
        self.name = name
        self.age = age
    }
    
}

extension Person{
    //错误，扩展不能添加指定构造器
//    init(name:String){
//        self.init(name:name,age: 1)
//    }
    
    //但是可以添加便利构造器
    convenience init(name:String){
        self.init(name:name,age: 18)
    }
    
}

struct Point {
    let x:Double = 0.0,y:Double = 0.0
}

struct Size {
    let width = 0.0 ,height = 0.0
}

struct Rectangle {
    var point = Point()
    var size = Size()
}

extension Rectangle{
    //值类型在没有定义自定义构造器的情况下是可以自定义指定构造器的。在扩展的指定构造器内部可以调用默认构造器和逐一成员构造器（这两个构造器是自动生成的）
    init(center:Point,size:Size){
        self.init(point:center,size: size)
    }
}


/*
 
 扩展方法
 
 可变（mutating）实例扩展方法
 
 */

extension Int{

    func repeatitions(task: (index:Int) -> () ) -> Void {
        //这里插一句   (index:Int) -> ()  同 (index:Int) -> Void 等价. ()等价于Void
        //这里的参数task很明显是个 方法。
        for i in 0..<self {
            task(index: i)
        }
    }
    
    // 可变实例方法，改变了自身(self)就需要加mutating标记
    mutating func square() -> Void {
        self = self * self
    }
    
    subscript(digitIndex:Int) -> Int{ //这个附属脚本的作用是返回Int从右向左数第几个数字的值（从0开始）
        guard digitIndex>0 else{
            print("Error: digitIndex should bigger than zero")
            return -1
        }
        var digitBase = 1
        for _ in 0..<digitIndex{
            digitBase *= 10
        }
        return (self / digitBase)%10
    }
    
    
    //还可以向扩展类型嵌入数据类型
    
    enum Kind {
        case Positive,Negative,Natural
    }
    
    var kind:Kind{
        switch self {
        case 0:
            return .Natural
        case let x where x > 0 :
            return Kind.Positive
        default:
            return .Negative  //可以看到 Kind是可以简写的，因为已知kind是Int.Kind类型
        }
    }
    
    
}

func testIntExtension() -> Void {
    //这里把task放到了方法的后面，用到了结尾闭包
    3.repeatitions(){
        (index) -> Void in
        print("Hello\(index)")
    }
    
    print("12345 digit 3 : \(12345[3])")
    
    
    //注意下 －1 是怎么在占位符中使用的
    print("0 kind is: \(0.kind) \n -1 kind is \( (-1).kind) \n 1 kind is \(1.kind)")
}

//testIntExtension()

