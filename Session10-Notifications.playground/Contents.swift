
//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

/// Note: The broacast name is a constant `kNotificationImageDownloadedKey` that
/// is defined in Constants.swift
let kNotificationImageDownloadedKey = "mobi.uchicago.imageDownloaded"


///
///
///
class ViewController: UIViewController {
    
    /// An image view to be shown in the center of the screen; use computed
    /// properties to set behaviors
    var catImageView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200))
    
    //
    // MARK: - Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the background color so we can see where the image will go
        catImageView.backgroundColor = UIColor.white
        view.addSubview(catImageView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Add the notification observer for the lifecycle of the view controller.
        // When the view controller receives the notification, it will call the
        // `imageDownloaded` function.
        // Register the notification
        let nc = NotificationCenter.default
        nc.addObserver(forName:Notification.Name(rawValue:kNotificationImageDownloadedKey),
                       object:nil,
                       queue:nil,
                       using:imageDownloaded)
        
        // Download a big image
        downloadImageWithNotification()
    }
    
    /// Called when the view controller is removed from memory.  This may not be the best
    /// place to remove it.  It is application dependent.
    deinit {
        // Remove the notification observer so it will not be listenting to broadcasts
        // anymore.
        NotificationCenter.default.removeObserver(self)
    }
}

///
///
///
extension ViewController {
    
    /// Download a really big image. Kick off a data task to downloade
    /// the image.  Announce the download is complete to the
    /// `NSNotificationCenter` so it can update the `UIImageView`
    func downloadImageWithNotification() {
        // Set the URL (big image of the sky)
        guard let url = NSURL(string: "https://apod.nasa.gov/apod/image/1106/2011-05Andreo_BigDipper7k.jpg") else {
            print("Probelem with url")
            return
        }
        
        // Retrieve the data from the URL (not a best practice)
        guard let taskData = NSData(contentsOf: url as URL) else {
            fatalError("Couldn't get URL")
        }
        
        // Create a UIImage from the response data and pass it to the completion
        // handler
        guard let image = UIImage(data: taskData as Data) else {
            fatalError("Couldn't turn data into an image")
        }
        
        print("☎️ Networking down downloading...")
        
        // Broadcast to notification center that we have the image.  We are
        // passing the image as the `object` parameter.  There are many
        // different approaches to accomplish updating your UI from a notification
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kNotificationImageDownloadedKey),
                                        object: image)
    }
    
    
    /// The method called when the notification is recieved from notification
    /// center.  Cast the `object` to an `UIImage` and then set the image property
    /// of the image view on the screen
    ///
    /// - Parameter notification: A dictionary sent to the receiver
    ///
    func imageDownloaded(notification:Notification) -> Void {
        print("☎️ Image downloaded with notification: \(notification)")
        let image = notification.object as? UIImage
        
        // Update the image with the passed image
        self.catImageView.image = image
    }
}






///
///
///
let vc = ViewController()

PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = vc


