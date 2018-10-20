//: # Protocol-based math

import CoreGraphics

//: ## Value types
//: ### Values that can be expressed by 2 elements

public protocol Tuple2Expressable {
  associatedtype Element
  
  init(_ tuple2Value: (Element, Element))
  
  var tuple2Value: (Element, Element) { get }
}

//: ### CGPoint, CGSize, CGVector default conformance

extension CGSize: Tuple2Expressable {
  public init(_ tuple2Value: (CGFloat, CGFloat)) {
    self.init(width: tuple2Value.0, height: tuple2Value.1)
  }
  
  public var tuple2Value: (CGFloat, CGFloat) {
    return (width, height)
  }
}

extension CGPoint: Tuple2Expressable {
  public init(_ tuple2Value: (CGFloat, CGFloat)) {
    self.init(x: tuple2Value.0, y: tuple2Value.1)
  }
  
  public var tuple2Value: (CGFloat, CGFloat) {
    return (x, y)
  }
}

extension CGVector: Tuple2Expressable {
  public init(_ tuple2Value: (CGFloat, CGFloat)) {
    self.init(dx: tuple2Value.0, dy: tuple2Value.1)
  }
  
  public var tuple2Value: (CGFloat, CGFloat) {
    return (dx, dy)
  }
}

//: ## Basic math protocols
//: Any type conforming to `Divisable` for example, must implement `/` operator, etc...

public protocol Multipliable {
  static func *(lhs: Self, rhs: Self) -> Self
}

public protocol Divisable {
  static func /(lhs: Self, rhs: Self) -> Self
}

// Not to be confused with edible
public protocol Addable {
  static func +(lhs: Self, rhs: Self) -> Self
}

public protocol Subtractable {
  static func -(lhs: Self, rhs: Self) -> Self
}

//: `Arithmeticable`™️
public typealias Arithmeticable = Addable & Subtractable & Multipliable & Divisable

//: ### Conform builtin types to basic math protocols

extension Int: Arithmeticable {}
extension Int8: Arithmeticable {}
extension Int16: Arithmeticable {}
extension Int32: Arithmeticable {}
extension Int64: Arithmeticable {}
extension UInt: Arithmeticable {}
extension UInt8: Arithmeticable {}
extension UInt16: Arithmeticable {}
extension UInt32: Arithmeticable {}
extension UInt64: Arithmeticable {}
extension CGFloat: Arithmeticable {}
extension Float32: Arithmeticable {}
extension Float64: Arithmeticable {}
extension Float80: Arithmeticable {}

//: ## ✨ Magic ✨

//: ### Make `Tuple2Expressable` implicitly `Multipliable` if its elements are `Multipliable`

extension Tuple2Expressable where Element: Multipliable {
  static func *(lhs: Self, rhs: Element) -> Self {
    return Self((lhs.tuple2Value.0 * rhs, lhs.tuple2Value.1 * rhs))
  }
  
  static func *(lhs: Element, rhs: Self) -> Self {
    return rhs * lhs
  }
}

//: ### Make `Tuple2Expressable` implicitly `Divisible` if its elements are `Divisible`

extension Tuple2Expressable where Element: Divisable {
  static func /(lhs: Self, rhs: Element) -> Self {
    return Self((lhs.tuple2Value.0 / rhs, lhs.tuple2Value.1 / rhs))
  }
}

//: ### Make `Tuple2Expressable` implicitly `Addable` if its elements are `Addable`

extension Tuple2Expressable where Element: Addable {
  static func +<T: Tuple2Expressable, U: Tuple2Expressable>(lhs: Self, rhs: T) -> U where T.Element == Element, U.Element == Element {
    return U((lhs.tuple2Value.0 + rhs.tuple2Value.0, lhs.tuple2Value.1 + rhs.tuple2Value.1))
  }
}

//: ### Make `Tuple2Expressable` implicitly `Subtractable` if its elements are `Subtractable`

extension Tuple2Expressable where Element: Subtractable {
  static func -<T: Tuple2Expressable, U: Tuple2Expressable>(lhs: Self, rhs: T) -> U where T.Element == Element, U.Element == Element {
    return U((lhs.tuple2Value.0 - rhs.tuple2Value.0, lhs.tuple2Value.1 - rhs.tuple2Value.1))
  }
}

//: ## Usage

let size = CGSize((1, 2))
let size2: CGSize = size + size

let point = CGPoint((1.5, 20.3))
point * 3
4 * point
let result: CGPoint = (point + size) * 3

size2/3

print("✅")
