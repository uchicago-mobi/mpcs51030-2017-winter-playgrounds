//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//: Warning: This does not work in Playgrounds
//:

func uploadRequest(user: NSString, image: UIImage, caption: NSString){

  let boundary = generateBoundaryString()
  let imageJPEGData = UIImageJPEGRepresentation(image,0.1)
  
  guard let imageData = imageJPEGData else {return}
  
  // Create the URL, the user should be unique
  let url = NSURL(string: "http://stachesandglasses.appspot.com/post/\(user)/")

  // Create the request
  let request = NSMutableURLRequest(url: url! as URL)
  request.httpMethod = "POST"
  request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

  // Set the type of the data being sent
  let mimetype = "image/jpeg"
  // This is not necessary
  let fileName = "test.png"
  
  // Create data for the body
  let body = NSMutableData()
  body.append("\r\n--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
  
  // Caption data
  body.append("Content-Disposition:form-data; name=\"caption\"\r\n\r\n".data(using: String.Encoding.utf8)!)
  body.append("CaptionText\r\n".data(using: String.Encoding.utf8)!)
  
  // Image data
  body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
  body.append("Content-Disposition:form-data; name=\"image\"; filename=\"\(fileName)\"\r\n".data(using: String.Encoding.utf8)!)
  body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
  body.append(imageData)
  body.append("\r\n".data(using: String.Encoding.utf8)!)
  
  // Trailing boundary
  body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
  
  // Set the body in the request
  request.httpBody = body as Data
  
  // Create a data task
  let session = URLSession.shared
  _ = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
    // Need more robust errory handling here
    // 200 response is successful post
    print(response!)
    print(error as Any)
    
    // The data returned is the update JSON list of all the images
    let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
    print(dataString as Any)
  }.resume()
    
}

/// A unique string that signifies breaks in the posted data
func generateBoundaryString() -> String {
  return "Boundary-\(NSUUID().uuidString)"
}

let image = UIImage(named: "pokemon")
uploadRequest(user: "test", image: image!, caption: "This is a caption")
