//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"


func switchFallthrough(point: (x:Int,y:Int)) -> Void {
    switch point {
    case (0,0):
        print("It is on original")
        fallthrough
    case (_,0):
        print("It is on x axis")
        fallthrough
    case (0,_):
        print("It is on y axis")
//        fallthrough  //这里不能加fallthrough是因为不能转移到带有声明变量的case语句中去。
    case let(x,y):
        print("point is \(x,y)")
    }
}

//switchFallthrough((0,0))


//where语句后面跟的是一个布尔表达式

func whereSwitch() -> Void {
    let someValue = (0,0)
    switch someValue {
    case (let x,0):
        print("It is on x axis，x is \(x)")
    case (0,let y):
        print("This is on y axis ,y is \(y)")
    case let(x,y) where x==y:
        print("this is on x=y line ,x =\(x),y=\(y)")
    default:
        print("No value is i want,the value is \(someValue)")
    }
    
    let httpResp:(Int,String) = (404,"Not Found");
    switch httpResp {
    case (200,_):
        print("This request is OK")
    case (let code,"Not Found") where code==404 || code==502:
        print("Some error occured,the response code is \(code)")
    case let(code,error):
        print("The Response of this request is :code \(code), content is \(error)")
        //这里不需要default是因为case语句已将所有的情况列出来了
    }
    
    
}

func whereIf() -> Void {
    let age = 18
    //注意下面 14..<22 = age 是 模式在前
    if case 14..<22 = age where age>=18 {
        print("you are teenager")
    }
}

func whereFor() -> Void {
    //这个和下面的 for case let i in xxx  where xx 效果是一样的
//    for  i in 80...100 where i%3==0 {
//        print(" \(i) can be divide by 3")
//    }
    for case let i in 80...100 where  i%3==0{
         print(" \(i) can be divide by 3")
    }
    
}


//whereFor()


//whereSwitch()