//
//  TumblrPresenter.swift
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

protocol TumblrPresentationLogic {
    func presentPosts(response: Tumblr.FetchImages.Response)
    func presentError(response: Tumblr.FetchImages.Response)
}

class TumblrPresenter: TumblrPresentationLogic {
    weak var viewController: TumblrDisplayLogic?
  
    // MARK: Present Posts
  
    func presentPosts(response: Tumblr.FetchImages.Response) {
        var displayedPhotos: [Tumblr.FetchImages.ViewModel.DisplayedPhoto] = []        
        let allPhotos = response.posts.map { $0.photos }.flatMap { $0 }.map { $0 }
        for photo in allPhotos {
            let displayedPhoto = Tumblr.FetchImages.ViewModel.DisplayedPhoto(url: photo.url, originalWidth: photo.originalWidth, originalHeight: photo.originalHeight)
            displayedPhotos.append(displayedPhoto)
        }
        
        let viewModel = Tumblr.FetchImages.ViewModel(displayedPhotos: displayedPhotos)
        viewController?.displayFetchedPosts(viewModel: viewModel)
    }
    
    func presentError(response: Tumblr.FetchImages.Response) {
        debugPrint(response.errorDescription!)
    }
}