//
//  PostTableViewController.swift
//  RedditAPI
//
//  Created by lijia xu on 8/4/21.
//

import UIKit

class PostTableViewController: UITableViewController {

    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PostController.fetchPosts { [weak self] result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let post):
                    self?.posts = post
                    
                    self?.tableView.reloadData()
                case .failure(let err):
                    print(err)
                }
                
            }
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell() }
        
        cell.post = posts[indexPath.row]
        
        
        return cell
    }

}
