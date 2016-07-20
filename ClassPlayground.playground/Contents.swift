//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"

/**
 * 类
 * swift中的类有几种属性：存储属性／计算属性／类属性
 
 * *** Swift中类和结构体的共同点 ***
 * 定义属性用于存储值
 * 定义方法用于提供功能
 * 定义附属脚本用于访问值
 * 定义构造器用于生成初始化值
 * 通过扩展以增加默认实现的功能
 * 实现协议以提供某种标准功能
 *
 *
 *  ＊＊＊＊ 与结构体相比，类还有下面的附加功能 ＊＊＊＊
 * 继承允许一个类继承另一个类的特征
 * 类型转换允许在运行时检查和解释一个类实例的类型
 * 结构器（deinit）允许一个类实例释放任何其所被分配的资源
 * 引用计数允许对一个类的多次饮用
 *
 
 *        枚举和结构体都是值类型。
 * *****  结构体总是通过被复制的方式在代码中传递，不使用引用计数 *****
 * Integer Float Boolean String Array Dictionary 都是值类型。在底层都是以结构体的形式实现。
 * 特别要注意Array，他是值类型哦（而且仅在数组长度改变的情况下才会拷贝。Apple名曰 数组仅在必要的情况下才进行拷贝操作）
 * String也是值类型哦，这和其他语言的不同
 *
 * 在你每次定义一个新类活着结构体的时候，实际上你是定义了一个新的Swift类型。
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

//所有的结构体都有一个自动生成的成员逐一构造器，用于出事后新结构体实例中成员的属性
//而类没有

struct Resolution {
    var width = 0
    var height:Int = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name:String?
    
}

func getVideoMode() -> VideoMode {
//    var resolution = Resolution(width: 1280, height: 1080)
    
    let videoMode = VideoMode()
    videoMode.frameRate = 60
    videoMode.interlaced = true
    videoMode.name = "Samsung TV"
    //Swift 允许设置结构体属性的子属性
    videoMode.resolution.height = 1024
    videoMode.resolution.width = 1280
    
    return videoMode
}

func test() -> Void {
    let hd = Resolution(width: 1080, height: 1920)
    var cinema = hd
//    hd.height = 1920  //这个通不过，因为hd 是let常量
    cinema.width = 2048 //但是cinema就可以，虽然hd是常量，但是cinema实际上是复制了hd的值
}


/**
 *
 ===恒等于 !==恒不等于
 ==等于 !=不等于
 注意上面四个。
 恒等于 表示两个类类型的常量或变量引用同一个类实例
 恒不等于 表示两个类类型的常量或变量引用的不是同一个类的实例（哪怕他们的值是相等的）
 等于 表示两个实例的值相等或相同 
 不等于 表示两个实例的值不相等
 
 */

/*
 存储属性：简单来说就是存储在特定类活结构体的实例里的一个常量或变量。
            变量存储属性（var）  常量存储属性（let）
 */

struct FixedLengthRange {
    var firstValue:Int
    let length:Int
}
func testFixedLengthRange() -> Void {
    var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
    //该区间表示整数0，1，2
    rangeOfThreeItems.firstValue = 6
    //该区间表示整数6，7，8
    //length在构造函数初始化后就不可变了.且let常量只能初始化一次。要么在声明的时候初始化要么在构造函数初始化！
    
    let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//    rangeOfFourItems.firstValue = 3 //虽然 firsetValue是var，但是因为声明的结构体实例是let常量，所以即使他的属性是变量也是无法再修改它了
    //这种特性是由于结构体（struct）是值类型。当值类型实例被声明为常量时，它的所有属性也就成了常量
    /*
     属于引用类型的类（class）则不一样，把一个引用类型的实例赋给一个常量后，仍然可以修改改实例的常量属性。
        这就像Java里的final，final修饰的实例本身不能改变，但是类的属性可以被设置
    */
    print(rangeOfFourItems)
}

/*
 
    lazy 延迟存储属性是指当第一次被调用的时候才会去计算其初始值的属性。在属性声明前使用lazy来表示一个延迟存储属性
    注意：必须将延迟存储属性声明成变量（var）。因为属性的初始值可能在实例构造完成之后才会得到。
        而常量属性在构造过程完成之前必须要有初始值，因此无法声明成延迟属性。
        如果一个标记为lazy的属性在没用初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一次。
 
 */

