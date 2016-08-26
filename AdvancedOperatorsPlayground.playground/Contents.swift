//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"

/*
 
 与C语言中的算术运算符不同,Swift 中的算术运算符默认是不会溢出的。所有溢出行为都会被捕获并报告为错误。
 如果想让系统允许溢出行为,可以选择使用 Swift 中另一套默认支持溢出的运算符,比如溢出加法运算 符(&+)。所有的这些溢出运算符都是以 & 开头的。
 
 */

/*
 
 ~ 按位取反.
 
 */
func bitWiseNotOperator() -> Void {
    let initialBits:UInt8 = 0b00001111
    let invertedBits = ~initialBits
    //注意 按位取反运算符(~) 与加减乘除运算符不同，它(~)必须和操作数连在一起，不能有空格。只有单操作数才会这样。两个数与操作符之间还是需要空格的
    print("\(invertedBits)")
    
    
}
//bitWiseNotOperator()


/*
 
 按位与运算符(&)可以对两个数的比特位进行合并。
 它返回一个新的数,只有当两个操作数的对应位都为 1 的 时候,该数的对应位才为 1 。不同则为 0
 
 */

func bitwiseAndOperator() -> Void {
    let firstBits:UInt8 = 0b00001111
    let secondBits:UInt8 = 0b11001100
    let and = firstBits & secondBits
    print("\(and)")
}

/*
 
 按位或运算符(Bitwise OR Operator)
 按位或运算符( | )可以对两个数的比特位进行比较。它返回一个新的数,
 只要两个操作数的对应位中有任意一个 为 1 时,该数的对应位就为 1 。
 同为0才为0，否则为1
 
 */

func bitwiseOrOperator() -> Void {
    let firstBits:UInt8 = 0b00001111
    let secondBits:UInt8 = 0b11001100
    let or = firstBits | secondBits
    print("\(or)")
}

/*
 
 按位异或运算符(Bitwise XOR Opoerator)
 按位异或运算符( ^ )可以对两个数的比特位进行比较。
 它返回一个新的数,当两个操作数的对应位不相同时,该数的对应位就为 1
 
 */

func bitwiseXorOperator() -> Void {
    let firstBits:UInt8 = 0b00001111
    let secondBits:UInt8 = 0b11001100
    let xor = firstBits ^ secondBits
    print("\(xor)")
}

//bitwiseXorOperator()

/*
 
 按位左移/右移运算符(Bitwise Left and Right Shift Operators)
 按位左移运算符( << )和按位右移运算符( >> )可以对一个数进行指定位数的左移和右移,但是需要遵守下面定义的规则。

 对一个数进行按位左移或按位右移,相当于对这个数进行 乘以2 或 除以2 的运算。
 将一个整数左移一位,等价于将这个数 乘以2 ,同样地,将一个整数右移一位,等价于将这个数 除以2。
 无符号整型的移位操作 对无符号整型进行移位的规则如下:
 1. 已经存在的比特位按指定的位数进行左移和右移。 
 2. 任何移动超出整型存储边界的位都会被丢弃。
 3. 用 0 来填充移动后产生的空白位。
 这种方法称为逻辑移位( logical shift )。

 
 */

func shiftOperator() -> Void {
    let shiftBits:UInt8 = 4 // 即二进制的00000100
    shiftBits << 1          // 00001000
    shiftBits << 2          // 00010000
    shiftBits << 5          // 10000000
    shiftBits << 6          // 00000000
    shiftBits >> 2          // 00000001
    
    //注意，这些左移右移操作并不会改变原来的操作数。它就像加减乘除似的，它只是返回个计算结果。
    
}

//shiftOperator()

func shitColor() -> Void {
    let pink: UInt32 = 0xCC6699
    // 16 进制中每两个字符表示 8 个比特位
    let redComponent = (pink & 0xFF0000) >> 16 // redComponent 是 0xCC, 即 204
    let greenComponent = (pink & 0x00FF00) >> 8  // greenComponent 是 0x66, 即 102
    let blueComponent = pink & 0x0000FF   // blueComponent 是 0x99, 即 153
    print("\(redComponent)  \(greenComponent) \(blueComponent)")
}

