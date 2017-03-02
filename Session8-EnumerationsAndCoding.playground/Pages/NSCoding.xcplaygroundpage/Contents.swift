//: [Previous](@previous)
import Foundation

//: # Custom Planet Object that conforms to NSCoding to archive
class Planet: NSObject, NSCoding {
    var name: String
    var size: Int
    
    // Memberwise initializer
    init(name: String) {
        self.name = name
        self.size = 100000
    }
    
    //
    // MARK: - NSCoding
    //
    
    required convenience init?(coder decoder: NSCoder) {
        guard let name = decoder.decodeObject(forKey: "name") as? String else {
            // Alternative use a coalescing operator
            // name = aDecoder.decodeObjectForKey("name") as? String ?? ""
            return nil
        }
        self.init(name: name)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.size, forKey: "size")
    }
}


//: # Archive a custom objects
let kPlanetEarthObject = "KPlanetEarthObject"
let earth = Planet(name: "Earth")
let data = NSKeyedArchiver.archivedData(withRootObject: earth)

// Unarchive our custom `Planet` object
if let earth = NSKeyedUnarchiver.unarchiveObject(with: data) as? Planet {
    print(earth.name)
    print(earth.size)
}



//: # Arhive an array of custom objects
let docs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
let cache = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0] as String
let tmp = NSTemporaryDirectory().appending("/planets.plist")


// To file on disk
let planetsObjects: [Planet] = [Planet(name: "Earth"),
                                Planet(name: "Mars"),
                                Planet(name: "Venus")]

NSKeyedArchiver.archiveRootObject(planetsObjects, toFile:docs.appending("/planets.plist"))
NSKeyedArchiver.archiveRootObject(planetsObjects, toFile:cache.appending("/planets.plist"))
NSKeyedArchiver.archiveRootObject(planetsObjects, toFile:tmp)

print(docs)

//: [Next](@next)
