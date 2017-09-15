//
//  TumblrSectionController.swift
//  DTARKit-Examples
//
//  Created by Dima Tsurkan on 9/12/17.
//  Copyright © 2017 Dima Tsurkan. All rights reserved.
//

import Foundation
import IGListKit

final class TumblrSectionController: ListSectionController {
    
    private var displayedPhoto: Tumblr.FetchImages.ViewModel.DisplayedPhoto?
    private var task: URLSessionDataTask?
    private var cache = BotlImageCache()
    
    deinit {
        task?.cancel()
    }
    
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        workingRangeDelegate = self
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: 300, height: 300)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        let cell = collectionContext!.dequeueReusableCell(of: PhotoCell.self, for: self, at: index) as! PhotoCell
        cell.setImage(image: displayedPhoto?.resizedImage)
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        displayedPhoto = object as? Tumblr.FetchImages.ViewModel.DisplayedPhoto
    }
    
    override func didSelectItem(at index: Int) {
        (viewController as! TumblrViewController).router?.routeToShowDetails(displayedPhoto: displayedPhoto)
    }
    
}

// MARK: - ListWorkingRangeDelegate

extension TumblrSectionController: ListWorkingRangeDelegate {
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        guard displayedPhoto?.resizedImage == nil,
            task == nil,
            let urlString = displayedPhoto?.url,
            let url = URL(string: urlString)
            else { return }
    
        let cachedImage = cache.image(forURL: URL(string: (displayedPhoto?.url)!)!)
        
        if cachedImage != nil {
            DispatchQueue.main.async {
                self.displayedPhoto?.resizedImage = cachedImage?.resize(toWidth: 300, toHeight: 300)
                if let cell = self.collectionContext?.cellForItem(at: 0, sectionController: self) as? PhotoCell {
                    cell.setImage(image: cachedImage)
                }
            }
        } else {
            task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                guard let data = data, let image = UIImage(data: data) else {
                    return print("Error downloading \(urlString): " + String(describing: error))
                }
                
                DispatchQueue.main.async {
                    self.displayedPhoto?.originalImage = image
                    self.displayedPhoto?.resizedImage = image.resize(toWidth: 300, toHeight: 300)
                    self.cache.save(image: self.displayedPhoto?.resizedImage, atURL: URL(string: (self.displayedPhoto?.url)!)!)
                    if let cell = self.collectionContext?.cellForItem(at: 0, sectionController: self) as? PhotoCell {
                        cell.setImage(image: image)
                    }
                }
            })
            task?.resume()
        }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) { }
        
}