/*
 
 有符号整型的移位操作对比无符号整型来说,有符整型的移位操作相对复杂得多,这种复杂性源于有符号整数的二进制表现形式。
 
 (为了简单起见,以下的示例都是基于 8 位有符号整数的,但是其中的原理对任何位数的有符号整数都是通用的。)
 
 有符号整数使用第 1 个比特位(通常被称为符号位)来表示这个数的正负。符号位为 0 代表正数,为 1 代表负数。
 其余的比特位(通常被称为数值位)存储了这个数的真实值。
 有符号正整数和无符号数的存储方式是一样的,都是从 0 开始算起。
 
 值为 4 的 Int8 型整数的二进制位表现形式: 0000 0100 (其中第一个0是符号位，0正1负)
 
 负数的存储方式略有不同:它存储的是 2 的 n 次方减去它的真实值绝对值,这里的 n 为数值位的位数。
 一个 8 位的数有 7 个数值位,所以是 2 的 7 次方,即 128。(最小值是－128)
 
 值为 －4 的 Int8 型整数的二进制表现形式： 1111 1100 （第一位 1 是符号位，代表是负数）
 （111 1100 这7位数值位是 124，所以这个负数绝对值即为： 128 － 124 ＝ 4  所以这个负数即为 －4）
 
 负数的表示通常被称为二进制补码( two's complement )表示法。用这种方法来表示负数乍看起来有点奇怪,但它有几个优点。
 首先,如果想对 -1 和 -4 进行加法操作,我们只需要将这两个数的全部 8 个比特位进行相加,并且将计算结果中超出 8 位的数值丢弃。
 其次,使用二进制补码可以使负数的按位左移和右移操作得到跟正数同样的效果,
 即每向左移一位就将自身的数值乘以 2,每向右一位就将自身的数值除以 2。
 
 要达到此目的,对有符号整数的右移有一个额外的规则:
 • 当对正整数进行按位右移操作时,遵循与无符号整数相同的规则,但是对于移位产生的空白位使用 符号位 进行填充,而不是用 0 （正数填充0，负数填充1）。
 这个行为可以确保有符号整数的符号位不会因为右移操作而改变,这通常被称为算术移位( arithmetic shift )。
 由于正数和负数的特殊存储方式,在对它们进行右移的时候,会使它们越来越接近 0。在移位的过程中保持符号 位不变,意味着负整数在接近 0 的过程中会一直保持为负。
 
 */

