//
//  ViewController.swift
//  PassThePig
//
//  Created by Andrew Binkowski on 1/30/17.
//  Copyright © 2017 Andrew Binkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBAction func showDetachedViewController(_ sender: UIButton) {
    
    let vc = storyboard?.instantiateViewController(withIdentifier:
      "DetachedViewController")
    
    self.present(vc!, animated: true) {
      print("Detached presented")
    }
    
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //
  // MARK: - Navigation
  //
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let dvc = segue.destination as? DetailViewController
    dvc?.passedData = "Porky"
  }
  
  // Allow other view controllers to unwind to here
  @IBAction func unwindToRVC(sender: UIStoryboardSegue) {
    print("Back at RVC")
  }
  
}

