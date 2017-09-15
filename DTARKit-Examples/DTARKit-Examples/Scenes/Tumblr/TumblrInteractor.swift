//
//  TumblrInteractor.swift
//  DTARKit-Examples
//
//  Created by Dima Tsurkan on 9/12/17.
//  Copyright (c) 2017 Dima Tsurkan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TumblrBusinessLogic {
    func fetchPosts(request: Tumblr.FetchImages.Request)
}

protocol TumblrDataStore {
    var posts: [TumblrPost]? { get }
    var displayedPhoto: Tumblr.FetchImages.ViewModel.DisplayedPhoto? { get set }
}

class TumblrInteractor: TumblrBusinessLogic, TumblrDataStore {
    var presenter: TumblrPresentationLogic?
    var worker: TumblrWorker?
    var posts: [TumblrPost]?
    var displayedPhoto: Tumblr.FetchImages.ViewModel.DisplayedPhoto?
  
    // MARK: Fetch Posts
  
    func fetchPosts(request: Tumblr.FetchImages.Request) {
        worker = TumblrWorker()

        worker?.fetchPosts(searchKey: request.text, completionHandler: { [weak self] (posts, error) in
            if error == nil {
                self?.posts = posts
                let response = Tumblr.FetchImages.Response(posts: posts!, errorDescription: nil)
                self?.presenter?.presentPosts(response: response)
            } else {
                let response = Tumblr.FetchImages.Response(posts: [], errorDescription: error?.localizedDescription)
                self?.presenter?.presentError(response: response)
            }
        })
    }
}
