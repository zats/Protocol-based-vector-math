//: # Protocol-based math

import CoreGraphics

// MARK: - Value types

/// Values type that can be expressed by 2 elements
public protocol Tuple2Expressable {
  associatedtype Element
  
  init(_ tuple2Value: (Element, Element))
  
  var tuple2Value: (Element, Element) { get }
}

// MARK: - Tuple2Expressable CG types conformance

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

public protocol Negetable {
  static prefix func -(lhs: Self) -> Self
}

//: `Arithmeticable`™️
public typealias Arithmeticable = Addable & Subtractable & Multipliable & Divisable
public typealias SignedArithmeticable = Arithmeticable & Negetable

// MARK: - Conform builtin types to basic math protocols

extension Int: SignedArithmeticable {}
extension Int8: SignedArithmeticable {}
extension Int16: SignedArithmeticable {}
extension Int32: SignedArithmeticable {}
extension Int64: SignedArithmeticable {}
extension UInt: Arithmeticable {}
extension UInt8: Arithmeticable {}
extension UInt16: Arithmeticable {}
extension UInt32: Arithmeticable {}
extension UInt64: Arithmeticable {}
extension CGFloat: SignedArithmeticable {}
extension Float32: SignedArithmeticable {}
extension Float64: SignedArithmeticable {}
extension Float80: SignedArithmeticable {}

// MARK: - ✨ Magic ✨

// MARK: - Multipliable

extension Tuple2Expressable where Element: Multipliable {
  public static func *(lhs: Self, rhs: Element) -> Self {
    return Self((lhs.tuple2Value.0 * rhs, lhs.tuple2Value.1 * rhs))
  }
  
  public static func *(lhs: Element, rhs: Self) -> Self {
    return rhs * lhs
  }
}

// MARK: - Divisible

extension Tuple2Expressable where Element: Divisable {
  public static func /(lhs: Self, rhs: Element) -> Self {
    return Self((lhs.tuple2Value.0 / rhs, lhs.tuple2Value.1 / rhs))
  }
}

// MARK: - Addable

extension Tuple2Expressable where Element: Addable {
  public static func +(lhs: Self, rhs: Self) -> Self {
    return Self((lhs.tuple2Value.0 + rhs.tuple2Value.0, lhs.tuple2Value.1 + rhs.tuple2Value.1))
  }
  
  public static func +<T: Tuple2Expressable, U: Tuple2Expressable>(lhs: Self, rhs: T) -> U where T.Element == Element, U.Element == Element {
    return U((lhs.tuple2Value.0 + rhs.tuple2Value.0, lhs.tuple2Value.1 + rhs.tuple2Value.1))
  }
}

// MARK: - Subtractable

extension Tuple2Expressable where Element: Subtractable {
  public static func -(lhs: Self, rhs: Self) -> Self {
    return Self((lhs.tuple2Value.0 - rhs.tuple2Value.0, lhs.tuple2Value.1 - rhs.tuple2Value.1))
  }
  
  public static func -<T: Tuple2Expressable, U: Tuple2Expressable>(lhs: Self, rhs: T) -> U where T.Element == Element, U.Element == Element {
    return U((lhs.tuple2Value.0 - rhs.tuple2Value.0, lhs.tuple2Value.1 - rhs.tuple2Value.1))
  }
}

// MARK: - Negetable

extension Tuple2Expressable where Element: Negetable {
  public static prefix func -(lhs: Self) -> Self {
    return Self((-lhs.tuple2Value.0, -lhs.tuple2Value.1))
  }
}
