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
        
    fileprivate let avatarView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
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
    
    fileprivate let activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        view.startAnimating()
        return view
    }()
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addSubview(activityView)
        
        let bounds = contentView.bounds
        let avatarViewWidth: CGFloat = 25.0
        let avatarTopSpace = (bounds.height - avatarViewWidth) / 2.0
        let avatarLeftSpace: CGFloat = 8.0
        
        avatarView.frame = CGRect(x: avatarLeftSpace, y: avatarTopSpace, width: avatarViewWidth, height: avatarViewWidth)
        avatarView.layer.cornerRadius = min(avatarView.frame.height, avatarView.frame.width) / 2.0
        avatarView.layer.masksToBounds = true
        
        activityView.center = CGPoint(x: avatarView.frame.width/2.0, y: avatarView.frame.height/2.0)
        
        nameLabel.frame = CGRect(x: avatarView.frame.maxX + 8.0, y: avatarView.frame.minY, width: bounds.size.width - avatarView.frame.maxX - 8.0 * 2.0, height: avatarView.frame.height)
    }
    
    func setImage(image: UIImage?) {
        avatarView.image = image
        if image != nil {
            activityView.stopAnimating()
        } else {
            activityView.startAnimating()
        }
    }
    
}




