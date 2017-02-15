import UIKit
import PlaygroundSupport

/// Protocol to delegate the touch information to a
/// view controller from a touched view
protocol TouchViewDelegate: class {
    func receivedTouch(sender: UIView, message: String)
}


/// A red box view that detects a touch
class RedBoxView: UIView {
    
    /// The delegate to the referenced type
    weak var delegate: TouchViewDelegate?
    
    /// Custom view initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
    }
    
    /// This is required; it would be used if you used
    /// the custom class in a Storyboard
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// When the view is touched; invoke the delegate to
    /// call the protocol function
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.receivedTouch(sender: self, message: "Hi from red box!")
    }
}

/// A view controller that has
class MyViewController: UIViewController, TouchViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect(x: 0, y: 0, width: 320, height: 480)
        self.view.backgroundColor = .lightGray
        
        // Create an instance of the red box view
        let rbView = RedBoxView(frame: CGRect(x: 0, y: 0,
                                              width: 100, height: 100))
        // Assign this instace of the view controller (self) as the
        // red box view's delegate
        rbView.delegate = self
        view.addSubview(rbView)
    }
    
    // MARK: - TouchView Delegate Methods
    func receivedTouch(sender: UIView, message: String) {
        print("🤖Touched View: \(sender)\n🤖Message: \(message)")
    }
}




// Create an instance of the view controller
let viewController = MyViewController()

// Allow playground to execute
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = viewController.view
