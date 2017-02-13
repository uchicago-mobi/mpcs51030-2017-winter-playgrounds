
///: # Warning: UserDefaults does not work in playgrounds.  This code will work in an application

import Foundation

// All apps have a standard place to write
// defaults
let defaults = UserDefaults.standard

// Set a string object
defaults.set("John Appleseed", forKey: "name")
let readString = defaults.object(forKey: "name")

// Set an integer object
defaults.integer(forKey: "number")
let readNumber = defaults.object(forKey: "number")

// Print out all the values (not just yours)
print(defaults.dictionaryRepresentation())

defaults.synchronize()

defaults.register(defaults: ["soundsOn": true,
                             "theme": "dark"])
