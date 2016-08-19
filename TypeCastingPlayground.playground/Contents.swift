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

testAsIs()


/*
 
 Any  和  AnyObject
 
 Any  真的是Any，包罗万象
 AnyObject  面向对象嘛，AnyObject只能放class类型的，任何class类型都可
 
 */