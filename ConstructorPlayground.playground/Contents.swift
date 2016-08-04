//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"

/*
 两段式构造过程
 Swift 中类的构造过程包含两个阶段。
 第一个阶段,每个存储型属性通过引入它们的类的构造器来设置初始值。当每一个存储型属性值被确定后,
 第二阶段开始,它给每个类一次机会在新实例准备使用之前进一步定制它们的存储型属性。
 
 两段式构造过程可以防止属性值在初始化之前被访问;也可以防止属性被另外一个构造器意外地赋予不同的值。
 */

/*
 Swift 编译器将执行 4 种有效的安全检查,以确保两段式构造过程能顺利完成:
 安全检查 1 指定构造器必须保证它所在类引入的所有属性都必须先初始化完成,之后才能将其它构造任务向上代理给父类中 的构造器。
 如上所述,一个对象的内存只有在其所有存储型属性确定之后才能完全初始化。为了满足这一规则,指定构造器必须保证它所在类引入的属性在它往上代理之前先完成初始化。
 安全检查 2 指定构造器必须先向上代理调用父类构造器,然后再为继承的属性设置新值。如果没这么做,指定构造器赋予的 新值将被父类中的构造器所覆盖。
 安全检查 3 便利构造器必须先代理调用同一类中的其它构造器,然后再为任意属性赋新值。如果没这么做,便利构造器赋予的新值将被同一类中其它指定构造器所覆盖。
 安全检查 4 构造器在第一阶段构造完成之前,不能调用任何实例方法、不能读取任何实例属性的值, self 的值不能被引用。
 类实例在第一阶段结束以前并不是完全有效,仅能访问属性和调用方法,一旦完成第一阶段,该实例才会声明为有效实例。
 */

/*
 自动构造器的继承
 规则 1 如果子类没有定义任何指定构造器,它将自动继承所有父类的指定构造器。
 规则 2 如果子类提供了所有父类指定构造器的实现--不管是通过规则1继承过来的,还是通过自定义实现的--它将自动继承所有父类的便利构造器。
 */


class Food {
    var name:String
    init(name:String){
        self.name = name
    }
    /**
     便利构造器
     必须先调用本类的指定构造器（或便利构造器），然后才能为任意属性赋新值
     */
    convenience init(){
        self.init(name:"[UnNamed]")
        // self.xxx = xxx
    }
    
}


class RecipeIngredient: Food {
    var quantity:Int
    /*
      必须先初始化本类中的属性后才能向上代理（调用）父类(指定构造器)构造器
     */
    init(name:String,quantity:Int){
        self.quantity = quantity
        //        super.init() //错误，不能调用父类便利构造器
        super.init(name: name)

    }
    
    /*
     便利构造器。
     正常情况下是不需要加override，只不过这里便利构造器与父类的指定构造器方法签名一致，所以需要override
     */
    convenience override init(name:String){
        self.init(name:name,quantity: 1)
    }
    
    convenience init(quantity:Int){
        //顺序不能反。要先调本类的指定构造器或便利构造器，然后才能给属性赋新值。
        self.init(name:"Apple")
        self.quantity = quantity
    }
    
    /*
     由于本类的指定构造器已经实现了（向上代理了）父类的所有指定构造器，所以根据构造器继承规则二，父类的便利构造器也会被继承 
     所以可以这样创建本类的实例  let receipe ＝ RecipeIngredient()
     */
    
}

class ShopingListItem: RecipeIngredient {
    
    /*
     ShoppingListItem 没有定义构造器来为 purchased 提供初始化值,这是因为任何添加到购物单的项的初始状态总是未购买。
     对于默认值不需要在构造器中进行赋新值。
     这里由于没有实现自己的指定构造器，所以会继承 RecipeIngredient 中的所有指定构造器。（构造器继承规则一）
     由于实现了（继承的）父类的所有指定构造器，所以在这里也会继承父类的所有便利构造器。（构造器继承规则二）
     */
    var isPurchased = false
    var discription:String{
        get{
            return "name:\(name) quantity:\(quantity) isPurchased:\(isPurchased)"
        }
    }
}

/*
 总结：指定构造器 先给本类新增的属性赋值。如果属性有默认值，建议在声明的时候就写上默认值。
    然后在构造结束前向上调用父类的指定构造器（父类便利构造器是不允许子类调用的）！
    便利构造器 必须先调用本类的指定构造器或便利构造器。然后才能给属性赋任意新值！
    如果子类的构造器（不管指定还是便利的）和父类的指定或便利构造器方法签名一致，那么就必须在子类的指定或便利构造器上加override进行标示！
 */




func test() -> Void {
    let receipe = RecipeIngredient(quantity: 22)
    print("\(receipe.name) \(receipe.quantity)")
    var breakfastList = [
        ShopingListItem(),
        ShopingListItem(name: "Milk"),
        ShopingListItem(quantity: 3),
        ShopingListItem(name: "Bread", quantity: 2)
    ]
    breakfastList[0].name = "Orange"
    breakfastList[0].quantity = 1
    breakfastList[0].isPurchased = true
    for item in breakfastList {
        print("\(item.discription)")
    }
}
//test()

