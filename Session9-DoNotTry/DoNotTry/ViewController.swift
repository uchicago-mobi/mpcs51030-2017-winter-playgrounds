//
//  ViewController.swift
//  DoNotTry
//
//  Created by T. Andrew Binkowski on 3/4/16.
//  Copyright © 2016 The University of Chicago, Department of Computer Science. All rights reserved.
//

import UIKit

//
// Custom ErrorType
//
enum UserValidationError: Error {
  case empty
  case minimumLength
  case incorrect(message: String)
}


//
//
//
class ViewController: UIViewController {
  
  //
  // MARK: - Lifecycle
  //
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Register to listen for broadcast about default values being set
    NotificationCenter.default.addObserver(self,
      selector: #selector(ViewController.defaultsChanged),
      name: UserDefaults.didChangeNotification,
      object: nil)
    
    // Stop propogation of errors.
    //let userId = try! self.validateUser("user@email.com", password: "123456")
    //print("\(userId) should be safe to use")
    
    // Handle all error in the same way
    //if let userId = try? self.validateUser("user@email.com", password: "123456") {
    //  print("\(userId) should be safe to use")
    //}

  }
  
  /// Stop listening if the view controller is no longer present
  ///
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  
  //
  // MARK: - IBOutlest
  ///
  
  /// A label that shows the value of name_preference default
  @IBOutlet weak var namePreferenceLabel: UILabel! {
    didSet {
      let namePreference = UserDefaults.standard.string(forKey: "name_preference")
      namePreferenceLabel.text = "Name Preference: \(namePreference!)"
    }
  }
  
  
  //
  // MARK: - IBACTIONS
  //
  
  /// Handle a tap to open settings
  ///
  @IBAction func tapOpenSettings(_ sender: UIButton) {
    let settingsUrl = URL(string: UIApplicationOpenSettingsURLString)
    UIApplication.shared.openURL(settingsUrl!)
  }
  
  /// Handle a tap where the correct login was used
  ///
  @IBAction func tapCorrectLogin(_ sender: UIButton) {
    do {
      _ = try self.validateUser("user@email.com", password: "password")
      showAlert("Successful")
    }
    catch UserValidationError.empty {
      showAlert("Form Empty")
      return
    }
    catch UserValidationError.minimumLength {
      showAlert("Password too short")
      return
    }
    catch UserValidationError.incorrect {
      showAlert("Password wrong")
      return
    }
    catch {
      // Swift wants error handling to be exhaustive, so you must take into
      // account an undefined error
    }
  }
  
  
  /// Handle a tap where the login is incorrect
  ///
  @IBAction func tapIncorrectLogin(_ sender: UIButton) {
    do {
      _ = try self.validateUser("user@email.com", password: "123456")
      showAlert("Successful")
    }
    catch UserValidationError.empty {
      showAlert("Form Empty")
      return
    }
    catch UserValidationError.minimumLength {
      showAlert("Password too short")
      return
    }
    catch UserValidationError.incorrect(let message)  {
      showAlert(message)
      return
    }
    catch {
      // Swift wants error handling to be exhaustive, so you must take into
      // account an undefined error
    }
  }
  
  
  //
  // MARK: - Login Handling
  //
  
  /// Conduct basic validation on the username and password
  /// - Returns:  A `String` of the userId
  /// - Throws: A `UserValidationError`
  ///
  func validateUser(_ username: String, password: String) throws -> String {
    //
    guard password.characters.count > 0 else {
      throw UserValidationError.empty
    }
    
    //
    guard password.characters.count >= 6 else {
      throw UserValidationError.minimumLength
    }
    
    //
    guard password == "password" else {
      throw UserValidationError.incorrect(message: "Wrong password")
    }
    
    // Lookup userId based on name and password
    // let userId = lookupUserId(username,password)
    return "userId"
  }
  
  /// Show an alert to let the user know about the login state
  ///
  func showAlert(_ message: String) {
    let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
  
  //
  // MARK: - Notification Center Methods
  //
  
  /// Called when user defaults is changed via a `NSNotification` broadcast.
  /// You don't get information about what was changed, you have to get all
  /// relevant values yourself and then use them accordingly.  In this case, we
  /// update a label on the screen.
  ///
  func defaultsChanged() {
    let namePreference = UserDefaults.standard.string(forKey: "name_preference")
    namePreferenceLabel.text = "Name Preference: \(namePreference!)"
  }
}



