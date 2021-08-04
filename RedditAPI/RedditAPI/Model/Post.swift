//
//  Post.swift
//  RedditAPI
//
//  Created by lijia xu on 8/4/21.
//

import Foundation

struct PostTopLevelObject: Codable {
    let data: PostSecondLevelObject
}

struct PostSecondLevelObject: Codable {
    let children: [PostThirdLevelObject]
}

struct PostThirdLevelObject: Codable {
    let data: Post
}

struct Post: Codable {
    let subreddit: String
    let title: String
    let ups: Int
    let thumbnail: String
}
