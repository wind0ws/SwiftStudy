//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"
//unowned weak 都是为了解决强循环引用的
// 这两个该怎么用呢？ 什么时候用什么呢？
/*
   对于生命周期中可能为nil的用weak(弱引用)
   对于初始化后就不可能为nil的使用unowned(无主引用)
 
 使用情况解析：
    1、两个类的属性都分别引用对方，且属性均是可选型。这种情况适合一方用weak 即可解决问题，
        因为当另一个实例被释放时，对应的属性会被赋值nil
    2、两个类的属性有一方是可选型，另一方是非可选型。 譬如：客户类中有个信用卡的属性，信用卡类中有个客户属性。  客户可能没有信用卡，而信用卡肯定有客户。所以客户类中的信用卡属性应设为可选型，信用卡类中的客户属性设为非可选型。所以信用卡中的客户属性应设为unowned(无主引用)。  
    3、还有一种情况，两个类的属性互相引用对方，且都必须有值，初始化后都不为nil。对于这种情况应使用隐式解析类型和无主引用（unowned）  对于非隐式解析类型的属性应设为unowned
 
 */


//两个都是可选型

class Person {
    let name:String
    
    weak var apartment:Apartment?
    
    init(name:String){
        self.name = name
    }
    
    deinit{
        print("Person \(name) deinit")
    }
    
}

class Apartment {
    let room:String
    var person:Person?
    
    init(room:String){
        self.room = room
    }
    
    deinit{
        print("Apartment \(room) deinit")
    }
}

func testExample1()->Void{
    var p1:Person? = Person(name: "zhangsan")
    var room1:Apartment? = Apartment(room: "A1002")
    p1?.apartment = room1
    room1?.person = p1
    p1 = nil
    room1 = nil
}

//试试去掉weak，你会发现两个实例都无法释放。weak 放在Person的 apartment上 和 放在Apartment上的 person 效果一样
//testExample1()





//一个可选型，一个非可选型

class Customer {
    let name:String
    
    var creditCard:CreditCard?
    
    init(name:String){
        self.name = name
    }
    
    deinit{
        print("Customer \(name) deinit")
    }
    
}

class CreditCard {
    let cardNumber:UInt64
    unowned let customer:Customer
    
    init(cardNumber:UInt64,customer:Customer){
        self.cardNumber = cardNumber
        self.customer = customer
    }
    
    deinit{
        print("CreditCard \(cardNumber) deinit")
        //注意在这里访问unowned变量要注意，如果已经被释放，在这里访问他会触发异常的，
    }
}

func testExample2() ->Void{
    var customer:Customer? = Customer(name: "ZhangSan")
    var creditCard:CreditCard? = CreditCard(cardNumber: 1234_5678_9012_3456, customer: customer!)
    customer!.creditCard = creditCard!
    customer = nil
    creditCard = nil
}

//testExample2()


//两个初始化后都有值，且不为nil

class Country {
    let name:String
    var capital:City!  //隐式解析
    init(country:String,capital:String){
        self.name = country
        self.capital = City(name: capital, country: self)
    }
    deinit{
        print("Country \(name) deinit")
    }
    
}
class City {
    let name:String
    unowned let country:Country  //无主引用
    init(name:String,country:Country){
        self.name = name
        self.country = country
    }
    deinit{
        print("City \(name) deinit")
    }
}

func testExample3() -> Void {
    var country:Country? = Country(country: "China", capital: "BeiJing")
    print("\(country)")
    country = nil
}
//testExample3()


/**
 
 闭包 引起的强循环引用
 
 循环强引用发生在当一个闭包赋值给一个属性时，而且这个闭包体里又引用了自身的实例（比如在闭包体里又引用了自身的属性或自身的方法）。
 
 究其原因，闭包和类 类似，都是引用类型。
 
 Swift 提供了一种优雅的方法来解决这个问题,称之为闭包捕获列表(closuer capture list)
 
 在定义闭包时同时定义捕获列表作为闭包的一部分，通过这种方式可以解决闭包和类实例之间的循环强引用。
 捕获列表定义了闭包体内捕获一个或者多个引用类型的规则。
 跟解决两个类实例间的循环强引用一样，声明每个捕获的引用为弱引用或无主引用，而不是强引用。应当根据代码关系来决定使用弱引用还是无主引用。
 
 lazy var someClosure: (Int, String) -> String = {
 [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
 // closure body goes here
 }

 如果闭包没有指明参数列表或者返回类型,即它们会通过上下文推断,那么可以把捕获列表和关键字 in 放在闭包 最开始的地方:
 lazy var someClosure: Void -> String = {
 [unowned self, weak delegate = self.delegate!] in
 // closure body goes here
 }
 
 如果闭包体里的引用同时销毁或者引用永远不为nil，那么设为unowned无主引用  如果可能为nil，那么设成weak弱引用
 
 注意:
 如果被捕获的引用绝对不会变为nil，应该用无主引用，而不是弱引用。
 
 **/

protocol MyProtocol : class{
    func doSomething()->String
}


class HtmlElement:MyProtocol{
    let name:String
    let text:String?
    weak var delegate:MyProtocol!
    
    var numberToString: (number:Int) -> String = {
        (number:Int)->String in return "\(number)"
    }
    //这里必须加lazy关键词 因为闭包访问self了。如果不加lazy，在闭包创建的时候，self还没有创建。
    lazy var asHtml: Void -> String = {
        //注意:
        //虽然闭包多次使用了 self ,它只捕获 HTMLElement 实例的一个强引用。
        //注意: Swift 有如下要求:只要在闭包内使用 self 的成员,就要用 self.someProperty 或者 self.someMethod()  (而不只是 someProperty 或 someMethod )。这提醒你可能会一不小心就捕获了 self
        [unowned self ] in
        if let text = self.text{
            return "\(self.name) \(text)  \(self.delegate!.doSomething())"
        }else{
            return "\(self.name) text is nil"
        }
        
    }
    
    func doSomething() -> String {
        return "DoSomething OK"
    }
    
    init(name:String,text:String? = nil){
        self.name = name
        self.text = text
        self.delegate = self
    }
    
    deinit{
        print("HtmlElement \(name) deinit")
    }
}

class HtmlDom{
    let name:String
    init(name:String){
        self.name = name
    }
    
    func description() -> String {
        return "HtmlDom: \(name) "
    }
    
    deinit{
        print("HtmlDom \(name) deinit")
    }

}

func testExample4() -> Void {
    let html = HtmlElement(name: "html name",text: " text ")
    let result = html.asHtml()
//    let result = html.numberToString(number: 222)
    print("\(result)")
}
testExample4()
