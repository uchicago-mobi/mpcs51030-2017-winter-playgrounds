//
//  DetailViewController.swift
//  PassThePig
//
//  Created by Andrew Binkowski on 1/30/17.
//  Copyright © 2017 Andrew Binkowski. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var pigLabel: UILabel!
    
    var passedData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.pigLabel.text = passedData
    }
  
  
  
}
