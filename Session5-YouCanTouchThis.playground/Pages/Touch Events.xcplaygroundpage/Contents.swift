//: [Previous](@previous)

import UIKit
import PlaygroundSupport

/// View Controller to hold our view
class PlaygroundViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
    self.view.backgroundColor = .lightGray
    let rb = RedBox()
    self.view.addSubview(rb)
  }
}

/// Custom UIView that implement touch handling functions
class RedBox: UIView {
  // MARK: - Initialization
  override init (frame : CGRect) {
    super.init(frame : CGRect(x: 100, y: 100,
                              width: 100, height: 100))
    backgroundColor = UIColor.red
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Touch handling
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    print("Touches Began EVENT: \(event)")
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    print("Touches Ended EVENT: \(event)")
  }
  
  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    print("Touches Cancelled EVENT: \(event)")
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    print("Touches Moved EVENT: \(event)")
  }
}

// Create an instance of the view controller
let viewController = PlaygroundViewController()

// Allow playground to execute
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = viewController.view

//: [Next](@next)
