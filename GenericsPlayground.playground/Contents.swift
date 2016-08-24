//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"

func mySwap<T>(inout t1:T,inout _ t2:T){ //这里复习下，参数名称前加个 _ 代表外参名称不用写，也就是调用者无需写出参数名称
    let temp = t1
    t1 = t2
    t2 = temp
}

func testSwap() -> Void {
    var a = 12,b=100
    mySwap(&a, &b)//这里可以看出inout关键字标及的值可以回传给参数。传参类似C语言中的取地址&
    print("\(a)  \(b)")
}

//testSwap()

/*
    用Swift 泛型实现一个栈。
 
 */

struct Statck<T>:Container {
    var items:[T] = [T]()
    mutating func push(item:T) -> Void {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    
//    typealias ItemType = T  //通常是需要的，但是泛型类自己可以推断这里的ItemType就是T，所以这里不用写
    
    var count: Int {
        return items.count
    }
    
    mutating func append(item: T) {
        items.append(item)
    }
    
    subscript(index:Int) -> T {
        return items[index]
    }
    
    
}

extension Statck {
    var topItem:T? {
        return items.isEmpty ? nil : items[items.count-1]
    }
}

func testStack() -> Void {
    var stack = Statck<Int>()
    stack.push(3)
    stack.push(5)
    stack.push(100)
    stack.push(12)
    print("Top Item is :\(stack.topItem!)")
    
    for _ in 0...2 {
        print("Pop: \(stack.pop())")
    }
    
}

//testStack()


/*
 
 类型约束语法
 
 你可以写一个在一个类型参数名后面的类型约束,通过冒号分割,来作为类型参数链的一部分。
 这种作用于泛型函数的类型约束的基础语法如下所示(和泛型类型的语法相同):
 
 func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) { 
    // 这里是函数主体
 }
 
 上面这个假定函数有两个类型参数。第一个类型参数 T ,有一个需要 T 必须是 SomeClass 子类的类型约束;
 第二个类型参数 U ,有一个需要 U 必须遵循 SomeProtocol 协议的类型约束。
 
 */

func findIndex<T:Equatable>(array:[T],valueToFind:T) -> Int? {
    //这里注意下 T 必须是Equatable的，否则 == 不能进行比较。
    guard !array.isEmpty else{
        return nil
    }
    for (index,value) in array.enumerate() { //for 循环还能这样用哦，省的for i 再在里面进行 get了
        if value == valueToFind {
            return index
        }
    }
    return nil
}

func testFindIndex() -> Void {
    if let index = findIndex([1,2,3,4,5], valueToFind: 3){
        print("3 in array index:\(index)")
    }
    if let index = findIndex(["a","b","c"], valueToFind: "e"){
        print("\(index)")
    }else{
        print("e not in array")
    }
}

//testFindIndex()

/*
 
 关联类型(Associated Types)
 当定义一个协议时,有的时候声明一个或多个关联类型作为协议定义的一部分是非常有用的。
 一个关联类型作为 协议 的一部分,给定了类型的一个占位名(或别名)。
 作用于关联类型上实际类型在协议被实现前是不需要指定的。
 关联类型在protocol被指定为 associatedtype 关键字。在实现体中用 typealias 关键字去关联类型
 
 
 */
protocol Container {
    associatedtype ItemType
    mutating func append(item:ItemType)->Void
    var count:Int {get}
    subscript(index:Int)->ItemType {get}
    
}

struct IntStack: Container {
    // IntStack的原始实现
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // 遵循Container协议的实现 
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

/*
 
 遵循协议
 补充协议声明
 */
extension Array:Container{
    //Array已经遵循了Container，所以这里不需要实现任何内容
    //通过这个补充协议声明，你可以将任何一个Array作为Container来使用
}


/*
 
 Where 语句
 限制泛型试用类型，虽然通过 T:B,C也能限制泛型的类型范围，但是有时还需要更高级的限制条件
 
 */

func allItemsMatch<
    C1, C2
    where C1:Container,C2:Container,C1.ItemType == C2.ItemType, C1.ItemType:Equatable >
    (someContainer: C1, anotherContainer: C2) -> Bool {
    
    /*
     这样定义也可以
     func allItemsMatch<
     C1:Container, C2:Container
     where C1.ItemType == C2.ItemType, C1.ItemType:Equatable >
     
     */
    
    // 检查两个Container的元素个数是否相同
    if someContainer.count != anotherContainer.count {
        return false
    }

// 检查两个Container相应位置的元素彼此是否相等 
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
// 如果所有元素检查都相同则返回true 
    return true
}


func testItemsMatch() -> Void {
    let array1 = [1,2,3,4,5]
    var stack = Statck<Int>()
    stack.push(1)
    stack.push(2)
    stack.push(3)
    stack.push(4)
    stack.push(5)
    let isMatch = allItemsMatch(array1, anotherContainer: stack)
    print("All item is match ? \(isMatch)")
    //看到神奇的一幕了吧，Array和Statck居然能一起比较了，因为他们遵循了Container，而这个allItemsMatch方法对参数的要求就是Container
}

//testItemsMatch()

