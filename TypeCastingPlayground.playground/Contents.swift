//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"
/*
 
 类型转换在swift中用 is  as 操作符来实现
 
 类型检查 is   
 B is A  返回 Bool
 
 向下转型 as?  as!
  B as? A  返回A的可选型
  B as! A 强制返回A类型
 */

class MediaItem{
    var name:String
    
    init(name:String){
        self.name = name
    }
    
}

class Song: MediaItem {
    var artiest:String
    init(artiest:String,name:String){
        self.artiest = artiest
        super.init(name: name)
    }
}

class Movie: MediaItem {
    var director:String
    init(director:String,name:String){
        self.director = director
        super.init(name: name)
    }
}

func testAsIs() -> Void {
    var libray:[AnyObject] = [
        MediaItem(name: "KongFu"),
        Movie(director: "ZhouXingChi", name: "MeiRenYu"),
        Song(artiest: "ZhouXingChi", name: "QingHuaCi")
    ]
    
    if let mediaItems = libray as? [MediaItem] {
        print("library is [MediaItem],count is \(mediaItems.count)")
    }else{
        print("library is not [MediaItem]")
    }
    
    if let media = libray[0] as? Song {
        print("\(media.artiest) \(media.name)")
    }else{
        print("解包失败")
    }
    
    if libray[1] is Movie {
        print("\((libray[1] as! Movie).name) is Movie" )
    }else{
        print("\((libray[1] as! Movie).name) is not Movie")
    }
    
    let song = libray[2] as! Song
    print("强制转换Song \(song) ")
}

//testAsIs()


/*
 不确定类型
 Any  和  AnyObject
 
 Any        真的是Any，包罗万象。所有类型都可以
 AnyObject  面向对象嘛，AnyObject只能放class类型的，任何class类型都可
 
 注意：只有你明确需要它的行为使用和功能才使用Any和AnyObject.通常使用明确的类型总是更好的。
 （将白了，就是不要滥用Any和AnyObject）
 
 */

func testAnys() -> Void {
//    var anys = [Any]()
    var anys:[Any] = [
        12,
        0,
        "Hello,Swift",
        MediaItem(name: "QingHuaCi"),
        Song(artiest: "ZhouJieLun", name: "ShuangJieGun"),
        Movie(director: "ZhouXingChi", name: "Kongfu"),
        (404,"Not Found")
    ]
    anys.append(){
        (name:String,age:Int) -> String in
        return "\(name) : \(age)"
    }
    let tuple = (10,11)
    anys.insert(tuple, atIndex: 0)
    anys.insert(0.0, atIndex: 2)
    
    
    for element in anys {
        switch element {
        case 0 as Int:
            print("This is Int Zero")
        case 0 as Double:
            print("This is Double Zero")
        case let someInt as Int:
            print("This is Int \(someInt)")
        case let someStr as String:
            print("This is String \(someStr)")
        case let someMediaItem as MediaItem:
            print("\(someMediaItem)")
        case let (x,y) as (Int,Int):
            print("This is point:(\(x),\(y))")
        case let (errorCode,message) as (Int,String):
            print("This is request result,(\(errorCode),\(message))")
        case let function as (String,Int) ->String:
            print("This is function,\(function("ZhangSan",18))")
        default:
            print("Default branch")
        }
    }
    
}

//testAnys()


func testAnyObjects() -> Void {
    var things = [AnyObject]()
    things.append(MediaItem(name: "DongFengPo"))
    things.append(Movie(director: "ZhouXingChi", name: "MeiRenYu"))
    things.append(Song(artiest: "ZhouJieLun", name: "QingHuaCi"))
    
    if let medias = things as? [MediaItem] {
        for media in medias {
            switch media {
            case let song as Song:
                print("This is Song,arties is \(song.artiest),name is \(song.name)")
            case let movie as Movie:
                print("This is Movie,director is \(movie.director),name is \(movie.name)")
            default:
                print("This is normal MediaItem ,name is \(media.name)")
            }
        }
    }
}

//testAnyObjects()
