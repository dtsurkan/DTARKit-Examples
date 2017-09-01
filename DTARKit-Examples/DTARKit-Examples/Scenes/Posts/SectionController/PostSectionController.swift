//
//  PostSectionController.swift
//  DTARKit-Examples
//
//  Created by Dima Tsurkan on 8/25/17.
//  Copyright © 2017 Dima Tsurkan. All rights reserved.
//

import Foundation
import IGListKit

final class PostSectionController: ListSectionController {
    
    private var displayedPost: Posts.FetchPosts.ViewModel.DisplayedPost?
    private let cellsBeforeComments = 3
    private var downloadedImage: UIImage?
    private var downloadedUserAvatarImage: UIImage?
    private var task: URLSessionDataTask?
    private var userAvatarDataTask: URLSessionDataTask?
    
    deinit {
        task?.cancel()
    }
    
    override init() {
        super.init()
        workingRangeDelegate = self
    }
    
    override func numberOfItems() -> Int {
        return cellsBeforeComments + (displayedPost?.comments.count)! 
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let width = self.collectionContext?.containerSize.width ?? 0
        var height: CGFloat = 0
        if index == 0 || index == 2 {
            height = 41
        } else if index == 1 {
            height = width // square
        } else {
            height = 25
        }
        return CGSize(width: width, height: height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        if index == 0 {
            cell = collectionContext!.dequeueReusableCell(of: UserInfoCell.self, for: self, at: index) as! UserInfoCell
            (cell as! UserInfoCell).name = displayedPost?.username
            (cell as! UserInfoCell).setImage(image: downloadedUserAvatarImage)
        } else if index == 1 {
            cell = collectionContext!.dequeueReusableCell(of: PhotoCell.self, for: self, at: index) as! PhotoCell
             (cell as! PhotoCell).setImage(image: downloadedImage)
        } else if index == 2 {
            cell = collectionContext!.dequeueReusableCell(of: InteractiveCell.self, for: self, at: index) as! InteractiveCell
        } else {
            cell = collectionContext!.dequeueReusableCell(of: CommentCell.self, for: self, at: index) as! CommentCell
            (cell as! CommentCell).comment = displayedPost?.comments[index - cellsBeforeComments]
        }
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        self.displayedPost = object as? Posts.FetchPosts.ViewModel.DisplayedPost
    }
}


// MARK: - ListWorkingRangeDelegate

extension PostSectionController: ListWorkingRangeDelegate {
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        if sectionController.section == 0 {
            guard downloadedUserAvatarImage == nil,
                userAvatarDataTask == nil,
                let urlString = displayedPost?.photoURL,
                let url = URL(string: urlString)
                else { return }
            
            userAvatarDataTask = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, let image = UIImage(data: data) else {
                    return print("Error downloading \(urlString): " + String(describing: error))
                }
                DispatchQueue.main.async {
                    self.downloadedUserAvatarImage = image
                    if let cell = self.collectionContext?.cellForItem(at: 0, sectionController: self) as? UserInfoCell {
                        cell.setImage(image: image)
                    }
                }
            }
            userAvatarDataTask?.resume()
        }
        
        guard downloadedImage == nil,
            task == nil,
            let urlString = displayedPost?.photoURL,
            let url = URL(string: urlString)
            else { return }
        
        print("Downloading image \(urlString) for section \(self.section)")
        
        task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, let image = UIImage(data: data) else {
                return print("Error downloading \(urlString): " + String(describing: error))
            }
            DispatchQueue.main.async {
                self.downloadedImage = image
                if let cell = self.collectionContext?.cellForItem(at: 1, sectionController: self) as? PhotoCell {
                    cell.setImage(image: image)
                }
            }
        }
        task?.resume()
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) { }
}


