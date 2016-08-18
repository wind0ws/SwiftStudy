//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"

class Room {
    
    weak var tenement:Person?
    
    let number:String
    
    init(number:String){
        self.number = number
    }
    
    var description:String{
        if let tenement = tenement{
            return "Room number is \(number),tenement is \(tenement.name)"
        }else{
            return "Room number is \(number)"
        }
    }
    
    deinit{
        print("Room \(number) deinit")
    }
}

class Person{
    var room:Room?
    let name:String
    
    init(name:String,room:Room? = nil){
        self.name = name
        self.room = room
    }
    
    var description:String{
        if let room = room{
            return "Person \(name),room is \(room.number)"
        }else{
            return "Person \(name)"
        }
    }
    
    deinit{
        print("Person \(name) deinit")
    }
}


func test() -> Void {
    var zhangSan:Person? = nil
    let room:Room = Room(number: "A201")
    if  (zhangSan?.room = room) != nil{
        print("赋值成功")
    }else{
        print("赋值失败")
    }
    zhangSan = Person(name: "zhangSan")
    //下面两句赋值将会导致强循环引用。
    //想想前面学习的，如果两个都互相强引用，且都是可为nil的，那么在一方属性设为weak弱引用即可
    //如果一个可为nil，另一个不为nil的。那么在不为nil的那个属性设为unowned无主引用
    //如果两个属性初始化后都必须有值，那么一方设为隐士解析，另一方正常的非nil属性。同样在非nil的那个属性设为unowned无主引用
    //闭包里捕获self 的时候，注意释放呦(大部分时候用unowned无主引用self)，[unowned self,weak delegate = self.delegate!] in return "\(self.name)"
    // 自己的总结（2016.8.18 可能不太对）：1、优先给不为nil的属性设置unowned无主引用  2、不为nil（比如self）的用unowned.
    room.tenement = zhangSan
    if  (zhangSan?.room = room) != nil{  //看看这句话：说明Swift的赋值语句也是有返回值的，而且返回的是 Void? ，可以通过判断是否为nil来判断是否赋值成功
        print("赋值成功")
    }else{
        print("赋值失败")
    }
    //到这里注意观察 两个强循环引用有没有释放
}
//test()

/**
 通过可空链式调用,我们可以用下标来对可空值进行读取或写入,并且判断下标调用是否成功。 
 > 注意: 当通过可空链式调用访问可空值的下标的时候,应该将问号放在下标方括号的前面而不是后面。可空链式调用的问号 一般直接跟在可空表达式的后面。
 eg:  zhangSan?.rooms?[0].roomNumber
     zhangSan?.rooms?[0] = Room(number:"A311")
 */

//访问可空类型的下标
func testDictonary(){
    var dicts = ["ZhangSan":[11,22,33],"LiSi":[88,99,100]]
    //字典 dicts["key"] 返回的是可空类型的。
    //注意问号的位置，不能放在dicts后面，因为我们操作的对象是dicts的某个key对象而不是dicts本身（dicts本身也不是Optional类型的）
    dicts["ZhangSan"]?[0] += 1
    dicts["ZhangSan"]?[1] = 123
    dicts["LiSi"]?[1]+=2
    if (dicts["WangWu"]?[11] = 100) == nil {
        print("赋值失败")
    }
    print("\(dicts)")
}

//testDictonary()
