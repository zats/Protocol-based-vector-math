import CoreGraphics

let size = CGSize(width: 1, height: 2)
let size2 = size + size
size2 * 4

let point = CGPoint(x: 1.5, y: 20.3)
point * 3
4 * point
let result: CGVector = (point + size) * 3
size2 / 3

print("✅")
