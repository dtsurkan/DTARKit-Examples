//
//  UserInfoCell.swift
//  DTARKit-Examples
//
//  Created by Dima Tsurkan on 8/25/17.
//  Copyright © 2017 Dima Tsurkan. All rights reserved.
//

import UIKit

final class UserInfoCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    lazy var avatarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 210/255.0, green: 65/255.0, blue: 64/255.0, alpha: 1.0)
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 15)
        view.textColor = .darkText
        view.textAlignment = .left
        self.contentView.addSubview(view)
        return view
    }()
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let bounds = contentView.bounds
        let avatarViewWidth: CGFloat = 25.0
        let avatarTopSpace = (bounds.height - avatarViewWidth) / 2.0
        let avatarLeftSpace: CGFloat = 8.0
        
        avatarView.frame = CGRect(x: avatarLeftSpace, y: avatarTopSpace, width: avatarViewWidth, height: avatarViewWidth)
        avatarView.layer.cornerRadius = min(avatarView.frame.height, avatarView.frame.width) / 2.0
        avatarView.layer.masksToBounds = true
        
        nameLabel.frame = CGRect(x: avatarView.frame.maxX + 8.0, y: avatarView.frame.minY, width: bounds.size.width - avatarView.frame.maxX - 8.0 * 2.0, height: avatarView.frame.height)
    }
    
}




