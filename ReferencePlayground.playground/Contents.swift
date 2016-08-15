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
    country = nil
}
//testExample3()