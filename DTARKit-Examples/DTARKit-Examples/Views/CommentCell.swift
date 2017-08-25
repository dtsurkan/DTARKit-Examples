//
//  CommentCell.swift
//  DTARKit-Examples
//
//  Created by Dima Tsurkan on 8/25/17.
//  Copyright © 2017 Dima Tsurkan. All rights reserved.
//

import UIKit

final class CommentCell: UICollectionViewCell {
    
    lazy var commentLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 11)
        view.textColor = UIColor(red: 0.59, green: 0.59, blue: 0.57, alpha: 1.0)
        view.textAlignment = .left
        self.contentView.addSubview(view)
        return view
    }()
    
    var comment: String? {
        didSet {
            commentLabel.text = comment
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let bounds = self.contentView.bounds
        let leftPadding: CGFloat = 8.0
        
        commentLabel.frame = CGRect(x: leftPadding, y: 0, width: bounds.size.width - leftPadding * 2.0, height: bounds.size.height)
    }
}