class DataImporter{
    //假设这个类是个数据导入类，这个类的初始化会消耗不少的时间。
    var fileName = "data.txt"
    //这是提供数据导入功能
}

class DataManager{
    lazy var importer = DataImporter()
    var data = [String]() //声明一个String类型的空数组
}

func testLazy() -> Void {
    let dataManager = DataManager()
    dataManager.data.append("Some Data")
    dataManager.data.append("Some other data")
    //DataImporter到现在还没有被创建。因为到现在还没访问它
    print("fileName:\(dataManager.importer.fileName)")
    //现在importer被初始化了，因为被访问了。
    
}

/*
    计算属性
    类、结构体和枚举可以定义计算属性
    计算属性不直接存储值。而是提供一个getter 和一个可选的 setter，来间接获取和设置其他属性或变量的值
 
    只读计算属性：只有getter 没有 setter的计算属性就是只读计算属性。只读计算属性不能赋值
 
 */

struct Point {
    var x = 0.0,y = 0.0
}

struct Size {
    var width = 0.0,height = 0.0
}

struct Rect {
    var origin = Point(){
        willSet{
            print("origin current is \(origin),origin will set to newValue \(newValue)")
        }
        didSet{
            print("origin has been set to \(origin),old Value is \(oldValue)")
        }
    }
    var size = Size()
    var center:Point {
        get{
            let centerX = origin.x+(size.width/2)
            let centerY = origin.y+(size.height/2)
            return Point(x: centerX, y: centerY)
        }
//        set(newCenter){
//            origin.x = newCenter.x - (size.width/2)
//            origin.y = newCenter.y - (size.height/2)
//        }
        set{
            origin.x = newValue.x - (size.width/2)
            origin.y = newValue.y - (size.height/2)
        }
    }
}

func testCalculateProperty() -> Void {
    var square = Rect(origin: Point(x: 0.0,y: 0.0),size: Size(width: 10.0,height: 10.0))
    let initialSquareCenter = square.center
    print("initialSquareCenter:\(initialSquareCenter)")
    square.center = Point(x: 20.0, y: 20.0)
    print("current suare center point is \(square.center)")
}

/**
 属性观察器
 属性观察器监控和响应属性值的变化。每次属性被设置值的时候都会调用属性观察器，甚至新的值和现在的值相同的时候也不例外。
 可以为除了 lazy 延迟属性之外的其它属性添加属性观察器，也可以通过重写属性的方式为继承的属性（包括存储盒计算属性）添加属性观察器。
 不需要为非重写的计算属性添加属性观察器，因为可以通过setter直接监控和响应值的变化
 
 willSet 在新的值被设置之前被调用 newValue 新值
 didSet 在新值被设置之后立即调用  oldValue 旧值
 newValue 和 oldValue都是常量，不能更改！
 
 */

class StepCounter {
    var totalSteps:Int = 0{
        willSet(newSteps){
            print("current step is \(totalSteps),will set steps to \(newSteps)")
            /*
            if newSteps<totalSteps {
                print("newSteps can't small than current ")
//                newSteps = totalSteps  //错误：newSteps 是常量
            }*/
        }
        didSet(oldSteps){
            if totalSteps>=oldSteps {
                print("Added \(totalSteps-oldSteps) steps")
            }else  {
                print("Steps be less??? ")
                totalSteps = oldSteps
            }
        }
    }
}

func testStepCounter() -> Void {
    let stepCounter = StepCounter()
    stepCounter.totalSteps = 200
    stepCounter.totalSteps = 500
    stepCounter.totalSteps = 100
    print("steps:\(stepCounter.totalSteps)") //最终steps是500 ，实践证明在didSet中可以阻止设置newValue的，而且在didSet里设值不会回调willSet
}

//testStepCounter()

/*
    类型属性
  类似Java里类的静态static属性。属于类本身的，而不是实例的。
 static func 和 class func 的区别在于 class func 可以被重写，但是static的不可以。
 static var 和 class var 也是同理
 */

