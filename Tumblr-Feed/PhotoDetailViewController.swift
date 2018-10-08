//
//  PhotoDetailViewController.swift
//  Tumblr-Feed
//
//  Created by Fahit Ahmed on 10/8/18.
//  Copyright © 2018 CodePath. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    var post: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let photos = post!["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            photoImageView.af_setImage(withURL: url!)
    }
    }



}
