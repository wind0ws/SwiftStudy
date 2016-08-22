//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"

/*
 协议规定了一个蓝图，规定一个用来实现某些动作或功能所需要的方法和属性。
 
 类／结构体／枚举 都可以 遵循（conform）一个或多个协议。实现了某个协议的我们称作遵循协议
 
 协议语法
 
 protocol SomeProtocol { 
    // 协议内容
 }
 
 实现协议：
 
 struct SomeStructure: FirstProtocol, AnotherProtocol { 
    // 结构体内容
 }
 
 class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol { 
    // 类的内容
 }
 
 
 对协议属性的规定：
 协议可以规定其 遵循者 提供特定名称和类型的 实例属性(instance property) 或 类属性(type property) ,
 而不用指定是 存储型属性(stored property) 还是 计算型属性(calculate property) 。
 此外还必须指明是 只读的 还是 可读可写的。
 
 如果协议规定属性是可读可写的,那么这个属性不能是常量或只读的计算属性。
 如果协议只要求属性是只读的(gettable),那个属性不仅可以是只读的,如果你代码需要的话,也可以是可写的。
 （这里解读一下：如果协议规定 属性有 get ／set (对应上文的可读可写 ) ，那么遵循者也必须实现 get/set .
               如果协议规定 属性 只需要 get （对应上文的只读）就行了，那么你只需要提供get，但是你提供set也不违反它的约束，它的最低要求就是要有get.
                可能还有的人要问，属性只提供set呢，呃，，啊哈哈，你想想一个属性怎么能只提供set，不能提供get的都不能叫属性）
 
 protocol SomeProtocol {
    var mustBeSettable : Int { get set }
    var doesNotNeedToBeSettable: Int { get }
 }
 
 在协议中定义类属性(type property)时,总是使用 static 关键字作为前缀。
 当协议的遵循者是类时,可以使用 class 或 static 关键字来声明类属性
 protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
 }
 
 */
