//
//  PostController.swift
//  RedditAPI
//
//  Created by lijia xu on 8/4/21.
//

import Foundation
import UIKit.UIImage

class PostController {
    
    static let cache = NSCache<NSString, UIImage>()
    
    static func fetchPosts(completion: @escaping ( Result<[Post],PostError> ) -> Void) {
        
        //need https
        let baseURL = URL(string: "https://www.reddit.com/r/battlestations.json")
        guard let finalURL = baseURL else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print("!!!Status code: \(response.statusCode)")
            }
            
            guard let data = data else {
                completion(.failure(.nodata))
                return
            }
            
            do {
                let topLevelObject = try JSONDecoder().decode(PostTopLevelObject.self, from: data)
                let posts = topLevelObject.data.children.map{$0.data}
                completion(.success(posts))
                
            } catch {
                completion(.failure(.unableToDecode))
            }
            
        }.resume()
        
    
    }//End Of fetch Post
    
    static func fetchThumbnail(thumbnailURL: String, completion: @escaping (Result<UIImage, PostError>) -> Void) {
        
        let cacheKey = NSString(string: thumbnailURL)
        if let image = cache.object(forKey: cacheKey) {
            completion(.success(image))
        }
        
        guard let finalURL = URL(string: thumbnailURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: finalURL) { data, response, err in
            if let error = err {
                completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {
                completion(.failure(.nodata))
                return
            }
            
            guard let thumbnail = UIImage(data: data) else {
                completion(.failure(.unableToDecode))
                return
            }
            
            self.cache.setObject(thumbnail, forKey: NSString(string: thumbnailURL))
            
            completion(.success(thumbnail))
            
            
        }.resume()
        
    }
    
}//End Of Class
