//:[Previous](@previous)

//:# Tap Gestures on a UIView

import UIKit
import PlaygroundSupport

class PlaygroundViewController: UIViewController {

  let colors: [UIColor] = [.red,.blue,.green,.purple]

  // Create a yellow box view
  var box = UIView(frame: CGRect(x: 100,y: 100,
                                 width: 100, height: 100))

  var currentColor: UIColor = .lightGray {
    didSet {
      self.box.backgroundColor = currentColor
      self.view.backgroundColor = oldValue
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.frame = CGRect(x: 0, y: 0,
                             width: 320, height: 480)
    self.view.backgroundColor = .darkGray
    
    box.backgroundColor = .yellow
    self.view.addSubview(box)
    
    
    // Create a tap gesture recoginzer
    let tapGesture = UITapGestureRecognizer(target: self,
                                            action: #selector(handleTap(_:)))
    tapGesture.numberOfTapsRequired = 1
    
    // Add tap gesture recognizer to the box
    box.addGestureRecognizer(tapGesture)
  }
  
  /// Handle the tap gesture recognizer
  func handleTap(_ gestureRecognizer: UIGestureRecognizer) {
    print("Tapped: \(gestureRecognizer)")
    self.currentColor = .purple
    print("View: \(gestureRecognizer.view)")
  }
}

// Create an instance of the view controller
let viewController = PlaygroundViewController()

// Allow playground to execute
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = viewController.view

//: [Next](@next)
