//
//  RootViewViewController.swift
//  NFCReaderSampleProject
//
//  Created by HengVisal on 5/25/18.
//  Copyright © 2018 HengVisal. All rights reserved.
//

import UIKit

class RootViewViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        pushViewController(ViewController(), animated: false)
    }

  
}
