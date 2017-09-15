//
//  TumblrDetailsPresenter.swift
//  DTARKit-Examples
//
//  Created by Dima Tsurkan on 9/15/17.
//  Copyright (c) 2017 Dima Tsurkan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TumblrDetailsPresentationLogic {
    func presentSomething(response: TumblrDetails.Something.Response)
}

class TumblrDetailsPresenter: TumblrDetailsPresentationLogic {
    weak var viewController: TumblrDetailsDisplayLogic?
  
    // MARK: Do something
  
    func presentSomething(response: TumblrDetails.Something.Response) {
        let viewModel = TumblrDetails.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
