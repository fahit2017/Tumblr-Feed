//
//  ZoomViewController.swift
//  Tumblr-Feed
//
//  Created by Fahit Ahmed on 10/8/18.
//  Copyright © 2018 CodePath. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       performSegue(withIdentifier: "firstSague", sender: nil)
    }
    
}
