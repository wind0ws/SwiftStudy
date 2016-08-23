//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"

/*
 协议规定了一个蓝图，规定一个用来实现某些动作或功能所需要的方法和属性。
 
 （Swift的协议相当于Java的interface接口，但是比interface更强大，支持属性，构造器，静态方法等更为复杂的限制条件）
 
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
 
 协议中的通常用var来声明变量属性,在类型声明后加上 { set get } 来表示属性是可读可写的,只读属性则用 { get } 来表示。
 
 protocol SomeProtocol {
    var mustBeSettable : Int { get set }
    var doesNotNeedToBeSettable: Int { get }
 }
 
 在协议中定义 类属性(type property)时,总是使用 static 关键字作为前缀。
 当协议的遵循者是类时,可以使用 class 或 static 关键字来声明类属性。其它遵循者应用static，只是类比较特殊罢了
 protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
 }
 
 */
protocol FullNamed{
    //这个FullNamed的协议对遵循者给了个要求，必须有个静态的 tag 属性，且必须提供get. （至于你提不提供它就不要求了）
    static var tag:String { get }
    
    //这个对遵循者提了个要求，必须提供个实例属性 fullName ,且需要提供 get set 方法
    var fullName:String {get set}
    
}

struct Person:FullNamed {
    
    var fullName: String
    static var tag: String {
        return "Person"
    }
}

/*
 
 对方法的规定
 
 可以让遵循者必须实现指定的方法。定义同写普通方法函数没什么区别，只是不需要写大括号和方法体（废话，当然让遵循者去实现啦。。。）
 可以在协议中定义可变参数方法，但参数不能提供默认值。
 正如对属性的规定中所说的,在协议中定义类方法的时候,总是使用 static 关键字作为前缀。
 当协议的遵循者是 类 的时候,你可以在类的实现中使用 static 或者 class  来实现类方法:
 protocol SomeProtocol {
    static func someTypeMethod()
 }
 
 */

protocol RandomGenerator{
    func random() -> Int
    
    static func printDescription() -> Void
}

class MyRandomGenerator:RandomGenerator {
    
    var base = 999_999
    
    func random() -> Int {
        return base % 2
    }
    //虽然协议定义的是 static func 但是由于遵循者也就是本类是class，所以可以用 class func（当然用static func 更不会错）
    class func printDescription() {
        print("MyRandomGenerator")
    }
}

/*
 
 总结：
    protocol 静态属性方法，用关键字 static
 
*/



/*
 对 mutating 方法的规定
 
 有时需要在方法中改变它的实例。例如,值类型(结构体,枚举)的实例方法中,
 将 mutating 关键字作为函数的前缀,写在 func 之前,表示可以在该方法中修改它所属的实例及其实例属性的值。
 
 如果你在协议中定义了一个方法旨在改变遵循该协议的实例,那么在协议定义时需要在方法前加 mutating 关键字。这使得结构和枚举遵循协议并满足此方法要求。
 */

protocol Toggoleable {
    mutating func toggle() -> Void
}

enum OnOffSwitch:Int, Toggoleable {
    case Off=0,On
    mutating func toggle() {
        switch self {
        case .On:
            self = .Off
        case .Off:
            self = .On
        //这里复习下，为什么这里不写default了呢，因为switch的case语句将所有的case情况都case到了，不需要default branch了
        }
    }
}

func testToggle() -> Void {
    var lightSwitch = OnOffSwitch.Off
    lightSwitch.toggle()
    print("\(lightSwitch)")
}

//testToggle()

/*
 
 协议对构造器的约束
 
 protocol SomeProtocol {
    //子类必须实现这个构造器
    init(someParameter: Int)
 }
 
 对可失败构造器的约束
 
 如果在协议中定义一个可失败构造器,则在遵循该协议的类型中必须添加同名同参数的 可失败构造器 或 非可失败构造器。
 如果在协议中定义一个非可失败构造器,则在遵循该协议的类型中必须添加同名同参数的 非可失败构造器 或 隐式解析类型的可失败构造器( init! )。
 
 
 协议构造器在类中的实现：
 
 你可以在遵循该协议的类中实现构造器,并指定其为类的指定构造器(designated initializer)或者便利构造 器(convenience initializer)。
 在这两种情况下,你都必须给构造器实现标上"required"修饰符 。
 使用 required 修饰符可以保证:所有的遵循该协议的子类,同样能为构造器规定提供一个显式的实现或继承实现。（通俗点就睡告诉这个类的子类也必须实现这个构造器）
    注意：如果类已经被标记为 final ,那么不需要在协议构造器的实现中使用 required 修饰符。因为final类不能有子类。
 
 class SomeClass: SomeProtocol {
    required init(someParameter: Int) {
        //构造器实现
    }
 }
 
 
 
 */

