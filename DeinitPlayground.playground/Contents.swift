//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
/**
 ＊一个类的 析构器（deinit） 只有一个。 析构器是不允许手动调用的
 * 注意析构器是不带括号的。  他和构造器是不一样的！
 * 子类析构器会自动继承父类的析构器，并在子类析构器的最后调用父类析构器完成实例的清理工作
 */

struct Bank{
    static var coinsInBank = 1_0000
    
    static func vendCoins(numberOfCoinsToVend:Int)->Int{
        let vendCoins = min(coinsInBank, numberOfCoinsToVend)
        coinsInBank -= vendCoins
        return vendCoins
    }
    
    static func recycleCoins(numberOfCoinsToRecycle:Int)->Void{
        coinsInBank += numberOfCoinsToRecycle
    }
}

class Player {
    var coins:Int
    init(vendCoins:Int){
        coins = Bank.vendCoins(vendCoins)
    }
    func win(winCoins:Int) -> Void {
        coins+=Bank.vendCoins(winCoins)
    }
    deinit{ //注意deinit和构造器是不同的，他没有括号哦
        Bank.recycleCoins(coins)
    }
}

func testPlayWithCoins() -> Void {
    var player:Player? = Player(vendCoins: 100)
    guard player != nil else{
        print("player is nil")//Apple代码风格。条件检查放在方法的前面
        return
    }
    if let player = player {
        print("玩家player创建成功，他分配的Coins:\(player.coins).  银行的Coins：\(Bank.coinsInBank)")
    }
    player?.win(100)
    print("player 赢了,他现在拥有 \(player?.coins) coins. 银行的Coins：\(Bank.coinsInBank)" )
    player = nil
    print("player 不玩了，退场了.银行的Coins：\(Bank.coinsInBank)")
    
}

//testPlayWithCoins()