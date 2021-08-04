//
//  PostError.swift
//  RedditAPI
//
//  Created by lijia xu on 8/4/21.
//

import Foundation

enum PostError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case nodata
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "invalid url"
        case .thrownError(let err):
            return "\(err)"
        case .nodata:
            return "there was no data"
        case .unableToDecode:
            return "unable to decode data"
        }
    
    }//End Of error Description
    
}//End Of PostError