protocol SomeProtocol {
    init()
    init(inout age:Int)
    init?(name:String)
}

class SomeSuperClass {
    init() {
        // 构造器的实现 
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {
    var name:String
    var age:Int
    
    
    // 因为遵循协议,需要加上"required"; 因为继承自父类,需要加上"override"
    required override init() {
        // 构造器实现 
        self.name = "NoName"
        self.age = 0
    }
    
    required init?(name: String) {
        guard !name.isEmpty else{
            return nil
        }
        self.name = name
        self.age = 0
    }
    
    /*
     对于SomeProtocol中的可失败构造器，也可以实现成非可失败构造器，就像下面这样
     
     required init(name: String) {
        self.name = name
     }
     
     */
    
    //这里虽然协议规定的是 不可失败 构造器，但是遵循者可以用 隐士解析构造器（init!）来实现。
    required init!(inout age: Int) {
        
        if age < 0 {
            age = 0
        }
        self.name = "NoName"
        self.age = age
    }

}


/*
 协议类型
 
 虽然协议本身不实现任何功能，但是协议仍然可以当作 类型 来使用。
 
 协议可以像其他普通类型一样使用,使用场景:
 • 作为函数、方法或构造器中的 参数类型 或 返回值 类型
 • 作为常量、变量或属性的类型
 • 作为数组、字典或其他容器中的元素类型
 注意 协议是一种类型,因此协议类型的名称应与其他类型(Int,Double,String)的写法相同,使用大写字母开头的 驼峰式 写法
 
 */


/*
 
 委托(代理)模式
 委托是一种设计模式,它允许 类 或 结构体 将一些需要它们负责的功能交由(或委托) 给其他的类型的实例。
 委托模式的实现很简单: 定义协议来封装那些需要被委托的函数和方法,使其 遵循者 拥有这些被委托的函数和方法。
 委托模式可以用来响应特定的动作或接收外部数据源提供的数据,而无需要知道外部数据源的类型信息。
 
 */

class Dice { //掷骰子
    let sides: Int //骰子有几面
    let generator: MyRandomGenerator //生成的随机数
    init(sides: Int, generator: MyRandomGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return (generator.random() * sides) + 1
    }
}


protocol DiceGame { //掷骰子游戏
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate { //掷骰子游戏委托，可以追踪掷骰子游戏过程。有点类似监听器，通知委托方游戏的状态
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll:Int)
    func gameDidEnd(game: DiceGame)
}

/*
 
 在扩展中添加协议成员.
 
 
 */

protocol TextRepresentable {
    var textualDescription:String { get }
}

extension Dice:TextRepresentable{
    var textualDescription:String{
        return "A \(sides)-side Dice"
    }
    
}

/*
    通过扩展补充协议声明
 
 一个类或结构体或枚举 已经实现了某个协议所需的要求，但是却没有声明这个协议。
 可以通过扩展（空扩展体）来补充协议声明
 
 */

struct Hamster {
    var name:String
    var textualDescription:String{
        return "A hamster named \(name)"
    }
    //可以看出 Hamster 已经 conform（符合）TextRepresentable 协议的要求了，但是却没有声明这个协议，称不上TextRepresentable协议的实现数据类型
}

extension Hamster:TextRepresentable{
    //声明这个空扩展体。无需实现，因为原先的Hamster已经实现过了
}

/*
 
 协议集合
 
 虽然他们的实现不同，但是仍然可以放在一起，因为都属于同一个Protocol数据类型嘛
 
 */

func testProtocols() -> Void {
    let textRepresents:[TextRepresentable] = [
        Hamster(name: "Hamster"),
        Dice(sides: 6, generator: MyRandomGenerator())
    ]
    for item in textRepresents {
        print("\(item.textualDescription)")
    }
}

//testProtocols()

/*
 
 协议能够继承一个或多个其他协议,可以在继承的协议基础上增加新的内容要求。协议的继承语法与类的继承相
 似,多个被继承的协议间用逗号分隔:
 protocol InheritingProtocol: SomeProtocol, AnotherProtocol { 
    // 协议定义
 }
 
 */

protocol PrettyTextRepresentable:TextRepresentable {
    var prettyTextualDescription:String { get set }
    //现在 PrettyTextRepresentable 协议定义了两个属性，一个是自己的prettyTextualDescription，还有个是继承的textualDescription
}


/*
 
 类专属协议
 
 你可以在协议的继承列表中,通过添加 class 关键字,限制协议只能适配到类(class)类型。
 (结构体或枚举不能 遵循该协议)。该 class 关键字必须是第一个出现在协议的继承列表中,其后,才是其他继承协议。
 
 注意 当协议想要定义的行为,要求(或假设)它的遵循类型必须是引用语义而非值语义时,应该采用类专属协议。
    关于引用语义,值语义的更多内容,请查看结构体和枚举是值类型 和 类是引用类型 。
 
 */

protocol SomeClassOnylProtocol:class,TextRepresentable {
    // 这个协议只能被 class 所实现，枚举和结构体实现这个协议会报错
}

/*
 
 协议合成
 有时候需要同时遵循多个协议。你可以将多个协议采用 protocol<SomeProtocol, AnotherProtocol> 这样的格式进行组合,
 称为 协议合成(protocol composition) 。你可以在 < A,B,C > 中罗列任意多个你想要遵循的协议,以逗号分隔。
 
 注意
 协议合成 并不会生成一个新协议类型,而是将多个协议合成为一个临时的协议,超出范围后立即失效。
 
 */

protocol Named {
    var name:String{ get }
}

protocol Aged {
    var age:Int { get }
}

struct Man:Named,Aged {
    var name:String
    var age:Int
}

func testProtocolComposition(celebrator:protocol<Named,Aged>) -> Void {
    print("\(celebrator.name) \(celebrator.age)")
}

//testProtocolComposition(Man(name: "ZhangSan", age: 18))

/*
 
 检查协议一致性
 
 通过 is as? as! 来检查某个类型是否符合某个协议
 
 */

func testProtocolIsAs() -> Void {
    let textRepresents:[Any] = [
        Hamster(name: "Hamster"),
        Dice(sides: 6, generator: MyRandomGenerator()),
        100,
        "Hello"
    ]
    for item in textRepresents {
        switch item {
        case let str as String:
            print("This is string : \(str)")
        case let textRepresentable as TextRepresentable:
            print("\(textRepresentable.textualDescription)")
        default:
            print("Unknow: \(item)")
        }
    }
    
}

//testProtocolIsAs()

/*
 对可选协议的规定
 
 协议可以含有可选成员,其 遵循者 可以选择是否实现这些成员。在协议中使用  optional 关键字作为前缀来定义可选成员。
 当需要使用可选规定的方法或者属性时,他的类型自动会变成可选的。比如,一个定义为 (Int)->String
 的方法变成 ((Int)->String)?   需要注意的是整个函数定义包裹在可选中,而不是放在函数的返回值后面。
 
 
 注意
 可选协议只能在含有 @objc 前缀的协议中生效。 这个前缀表示协议将暴露给Objective-C代码,
 即使你不打算和Objective-C有什么交互,如果你想要指明协议包含可选属性,那么还是要加上  @obj 前缀。 
 还需要注意的是,  @objc 的协议只能由继承自 Objective-C 类的类或者其他的 @objc 类来遵循。
 它也不能被结构体和枚举遵循.
 
 */

@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}

@objc class Counter:NSObject {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement{
            count += amount
        } }
}

