//
//  UIViewController+Extension.swift
//  DTARKit-Examples
//
//  Created by Dima Tsurkan on 9/15/17.
//  Copyright © 2017 Dima Tsurkan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIViewController {
    var viewDidLayoutSubviews: ControlEvent<Void> {
        let events = base.rx.sentMessage(#selector(UIViewController.viewDidLayoutSubviews))
            .map { _ in }
        
        return ControlEvent(events: events)
    }
}

