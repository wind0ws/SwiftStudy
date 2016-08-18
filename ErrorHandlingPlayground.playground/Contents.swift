//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"

/*
  例子参见： https://github.com/wind0ws/SwiftStudy/blob/master/WherePlayground.playground/Contents.swift
 
 ErrorType 是个空协议（protocol）
 在swift中，错误用遵循 ErrorType 的类型的值来表示。
 通常使用枚举来继承 ErrorType 来塑造错误情况。枚举的关联值还可以提供错误的详细信息
 
 错误处理：
 1、向上传递错误。 
 2、用 do catch 捕获异常
 3、将错误作为可选型处理
 4、断言不会发生错误
 
 
do{
    try statements
 }catch pattern1{
    //handle error
 }catch pattern2 where condition{
    //handle error
 }catch{
    //default catch
    //如果其它catch没有捕获，会进入这里。类似switch语句中的 default 分支
    //这个分支其实是可以不写的，不写的话如果上面的catch都没捕获到异常，会被传播到周围的作用域。（被上一个do  catch 处理或者由于在throwing函数里会传递给调用者）
 }
 
 能抛异常的方法和不能抛异常的方法的比较
 func canThrowErrors() throws -> String
 func cannotThrowErrors() -> String
 一个标示了throws的方法叫做 throwing 函数。
 只有throwing函数可以传递错误。任何在某个非throwing函数中抛出的错误只能在其内部进行处理。
 
 */

enum ErrorHello:ErrorType {
    case NameIncorrect(detail:String)
}

func helloThrows(name:String) throws -> String{
    if name.characters.count==0 {
        throw ErrorHello.NameIncorrect(detail: "Name should not be empty")
    }
    return name
}


func testError() -> Void {
    do{
        let result = try helloThrows("")
        print("\(result)")
    }catch ErrorHello.NameIncorrect(let error){
        print("Error: \(error) ")
    }catch{
        print("未知错误")
    }
}

//testError()


class Item{
    let price:Double
    var amount:Int
    
    init(price:Double,amount:Int = 0){
        self.price = price
        self.amount = amount
    }
    
}

enum ProductError:ErrorType {
    case NoSuchProduct(productName:String)
    case NoEnoughProduct(needed:Int)
    case NoSuchProductOrNotEnough(name:String,needed:Int)
}

class VendMache{
    var products:[String:Item] = [
        "Apple":Item(price: 35.12, amount: 12),
        "Orange":Item(price: 22.11, amount: 2),
        "Bread":Item(price: 23.11, amount: 12)
    ]
    
    var favouriteSnacks = [
        "Alice":"Apple",
        "Bob":"Bread",
        "Michael":"Banana",
        "John":"Orange"
    ]
    
    
    func buy(name:String,amount:Int) throws -> Void {
        guard let item = products[name] where item.amount >= amount else{
            throw ProductError.NoSuchProductOrNotEnough(name: name, needed: amount)
        }
        item.amount -= amount
        print("Successful buy")
    }
    
    
    func buyFavourite(person:String,amount:Int) throws -> Void {
        let favouriteSnackName = favouriteSnacks[person] ?? "Apple" //这里复习下 ?? 三元表达式的另一种形式， a ?? b 等价于 a != nil ?? a! : b
        // 此处的 ?? 等价于 favouriteSnacks[person] as? String ?? "Apple"
        try buy(favouriteSnackName, amount: 13)
        //如果不处理错误，只需要在调用位置标记 try ，有错的话会自动向调用者抛出。
        //如果这里的方法签名没有throws，那么这个函数就不是throwing函数，那么他就不能抛出，只能在其内部进行处理。
    }
    
}

enum CalculatorError:ErrorType {
    case DividerShouldNotBeZero
    case NumberTooBig(number:Int)
}

func calculate(op1:Int,op2:Int) throws -> Int {
    guard op1<100 else{
        throw CalculatorError.NumberTooBig(number: op1)
    }
    guard op2 != 0 else{
        throw CalculatorError.DividerShouldNotBeZero
    }
    return op1/op2
}

func testTryWithQuestionMark() -> Void {
    let resultX = try? calculate(12, op2: 2)
    
    let resultY:Int?
    do{
        resultY = try calculate(12, op2: 2)
    }catch{
        resultY = nil
    }
    // resultX 于 resultY 是等价的
    print("\(resultX)  \(resultY)")
}

//testTryWithQuestionMark()

/*
 合理使用 try? 能写出简洁高效的代码
 func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
 }
 */



/*
  使错误传递失效 try!
  断言不会出错
 
 try! 使错误传递失效  直接返回结果而不是Optional包装类型
 
 let photo = try! loadImage("./Resources/John Appleseed.jpg")
 
 */


/*
    指定清理操作 defer
 defer 语句将代码的执行延迟到当前的作用域退出之前。该语句由 defer 关键字和要被延时执行的语句组成。
 延时执行的语句不会包含任何会将控制权移交到语句 外面 的代码,例如一条 break 或是return 语句,或是抛出一个错误。
 延迟执行的操作是按照它们被指定的相反顺序执行 - 意思是第一条 defer 语句中 的代码执行是在第二条 defer 语句中代码被执行之后,以此类推。
 
 注意 即使没有涉及到错误处理代码,你也可以用 defer 语句。
 */

/*
 
 func processFile(filename: String) throws {
    if exists(filename) {
    let file = open(filename)
    defer {
        close(file)
    }
    while let line = try file.readline() { 
        // 处理文件
    }
        // 在这里,作用域的最后调用 close(file) }
 }
 
 */


/*
 
 openFile()
 defer {
    // defer block 1
    closeFile()
 }
 
 startPortListener(42)
 defer {
    // defer block 2
    stopPortListener(42)
 }
 
 //在这段代码中， defer block2会在函数执行结束时先执行，defer block1后执行
 // defer 先定义的后执行  后定义的先执行
 
 */
