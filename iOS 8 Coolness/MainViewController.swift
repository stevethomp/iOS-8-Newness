//
//  MasterViewController.swift
//  iOS 8 Coolness
//
//  Created by Steven Thompson on 2014-07-11.
//  Copyright (c) 2014 Steven Thompson. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

    var objects = NSMutableArray()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let swipeToContinue = UISwipeGestureRecognizer(target: self, action: "swipedToContinue")
        swipeToContinue.direction = .Right
        swipeToContinue.numberOfTouchesRequired = 2
    }
    
    func swipedToContinue() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
}

