//: [Previous](@previous)


//: Download and parse JSON
//: =======================
import Foundation
import PlaygroundSupport

// Tell playground we want to continue execution after page
// is done excecuting
PlaygroundPage.current.needsIndefiniteExecution = true

// String representation of the URL to retrieve Issues
let urlString = "https://api.github.com/repos/uchicago-mobi/mpcs51030-2017-winter-forum/issues?state=open"

guard let url = NSURL(string: urlString) else {
  fatalError("Unable to create NSURL from string")
}

// Create a vanilla url session
let session = URLSession.shared

// Create a data task
let task = session.dataTask(with: url as URL, completionHandler: { (data, response, error) -> Void in
  
  // Print out the response
  print("Response: \(response)")
  
  // Ensure there were no errors returned from the request
  guard error == nil else {
    print("error: \(error!.localizedDescription)")
    fatalError("Error: \(error!.localizedDescription)")
  }
  
  // Ensure there is data and unwrap it
  guard let data = data else {
    fatalError("Data is nil")
  }
  
  // We received data but it needs to be processed
  print("Raw data: \(data)")
  
  // Serialize the raw data into JSON using `NSJSONSerialization`.  The "do-try" is
  // part of an error handling feature of Swift that will be disccused in the future.
  do {
    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
    print(json)
    
    // Cast JSON as an array of dictionaries
    guard let issues = json as? [[String: AnyObject]] else {
      fatalError("We couldn't cast the JSON to an array of dictionaries")
    }
    
    // Parse the array of dictionaries to get the important information that you
    // need to present to the user
    
    // Do some parsing here
    
  } catch {
    print("error serializing JSON: \(error)")
  }
})

// Tasks start off in suspended state, we need to kick it off
task.resume()


//: [Next](@next)
