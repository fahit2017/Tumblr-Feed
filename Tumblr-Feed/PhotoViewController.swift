//
//  PhotoViewController.swift
//  Tumblr-Feed
//
//  Created by Fahit Ahmed on 9/29/18.
//  Copyright © 2018 CodePath. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    var posts: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Initialize a UIRefreshControl
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotoViewController.didPullToRefresh(_refreshControl:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        fetchPhotos()
    }
        
    @objc func didPullToRefresh(_refreshControl: UIRefreshControl){
        fetchPhotos()
    }
    func fetchPhotos(){
            // Network request snippet
            let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data,
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print(dataDictionary)
                    
                    // Get the dictionary from the response key
                    let responseDictionary = dataDictionary["response"] as! [String: Any]
                    // Store the returned array of dictionaries in our posts property
                    self.posts = responseDictionary["posts"] as! [[String: Any]]
                    // TODO: Reload the table view
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            }
            task.resume()
        }//end fun refreshControlAction
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = posts[indexPath.row]
        
        if let photos = post["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            cell.photoImageView.af_setImage(withURL: url!)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
