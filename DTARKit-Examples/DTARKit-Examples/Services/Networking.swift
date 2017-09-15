//
//  Networking.swift
//  DTARKit-Examples
//
//  Created by Dima Tsurkan on 9/12/17.
//  Copyright © 2017 Dima Tsurkan. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Networking {
    
    // MARK: -
    static let shared = Networking()
    let apiKey = "CcEqqSrYdQ5qTHFWssSMof4tPZ89sfx6AXYNQ4eoXHMgPJE03U"
    
    // MARK: - Public
    
    func fetchPosts(forSearchKey key: String, completionHandler: @escaping ([TumblrPost]?, NSError?) -> Void) {
        let endpoint = "http://api.tumblr.com/v2/tagged?tag=\(key)&api_key=\(apiKey)"
        
        guard let url = URL(string: endpoint) else {
            let error = NSError(domain: "Could not construct URL", code: 999, userInfo: nil)
            completionHandler(nil, error)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error! as NSError)
                return
            }
            
            guard let responseData = data else {
                let error = NSError(domain: "Did not receive data", code: 999, userInfo: nil)
                completionHandler(nil, error)
                return
            }
            
            let json = JSON(data: responseData)
            let posts = json["response"].arrayValue.map { TumblrPost(json: $0) }
            completionHandler(posts, nil)
        }
        task.resume()
    }
}
