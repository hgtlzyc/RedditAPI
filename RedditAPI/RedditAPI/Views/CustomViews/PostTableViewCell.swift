//
//  PostTableViewCell.swift
//  RedditAPI
//
//  Created by lijia xu on 8/4/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var subredditTitle: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upvotesLabel: UILabel!
    
    var post: Post? {
        didSet {
            updateViews()
        }
    }

    func updateViews() {
        guard let post = post else { return }
        subredditTitle.text = post.subreddit.uppercased()
        titleLabel.text = post.title
        upvotesLabel.text = "Upvotes: \(post.ups)"
        
        PostController.fetchThumbnail(thumbnailURL: post.thumbnail) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.thumbnailImageView.image = image
                case .failure(let err):
                    print(err)
                }
            }
            
        }//End Of fetch
        
        
    }
    
}//End Of Cell class
