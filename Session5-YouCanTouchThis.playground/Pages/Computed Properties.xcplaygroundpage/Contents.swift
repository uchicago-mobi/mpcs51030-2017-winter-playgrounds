//: [Previous](@previous)

import Foundation

//: ## Computed Property
//: A computed property is calculated when accessed.  The value
//: is not stored in memory.

/// A step counter structure to get track of number
/// of steps from stairs and walking
struct stepCounter {
  
  var stairSteps: Int = 0
  var walkingSteps: Int = 0
  
  // Read only computed property
  var totalSteps: Int {
    get {
      // Walking up stairs is twice as difficult
      // so we are adding a multiplier of 2
      return (stairSteps * 2) + walkingSteps
    }
  }
}

//: > Let's execise and see how much work we
//: > actually did
var counter = stepCounter()
counter.stairSteps = 10
counter.walkingSteps = 100
print("Total Steps: \(counter.totalSteps)")


//: [Next](@next)