/*
 
 溢出运算符
 
 在默认情况下,当向一个整数赋超过它容量的值时,Swift 默认会报错,而不是生成一个无效的数。
 这个行为给我们操作过大或着过小的数的时候提供了额外的安全性。
 例如,Int16 型整数能容纳的有符号整数范围是 -32768 到 32767,当为一个 Int16 型变量赋的值超过这个范围时,系统就会报错:
 
 var potentialOverflow = Int16.max
 // potentialOverflow 的值是 32767, 这是 Int16 能容纳的最大整数
 potentialOverflow += 1 // 这里会报错
 
 为过大或者过小的数值提供错误处理,能让我们在处理边界值时更加灵活。
 然而,也可以选择让系统在数值溢出的时候采取 截断操作 ,而非报错。
 可以使用 Swift 提供的三个溢出操作符( overflow operators )来让系统支持整数溢出运算。
 这些溢出操作符都是以 & 开头的:
 • 溢出加法 &+ 
 • 溢出减法 &- 
 • 溢出乘法 &*
 
 
 数值溢出
 数值有可能出现上溢或者下溢。
 这个示例演示了当我们对一个无符号整数使用溢出加法( &+ )进行上溢运算时会发生什么:
 
 
 var unsignedOverflow = UInt8.max
 // unsignedOverflow 等于 UInt8 所能容纳的最大整数 255
 unsignedOverflow = unsignedOverflow &+ 1 //上溢。 此时 unsignedOverflow 等于 0

 
 同样地,当我们对一个无符号整数使用溢出减法( &- )进行下溢运算时也会产生类似的现象:
 
 var unsignedOverflow = UInt8.min
 // unsignedOverflow 等于 UInt8 所能容纳的最小整数 0
 unsignedOverflow = unsignedOverflow &- 1 //下溢。 此时 unsignedOverflow 等于 255
 
 UInt8 型整数能容纳的最小值是 0,以二进制表示即 00000000 。
 当使用溢出减法运算符对其进行减 1 操作 时,数值会产生下溢并被截断为 11111111 , 也就是十进制数值的 255。
 
 
 溢出也会发生在有符号整型数值上。
 在对有符号整型数值进行溢出加法或溢出减法运算时,符号位也需要参与计算,正如按位左移/右移运算符所描述的。 
 
 var signedOverflow = Int8.min
 // signedOverflow 等于 Int8 所能容纳的最小整数 -128
 signedOverflow = signedOverflow &- 1 // 此时 signedOverflow 等于 127
 
 (1000 0000 -& 1 = 0111 111 )
 
 
 对于无符号与有符号整型数值来说,当出现上溢时,它们会从数值所能容纳的最大数变成最小的数。
 同样地,当发生下溢时,它们会从所能容纳的最小数变成最大的数。
 
 */

/*
 
 优先级和结合性
 运算符的优先级( precedence )使得一些运算符优先于其他运算符,高优先级的运算符会先被计算。
 结合性( associativity )定义了相同优先级的运算符是如何结合(或关联)的 —— 是与左边结合为一组,还是 与右边结合为一组。
 可以将这意思理解为“它们是与左边的表达式结合的”或者“它们是与右边的表达式结合的”。

  2 + 3 * 4 % 5   答案是4
 
 优先级高的运算符要先于优先级低的运算符进行计算。
 与C语言类似,在 Swift 当中,乘法运算符( * )与取余运算符( % )的优先级高于加法运算符( + )
 乘除取余运算优先级相同   加减运算优先级相同。  乘除取余 优先级高于 加减
 
 注意:
 对于C语言和 Objective-C 来说,Swift 的运算符优先级和结合性规则是更加简洁和可预测的。
 但是,这也意味着它们于那些基于C的语言不是完全一致的。
 在对现有的代码进行移植的时候,要注意确保运算符的行为仍然是按照你所想的那样去执行。

 
 */

struct Vector2D {
    var x:Int,y:Int
}

func +(first:Vector2D,second:Vector2D) -> Vector2D {
    return Vector2D(x: first.x+second.x, y: first.y+second.y)
}

func testOverrideOperator() -> Void {
    let first = Vector2D(x: 2, y: 3)
    let second = Vector2D(x: 1, y: 4)
    let plus = first + second
    print("\(plus)")
}

//testOverrideOperator()

/*
 
 前缀和后缀运算符
 上个例子演示了一个双目中缀运算符的自定义实现。类与结构体也能提供标准单目运算符( unary operators )的 实现。
 单目运算符只有一个操作目标。当运算符出现在操作目标之前时,它就是前缀(prefix)的(比如 -a ),
 而当它出现在操作目标之后时,它就是后缀( postfix )的(比如 i++ )
 
 
 要实现前缀或者后缀运算符,需要在声明运算符函数的时候在 func 关键字之前指定 prefix 或者 postfix 限定符
 
 */

prefix func -(inout vector:Vector2D) -> Vector2D{
    vector.x = -vector.x
    vector.y = -vector.y
    return vector
}

func +=(inout left:Vector2D,right:Vector2D) -> Vector2D{
    left = left + right
    return left
}

