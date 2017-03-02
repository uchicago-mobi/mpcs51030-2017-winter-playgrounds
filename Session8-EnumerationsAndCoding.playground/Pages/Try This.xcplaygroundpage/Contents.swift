//: [Previous](@previous)

import Foundation

//: # Custom ErrorType
enum UserValidationError: Error {
    case empty
    case minimumLength
    case incorrect(message: String)
}


//: # Login Handling

/// Conduct basic validation on the username and password
/// - Returns:  A `String` of the userId
/// - Throws: A `UserValidationError`
///
func validateUser(_ username: String, password: String) throws -> String {
    
    guard password.characters.count > 0 else {
        throw UserValidationError.empty
    }
    
    guard password.characters.count >= 6 else {
        throw UserValidationError.minimumLength
    }
    
    guard password == "password" else {
        throw UserValidationError.incorrect(message: "Wrong password")
    }
    
    // From here, lookup userId based on name and password
    // let userId = lookupUserId(username,password)
    return "userId"
}



//: # Exhaustive errror handling

do {
    _ = try validateUser("user@email.com", password: "passsword")
    print("Successful")

} catch UserValidationError.empty {
    print("Form Empty")

} catch UserValidationError.minimumLength {
    print("Password too short")

} catch UserValidationError.incorrect(let message)  {
    print(message)

} catch {
    // Swift wants error handling to be exhaustive, so you must take into
    // account an undefined error (default case)
}


//: # Ignore any warnings; fatal error
//let userId = try! validateUser("user@email.com", password: "123456")

//: # Handle all error in the same way
if let userId = try? validateUser("user@email.com", password: "123456") {
    print("\(userId) should be safe to use")
} else {
    print("Something was thrown")
}




//: [Next](@next)
