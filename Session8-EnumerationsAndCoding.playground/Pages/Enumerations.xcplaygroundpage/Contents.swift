//: [Previous](@previous)

import Foundation

enum iOSDeviceType {
    case iPhone
    case iPad
    case appleWatch
}

let myFavoriteDevice = iOSDeviceType.appleWatch

// Inferred enum can use dot syntax
let myLeastFavoriteDevice: iOSDeviceType = .iPad


/*:
 Enum Values
 -----------
 - In the example above, the raw-value type of the enumeration is `Int`, so you only have to specify the first raw value.  The rest of the raw values are assigned in order.
 - Unlike Objective-C enums, you can use any `Strings`, `Int`, `Floats`, `Double`, `Char` for enumeration raw values.
 - Using enumerations of enumerated types, it is possible to have the `rawValue` be of any type.
 */

enum WebService: String {
    case Post = "http://something/upload"
    case Request = "http://something/request"
}

var postUrl: WebService = .Post

// Use the rawValue property to access the raw 
// value of an enumeration member
print("Post URL: \(postUrl.rawValue)")

// If the type is inferrable, you can access the 
//value using dot syntax.
postUrl = .Request
print("Request URL: \(postUrl.rawValue)")

// Set an enum value using rawValue
let requestURL = WebService(rawValue: "http://something/request")
print(requestURL!)

//: [Next](@next)
