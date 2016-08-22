//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"

struct BlackjackCard {
    enum Suit:Character { //枚举如果有原始值，必须要继承一个数据类型
        case Spades = "🍁", Hearts = "❤️", Diamonds = "💎", Clubs = "♠️"
        
    }
    
    enum Rank :Int{
        case Two = 2,Three,Four,Five,Six,Seven,Eight,Nine,Ten
        case Jack,Queen,King,Ace
        
        struct Values {
            let first:Int, second:Int?
        }
        
        var values:Values{
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack,.Queen,.King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    let rank:Rank,suit:Suit
    
    var discription:String {
        var output = "This suit is \(suit.rawValue)"
        output += " , value is \(rank.values.first) "
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
    
    
}


func testBlackjackCard() -> Void {
    let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
    //看看上面的构造函数，他们虽然引用的是BlackjackCard内部元素，但是还是能用简短的名称来引用。这得益于Swift的上下文推断。
    let spadesRawValue = BlackjackCard.Suit.Spades.rawValue
    print("theAceOfSpades:\(theAceOfSpades.discription)\n \(spadesRawValue)")
}

//testBlackjackCard()

