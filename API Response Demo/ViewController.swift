//
//  ViewController.swift
//  API Response Demo
//
//  Created by Ashwin Dinesh on 25/06/18.
//  Copyright © 2018 Ashwin Dinesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Employee.fetch() { (results: [Employee]) in
            for employee in results {
                print("\(employee)\n")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