struct SomeStructure {
    var instanceValue:Int = 0
    mutating func changeToNewBiggestInstanceValue(newValue: Int) ->Bool{
        if newValue>instanceValue {
            self.instanceValue = newValue
            return true
        }
        return false
    }
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int{
        return 1
    }
    static func description()->String{
        return "SomeStructure struct"
    }
    
}

enum SomeEnumeration {
    case Some1,Some2
    static var storedTypeProperty = "Some Value"
    static var computedTypeProperty:Int{
        return 2
    }
}

class SomeClass{
    static let level:Int = 100
    static var storedTypeProperty = "SomeValue"
    static var computedTypeProperty:Int{
        return 55
    }
    class var overrideableComputedTypeProperty: Int{
        return 108
    }
    class func someClassFunc() -> Int{
        return 100
    }
    static func someStaticFunc() -> Int{
        return 101
    }
}

class SubSomeClass: SomeClass {
    override class var overrideableComputedTypeProperty:Int{
        return 300
    }
    
    override class func someClassFunc() ->Int{
        return 200
    }
//    override static func someStaticFunc() ->Int{   //错误：不能重写父类static 方法 和 static 变量
//        return 1
//    }
}

func testTypeProperty() -> Void {
    print("storeProperty:\(SomeStructure.storedTypeProperty)  ComputedProperty:\(SomeStructure.computedTypeProperty)")
    print("\(SomeEnumeration.computedTypeProperty)")
    print("\(SomeClass.computedTypeProperty)")
    print("父类class var：\(SomeClass.overrideableComputedTypeProperty) 子类class var：\(SubSomeClass.overrideableComputedTypeProperty)")
    print("父类：\(SomeClass.someClassFunc())  子类：\(SubSomeClass.someClassFunc())")
    
}
//testTypeProperty()

/**
 *
    strcut 和 enum 都属于值类型。一般情况下，值类型的属性不能在它的实例方法中被修改。
 但是，如果你确实要在结构体或枚举里的方法里修改结构体或枚举的属性也不是不可以，需要在方法前面加入（mutating）变异 关键词
 
 记不得什么时候用mutating也是没关系的。当你在enum或struct中更改属性值的时候，编译器会报错，根据错误提示就知道了。
 
 */

struct MyPoint {
    var x=0.0,y=0.0
    mutating func moveByX(deltaX:Double,deltaY:Double){
        x += deltaX
        y += deltaY
//        self = MyPoint(x: x+deltaX, y: y+deltaY) //mutating甚至可以让你重新给自身赋值！
    }
}

func testMutating() -> Void {
    var somePoint = MyPoint(x: 10.0,y: 10.0)
    somePoint.moveByX(20.0, deltaY: 30.0)
    print("\(somePoint)")
}

enum TriStateSwitch {
    case Off,Low,High
    mutating func next(){
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}
func testMutatingEnum() -> Void {
    var ovenLight = TriStateSwitch.Low
    ovenLight.next()
    print("\(ovenLight)")
    ovenLight.next()
    print("\(ovenLight)")
}
//testMutatingEnum()

/*
    Subscripts 附属脚本
 可以定义在类／结构体／枚举 中，可以认为是访问 集合（Collections）／ 列表（List）／ 序列（sequence） 的快捷方式。不需要访问实例的特定赋值和访问方法
 附属脚本不限于一个维度，你可以定义多个入参满足自定义类型的需求
 
 附属脚本的语法类似于 计算属性
 
 */

struct TimesTable {
    let multiplier:Int
    subscript(index:Int)->Int{
        get{
            return multiplier*index
        }
    }
}

struct MyDictionary{
    var data:[String:Int]
    subscript(key:String)->Int?{
        get{
            return data[key]
        }set{
            data[key] = newValue
        }
    }
}

func testSubscripts() -> Void {
    var myDictionary:MyDictionary = MyDictionary(data: [:])
    myDictionary["HeFei"] = 0551
    myDictionary["LuAn"] = 0564
    print("\(myDictionary["HeFei"])")
    
}
//testSubscripts()

/**
 
    继承
 一个类可以继承另一个类的方法，属性 和其它特性。
 当一个类继承其它类时，继承类叫子类，被继承类叫父类。在swift中，继承时区分 类 与其它类型的一个基本特征。
 在swift中，类可以调用和访问超类(super)的方法／属性／附属脚本，并且可以重写这些方法／属性／附属脚本来修改他们的行为。
 可以为类中继承来的属性添加属性观察器，这样一来，当属性值改变时，类就会被通知到。可以为任何属性添加属性观察器，无论它原来被定义为存储属性还是计算属性
 
 
    基类
 Swift中的类并不是从一个通用的基类继承而来。如果你不为你定义的类制定一个超类的话，这个类就自动成为基类。
 
    重写（override）
 调用 super.someMethod() 来调用父类方法
 调用 super.someProperty 来访问超类（父类）版本的属性
 调用 super[someIndex] 来访问父类的附属脚本
 
 可以将继承来的只读属性重写为一个读写属性。但不可以将一个继承来的读写属性重写为一个只读属性！！！
 
 不要为继承来的常量存储属性或继承来的只读属性添加属性观察器。这是不恰当的，因为他们的值是不可以被设置的。
 还有不要给 计算属性（提供get set的属性）添加属性观察器，因为在get set里已经可以观察到了。
 
    防止重写
 可以通过把方法／属性／附属脚本 标记为final来防止他们被重写。例如 final var  ／  final func  ／ final class func ／ final subscript
 
 如果在类名前面加上final特性后，这样的类是不允许被继承的。
 
 */

class Vehicle{
    var currentSpeed = 0.0
    var description:String { //计算属性（只读）
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() -> Void {
        //Do nothing
    }
}

class Train: Vehicle{
    
