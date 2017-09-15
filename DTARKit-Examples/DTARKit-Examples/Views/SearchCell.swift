//
//  SearchCell.swift
//  DTARKit-Examples
//
//  Created by Dima Tsurkan on 9/12/17.
//  Copyright © 2017 Dima Tsurkan. All rights reserved.
//

import UIKit

final class SearchCell: UICollectionViewCell {
    
    lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        self.contentView.addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = contentView.bounds
    }
    
}