func -=(inout left:Vector2D,right:Vector2D) -> Vector2D{
    //默认情况下，参数都是let常量，是不允许在方法里面进行更改的，
    //但是如果给参数加个 inout 表示这个参数可改并可以将更改的值回传给调用者。
    //还有种方式就像下面这样，申明一个和参数名称一样的变量（其实名称不一样也是可以的）
    var right = right
    return left += (-right)
}

postfix func ++(inout vector:Vector2D) -> Vector2D{
    vector += Vector2D(x: 1, y: 1)
    return vector
}

func testPrefixAndPostfix() -> Void {
    var vector = Vector2D(x: 2, y: 2)
    print("\(-vector)")
    print("\(vector++)")
}

//testPrefixAndPostfix()

/*
 
 注意: 不能对默认的赋值运算符( = )进行重载。只有组合赋值符可以被重载。同样地,也无法对三目条件运算 符 a ? b : c 进行重载。
 
 */


/*
 
 等价操作符
 自定义的类和结构体没有对等价操作符( equivalence operators )进行默认实现,
 等价操作符通常被称为“相等”操作符( == )与“不等”操作符( != )。
 对于自定义类型,Swift 无法判断其是否“相等”,因为“相等”的 含义取决于这些自定义类型在你的代码中所扮演的角色。
 为了使用等价操作符来对自定义的类型进行判等操作,需要为其提供自定义实现,实现的方法与其它中缀运算符一样
 
 */

func ==(first:Vector2D,second:Vector2D) -> Bool {
    return (first.x == second.x) && (first.y ==  second.y)
}

func !=(first:Vector2D,second:Vector2D) -> Bool {
    return !(first == second)
}

/*
 
 自定义运算符
 除了实现标准运算符,在 Swift 当中还可以声明和实现自定义运算符( custom operators )。
 可以用来自定义运算符的字符列表请参考操作符
 新的运算符要在全局作用域内,使用 operator 关键字进行声明,同时还要指定 prefix、infix(中缀运算符) 或者 postfix 限定符:
 
 
 */

//这个只是声明了一个操作符
prefix operator +++ {}

//这个是针对上面的操作符 对Vector2D的一种实现
prefix func +++ (inout vector: Vector2D) -> Vector2D {
    vector += vector
    return vector
}

func tobeDoubbled() -> Void {
    var vector = Vector2D(x: 2, y: 3)
    print("\(+++vector)")
}

postfix operator --- {}

postfix func ---(inout vector:Vector2D) -> Vector2D{
    return vector -= Vector2D(x: 1, y: 1)
}

func testPrePostFix() -> Void {
    var vector = Vector2D(x: 5, y: 5)
    print("\(+++vector)")
    print("\(vector---)")
}

//testPrePostFix()

/*
 
 自定义中缀运算符的优先级和结合性
 自定义的中缀( infix )运算符也可以指定优先级( precedence )和结合性( associativity )
 
 结合性(associativity)可取的值有left,right 和 none。
 left: 当左结合运算符跟其他相同优先级的左结合运算符写在一起时,会跟左边的操作数进行结合。
 right: 同理,当右结合运算符跟其他相同优先级的右结合运算符写在一起时,会跟右边的操作数进行结合。
 none: 而非结合运算符不能跟其他相同优先级的运算符写在一起。
 
 结合性( associativity )的默认值是 none ,
 优先级( precedence )如果没有指定,则默认为 100
 
 
 注意: 当定义前缀与后缀操作符的时候,我们并没有指定优先级。然而,如果对同一个操作数同时使用前缀与后缀操作符,则后缀操作符会先被执行。
 */

infix operator +-{associativity left precedence 140 }

//中缀方法前无需 infix。 但是前缀和后缀需要 prefix func和postfix func
func +-(left:Vector2D,right:Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y - right.y)
}

func testPlusMins() -> Void {
    let left = Vector2D(x: 2, y: 3)
    let right = Vector2D(x: 3, y: 4)
    print("\(left +- right +- right)")
}
//testPlusMins()


