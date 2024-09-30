# ``nybits/Defaultable``

## Overview
`nybits` provides its own ``nybits/Defaultable`` conformances for common Swift and Core Foundation types. This allows default values to be used when `nil` or uninitialized values are encountered, providing a safer and more convenient experience for developers.

The `Defaultable` protocol is particularly useful when working with optionals and unwrapping them safely with default values. Here's how `nybits` extends several Swift and Core Foundation types with default values:

#### Conforming Types
Type                                     | Default                                      |
---------------------------------------- | -------------------------------------------- |
``nybits/Swift/Array``~                  | `[]`                                         |
``nybits/Swift/Set``~                    | `[]`                                         |
``nybits/Swift/Dictionary``~             | `[:]`                                        |
``nybits/Swift/Bool``~                   | `false`                                      |
``nybits/Swift/Int``~                    | `-1`                                         |
``nybits/Swift/UInt``~                   | `0`                                          |
``nybits/Swift/Float``~                  | `0.0`                                        |
``nybits/Swift/Double``~                 | `0.0`                                        |
``nybits/CoreFoundation/CGFloat``~       | `0.0`                                        |
``nybits/CoreFoundation/CGPoint``~       | `CGPoint(x: 0.0, y: 0.0)`                    |
``nybits/CoreFoundation/CGSize``~        | `CGSize(width: 0.0, height: 0.0)`            |
``nybits/Swift/String``~                 | `""`                                         |
``nybits/Swift/Character``~              | `" "`                                        |
``nybits/Foundation/URL``~               | `URL(staticString: "https://nythepegas.us")` |
``nybits/Foundation/Data``~              | `Data()`                                     |
``nybits/Foundation/Date``~              | `Date()`                                     |
``nybits/Foundation/UUID``~              | `UUID()`                                     |