/*
 协议扩展
 
 使用扩展协议的方式可以为遵循者提供方法或属性的实现。
 通过这种方式,可以让你无需在每个遵循者中都实现一次,无需使用全局函数,你可以通过扩展协议的方式进行定义。

 注意
 通过扩展协议提供的协议实现和可选协议规定有区别。虽然协议遵循者无需自己实现,通过扩展提供的默认实现,可以不用可选链调用。
 
 */

extension RandomGenerator{
    func randomBool() -> Bool {
        return random() > 100
    }
    //这样每个实现RandomGenerator 的遵循者都有个默认randomBool()的实现
}

class AnotherRandomGenerator:RandomGenerator{
    let base = 10000_0000
    
    func random() -> Int {
        return base % 9
    }
    //这里重写了扩展RandomGenerator的默认实现
    func randomBool() -> Bool {
        return random() < 20
    }
    
    static func printDescription() {
        print("AnotherRandomGenerator")
    }
}

/*
 
 为协议扩展添加限制条件
 
 在扩展协议的时候,可以指定一些限制,只有满足这些限制的协议遵循者,才能获得协议扩展提供的属性和方法。
 这些限制写在协议名之后,使用 where 关键字来描述限制情况。
 */

extension CollectionType where Generator.Element : TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joinWithSeparator(", ") + "]"
    }
}

func testProtocolWhere() -> Void {
    let murrayTheHamster = Hamster(name: "Murray")
    let morganTheHamster = Hamster(name: "Morgan")
    let mauriceTheHamster = Hamster(name: "Maurice")
    let hamsters = [murrayTheHamster, morganTheHamster, mauriceTheHamster]
    //因为数组Array遵循CollectionType协议，而数组元素又遵循 TextRepresentable 协议，所以可以调用TextRepresentable协议方法／属性
    print("\(hamsters.textualDescription)")
}