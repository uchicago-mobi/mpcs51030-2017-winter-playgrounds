//:[Previous](@previous)

import UIKit
import PlaygroundSupport

//: Create a view controller
class PlaygroundViewController: UIViewController {

  // MARK: - Properties
  var box = UIView(frame: CGRect(x: 100,y: 100,
                                 width: 100, height: 100))
  var currentColor: UIColor = .white {
    willSet {
      self.box.backgroundColor = newValue
    }
  }
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .darkGray
    
    // Create a yellow box view
    self.currentColor = .yellow
    self.view.addSubview(self.box)
    
    
    // Create a pan gesture recoginzer
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
    
    // Add a tap gesture recognizer to the box
    box.addGestureRecognizer(panGesture)
  }
  
  // MARK: - Gesture Recognizers
  
  /// Reposition the center of a view to correspond with a touch point
  /// - Parameter recognizer: The gesture that is recognized
  func handlePan(_ recognizer:UIPanGestureRecognizer) {
    
    // Determine where the view is in relation to the superview
    let translation = recognizer.translation(in: self.view)
    print(translation)
    
    if let view = recognizer.view {
      // Set the view's center to the new position
      view.center = CGPoint(x:view.center.x + translation.x,
                            y:view.center.y + translation.y)
      print(view.center)
    }
    
    // Reset the translation back to zero, so we are dealing
    // in offsets
    recognizer.setTranslation(CGPoint.zero, in: self.view)
  }
}


// Create an instance of the view controller
let viewController = PlaygroundViewController()

// Allow playground to execute
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = viewController.view

//: [Next](@next)
