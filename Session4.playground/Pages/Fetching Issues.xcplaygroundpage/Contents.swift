//: [Previous](@previous)

import Foundation
import PlaygroundSupport

// Tell playground we want to continue execution after page
// is done excecuting
PlaygroundPage.current.needsIndefiniteExecution = true



//: # Prototype function to retrieve JSON and pass the results to a completion block

/// Retrieve class Issues using GitHub API v3 and pass back the
/// array of dictionaries in the completion block `completion()`
/// - Attributions: Assignment write-up
/// - Parameter url: A `String` of the url
/// - Parameter completion: A closure to run on the converted JSON
/// - Returns: An `Array` of `Dictionary` objects
func getIssues(url: String, completion:@escaping ([[String: AnyObject]]?) -> Void) {
  
  // Transform the `url` parameter argument to a `URL`
  guard let url = NSURL(string: url) else {
    fatalError("Unable to create NSURL from string")
  }
  
  // Create a vanilla url session
  let session = URLSession.shared
  
  // Create a data task
  let task = session.dataTask(with: url as URL, completionHandler: { (data, response, error) -> Void in
    
    // Print out the response (for debugging purpose)
    print("Response: \(response)")
    
    // Ensure there were no errors returned from the request
    guard error == nil else {
      fatalError("Error: \(error!.localizedDescription)")
    }
    
    // Ensure there is data and unwrap it
    guard let data = data else {
      fatalError("Data is nil")
    }
    
    // We received raw data, print it out for debugging
    // It needs to be converted to JSON
    print("Raw data: \(data)")
    
    // Serialize the raw data into JSON using `NSJSONSerialization`.  The "do-let" is
    // part of
    do {
      let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
      print(json)
      
      // Cast JSON as an array of dictionaries
      guard let issues = json as? [[String: AnyObject]] else {
        fatalError("We couldn't cast the JSON to an array of dictionaries")
      }
      
      // Call the completion block closure and pass the issues array of dictionaries as the argument to the
      // completion block.  This means that the code executed as part of the
      // completion block will have access to the `issues` data
      completion(issues)
      
      
    } catch {
      print("error serializing JSON: \(error)")
    }
  })
  
  // Tasks start off in suspended state, we need to kick it off
  task.resume()
}




/// The array of dictionaries that will hold all of our issues 
/// data returned from the network request
var issues:[[String: AnyObject]]?

/// The url of the JSON endpoint
let urlString = "https://api.github.com/repos/uchicago-mobi/mpcs51030-2017-winter-forum/issues?state=open"



/// Get all the issues from GitHub. The issues will be returned as `issues` in the closure.
/// This would be a great place to update the table view showing the issues.  Remember that
/// any UIKit elements need to be updated on the main thread.
getIssues(url: urlString) { (issues) in
  
  // The data is available in this closure through the `issues` variable
  
  // Copy the `issues` to a property of the view controller so that it can 
  // persist beyond the closure block.  The property should
  // be of the same type as the parameter here (eg [[String: AnyObject]]?)

  // For debugging
  print(issues as Any)
  
  
  // Reload the table.  The tables data source should be the property you copied the
  // issues to (above). Remember to refresh the table on the main thread
  DispatchQueue.main.async {
    // Anything in here is execute on the main thread
    // You should reload your table here.
    //tableView.reload()
  }
  
}


//: [Next](@next)