/*
 可失败构造器
 如果一个类、结构体或枚举类型的对象,在构造自身的过程中有可能失败,则为其定义一个可失败构造器,是非
 常有用的。这里所指的“失败”是指,如给构造器传入无效的参数值,或缺少某种所需的外部资源,又或是不满
 足某种必要的条件等。
 就是 init?() 这样子。
 
 
 注意: 可失败构造器的参数名和参数类型,不能与其它非可失败构造器的参数名,及其类型相同。
 
 可失败构造器,在构建对象的过程中,创建一个其自身类型为可选类型的对象。你通过 return nil 语句,来表明可失败构造器在何种情况下“失败”。
 
 注意: 严格来说,构造器都不支持返回值。因为构造器本身的作用,只是为了能确保对象自身能被正确构建。所以即使你在表明可失败构造器,失败的这种情况下,用到了 return nil 。也不要在表明可失败构造器成功的这种情况下,使用关键字 return
 
 值类型(如结构体或枚举类型)的可失败构造器,对何时何地触发构造失败这个行为没有任何的限制。可以在自身属性初始化（赋新值）完成之前触发。
 而类必须在类属性全部初始化后才可以触发构造失败的行为！
 
 */

enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol:Character){
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

/*
 上面的例子可以重写成这样：  （带原始值的枚举类型，它的构造器就是可失败构造器）
 enum TemperatureUnit: Character {
 case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
 }
 */

func testInitFailure() -> Void {
    let tu = TemperatureUnit(symbol: "M")
    if let tu = tu {
        print("\(tu)")
    }else{
        print("tu is nil")
    }
}

class Product {
    let name:String!
    
    init?(name:String){
        //这里的顺序不能反。必须等到类的属性初始化完成后才能触发构造失败
        self.name = name
        if name.isEmpty {
            return nil
        }
    }
    
    func test() -> Void {
        /*
            对于Swift ？ ！的区别.
         一句话总结：都是Optional类型的，只是声明的时候加!表示默认解包  相当于在每个操作后面加了!  而?就是常规的写法，每个操作都需要在后面加?或!解包
         本例中，构造器构造完成可以确定name肯定不是nil的，所以设置成默认解包
         可能你会问，那为什么不设置成String的，还不用解包了呢。 对，但是后期代码中你没法给name设置成nil了啊，因为name已经被你设成非空类型了
         如果有不明白的，请查阅：http://www.jianshu.com/p/4ad6d30ec534
         */
        let length = name.characters.count
        let captital = name?.capitalizedString
        print("\(length) \(captital)")
    }
}

struct Animal {
    var areaName:String
    init?(areaName:String){
        //结构体（值类型）就可以在构造器任何地方触发构造失败的行为而无需等属性初始化完毕
        //但是调用父类必须等属性初始化完毕才可向上调用
        if areaName.isEmpty {
            return nil
        }
        self.areaName = areaName
    }
    
}


/**
 构造失败的传递
 可失败构造器允许在同一类,结构体和枚举中横向或向上代理其他的可失败构造器或非可失败构造器。
 在触发构建失败行为前，最好先向上或横向调用其它构造器。其它构造器构造失败则不会继续执行下面的构造。
 */

class CarItem:Product{
    var quantity:Int!
    
    init?(name: String,quantity: Int) {
        self.quantity = quantity
        //先向上代理父类构造器或先判断自身条件均可
        if self.quantity < 1 {
            return nil
        }
        super.init(name: name)
    }
    
    
}

func testCarItem() -> Void {
    let carItem = CarItem(name: "", quantity: 1)
    if let carItem = carItem {
        print("OK\(carItem)")
    }else{
        print("Init failure")
    }
}

//testCarItem()

/**
 
 重写可失败构造器
 
 子类可失败构造器可重写父类可失败构造器。子类非可失败构造器也可以重写父类可失败构造器。
 
 注意当你用一个子类的非可失败构造器重写了一个父类的可失败构造器时,子类的构造器将不再能向上代理父类
 的可失败构造器。一个非可失败的构造器永远也不能代理调用一个可失败构造器。
 
 可以用非可失败构造器重写一个可失败构造器，只是不能向上代理这个可失败构造器了。
 但是一个可失败构造器绝对不能重写一个非可失败构造器（这个就类似于 父亲本类不会失败，结果儿子重写他说他失败了。这个是不允许的）

 */

class Document {
    var name:String?
    
    init(){
    }

    init?(name:String){
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
    
}

class AutomaticallyNamedDocument: Document {
    var quantity:Int!
    override init(){
        quantity = 1
        super.init()
    }
    
    override init(name: String) {
        quantity = 1
        //不能调父类的可失败构造器了。因为重写后的构造器是非失败的
        super.init()
    }
    
    init(name: String,quantity: Int) {
        self.quantity = 1
        super.init()
        
    }

}


class Father {
    var address:String?
    let name:String!
    init?(name:String){
        self.name = name
        if self.name.isEmpty {
            return nil
        }
    }
    
    init(name:String,address:String?){
        self.name = name
        self.address = address
    }
    
    
    var description:String{
        get{
            return "Name is \(name)"
        }
    }
}

class Son:Father {
    let age:Int!
    init?(age:Int){
        self.age = age
        if self.age<1 {
            return nil
        }
        super.init(name: "11")
    }
    
    
    override var description: String{
        return "Name is \(name) ,age is \(age)"
    }
}

func testFailureConstructor() -> Void {
    let son = Son(age:20)
    print("\(son?.description)")
}

//testFailureConstructor()
