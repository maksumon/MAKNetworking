//
//  UserListViewController.swift
//  MAKNetworking
//
//  Created by Mohammad Ashraful Kabir on 26/01/2020.
//  Copyright © 2020 Mohammad Ashraful Kabir. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {

    @IBOutlet weak var tblList: UITableView?
    
    private let refreshControl = UIRefreshControl()
    
    private let postFetcher = PostFetcher()
    
    private var posts: [Post] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tblList!.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        refreshControl.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
        self.tblList!.refreshControl = refreshControl
        
        self.tblList?.tableFooterView = UIView.init(frame: .zero)
        
        self.requestPosts()
    }
    
    // MARK: - Custom Actions
    @objc private func refreshPosts() {
        let cache =  URLCache.shared
        cache.removeAllCachedResponses()
        
        self.requestPosts()
    }
    
    private func requestPosts() {
        postFetcher.getData(fromUrl: API_URL) { (result, error) in
            if result != nil {
                self.posts = result!
            } else if error != nil {
                print(error!)
            } else {
                print("404 page not found")
            }
            
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
}

extension UserListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        cell.user = posts[indexPath.row].user
        
        return cell
    }
    
}

extension UserListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0

        UIView.animate(
            withDuration: 0.5,
            delay: 0.075 * Double(indexPath.row),
            animations: {
                cell.alpha = 1
        })
    }
    
}
