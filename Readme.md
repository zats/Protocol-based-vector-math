# Protocol-based vector math

Experiment to allow basic arithmetic operations on 2D CoreGraphics types such as `CGSize`, `CGPoint`, `CGVector`

Value type that can be expresed by exactly 2 values can be safely added or subtracted to and from another type given that return type is explicitly defined.

For example adding `CGPoint` and `CGSize` is ambiguos unless you explicitl specify return type. Which can be unrelated, e.g. `CGVector`!

You can also multiple or divie any of the 2D types by a number of the same type, e.g. you can multiple `CGSize` by `CGFloat` and get `CGSize`  
