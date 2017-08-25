//
//  InteractiveCell.swift
//  DTARKit-Examples
//
//  Created by Dima Tsurkan on 8/25/17.
//  Copyright © 2017 Dima Tsurkan. All rights reserved.
//

import UIKit

final class InteractiveCell: UICollectionViewCell {
    
    // MARK: - Properties

    static let buttonTitleColor = UIColor(red: 28/255.0, green: 30/255.0, blue: 8/255.0, alpha: 1.0)
    static let titleFont = UIFont.systemFont(ofSize: 12)
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Like", for: .normal)
        button.setTitleColor(InteractiveCell.buttonTitleColor, for: .normal)
        button.titleLabel?.font = InteractiveCell.titleFont
        button.sizeToFit()
        self.contentView.addSubview(button)
        return button
    }()
    
    lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setTitle("Comment", for: .normal)
        button.setTitleColor(InteractiveCell.buttonTitleColor, for: .normal)
        button.titleLabel?.font = InteractiveCell.titleFont
        button.sizeToFit()
        self.contentView.addSubview(button)
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.setTitleColor(InteractiveCell.buttonTitleColor, for: .normal)
        button.titleLabel?.font = InteractiveCell.titleFont
        button.sizeToFit()
        self.contentView.addSubview(button)
        return button
    }()
    
    lazy var separator: CALayer = {
        let layer = CALayer()
        layer.backgroundColor = UIColor(red: 200/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1.0).cgColor
        self.contentView.layer.addSublayer(layer)
        return layer
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
     
        let bounds = self.contentView.bounds
        let leftPadding: CGFloat = 8.0
        
        likeButton.frame = CGRect(x: leftPadding, y: 0, width: likeButton.frame.width, height: bounds.size.height)
        commentButton.frame = CGRect(x: leftPadding + likeButton.frame.maxX, y: 0, width: commentButton.frame.width, height: bounds.size.height)
        shareButton.frame = CGRect(x: leftPadding + commentButton.frame.maxX, y: 0, width: shareButton.frame.width, height: bounds.size.height)
        
        let height: CGFloat = 0.5
        separator.frame = CGRect(x: leftPadding, y: bounds.size.height - height, width: bounds.size.width - leftPadding, height: height)
    }
    
}
