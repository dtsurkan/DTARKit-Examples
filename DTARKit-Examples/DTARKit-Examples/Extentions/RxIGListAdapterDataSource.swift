//
//  RxIGListAdapterDataSource.swift
//  DTARKit-Examples
//
//  Created by Dima Tsurkan on 9/15/17.
//  Copyright © 2017 Dima Tsurkan. All rights reserved.
//

import RxSwift
import IGListKit
import RxCocoa

protocol RxListAdapterDataSource {
    associatedtype Element
    func listAdapter(_ adapter: ListAdapter, observedEvent: Event<Element>) -> Void
}

extension Reactive where Base: ListAdapter {
    func items<DataSource: RxListAdapterDataSource & ListAdapterDataSource, O: ObservableType>(dataSource: DataSource)
        -> (_ source: O)
        -> Disposable where DataSource.Element == O.E {
            
            return { source in
                let subscription = source
                    .subscribe { dataSource.listAdapter(self.base, observedEvent: $0) }
                
                return Disposables.create {
                    subscription.dispose()
                }
            }
    }
    
    func setDataSource<DataSource: RxListAdapterDataSource & ListAdapterDataSource>(_ dataSource: DataSource) -> Disposable {
        base.dataSource = dataSource
        return Disposables.create()
    }
}