    var isAirTravel = false //是否是高铁
    
    override func makeNoise() {
        print("Choo Choo")
    }
}

class AutomaticCar:Vehicle{
    override var currentSpeed: Double{
        willSet{
            print("Car speed will set to \(newValue)")
        }
        didSet{
            gear = Int(currentSpeed / 10.0) + 1
            print("Car speed has been set from \(oldValue) to \(currentSpeed)")
        }
    }
    
    var gear = 1
    override var description: String{
        return super.description+" in gear \(gear)"
    }
}
func testCar() -> Void {
    let car = AutomaticCar()
    car.currentSpeed = 10
    print("car gear \(car.gear)")
    car.currentSpeed = 50
    print("car gear \(car.gear)")
}

//testCar()


/**
    构造过程 （Init）
 
 Swift的构造器不需要返回值。它的任务是保证实例在第一次使用前完成正确的初始化，
 
    存储属性的初始赋值
 类和结构体在创建实例时，必须为所有存储属性设置合适的初始值。存储属性的值不能处于一个未知的状态。
 在构造器中（在didSet中）为属性赋值是不会触发任何属性观察者的！
 
 如果某个属性一直有个默认值，建议在声明的时候给赋值上，这会让构造器更简洁。
 
 可选属性类型（Optional）如果不赋值，则默认就是nil 没有值。
 
 常量属性可以在构造过程中进行修改。但是一旦构造结束。这个值就不能更改了。另外这个常量属性不能在子类中更改，只能在当前类的构造函数中。
 
 如果类或结构体的每个属性都有一个默认值，那么Swift会自动创建一个默认构造函数。
 
 逐一成员构造器：针对结构体，如果对每个存储属性都提供了默认值，且没有自定义的构造器，那么swift会创建一个逐一成员构造器。
 
 构造器代理。在多个构造器中可以调用self.init来调用其它构造器。 注意：一旦定义了自定义的构造器，不管类还是结构体，默认生成的构造器都会失效。
 
 
 */

struct Fahrenheit {
    var temperature = 32.0
    
}

struct Celsius {
    var temperatureInCelsius:Double
    init(fromFahrenheit fahrenheit:Double){
        temperatureInCelsius = (fahrenheit - 32.0)/1.8
    }
    init(fromKelvin kelvin:Double){
        temperatureInCelsius = kelvin - 237.15
    }
    init(_ celsius:Double){
        temperatureInCelsius = celsius
    }
}

func testInit() -> Void {
    let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
    print("\(boilingPointOfWater.temperatureInCelsius)")
    let freezingPointOfWater = Celsius(fromKelvin: 237.15)
    print("\(freezingPointOfWater.temperatureInCelsius)")
}
//testInit()