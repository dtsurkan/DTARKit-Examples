//
//  SearchSectionController.swift
//  DTARKit-Examples
//
//  Created by Dima Tsurkan on 9/12/17.
//  Copyright © 2017 Dima Tsurkan. All rights reserved.
//

import IGListKit

protocol SearchSectionControllerDelegate: class {
    func searchSectionController(_ sectionController: SearchSectionController, didChangeText text: String)
}

final class SearchSectionController: ListSectionController, UISearchBarDelegate, ListScrollDelegate {
    
    weak var delegate: SearchSectionControllerDelegate?
    
    override init() {
        super.init()
        scrollDelegate = self
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 44)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: SearchCell.self, for: self, at: index) as? SearchCell else {
            fatalError()
        }
        cell.searchBar.delegate = self
        return cell
    }
    
    // MARK: UISearchBarDelegate
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        delegate?.searchSectionController(self, didChangeText: searchBar.text ?? "")
    }
    
    // MARK: ListScrollDelegate
    
    func listAdapter(_ listAdapter: ListAdapter, didScroll sectionController: ListSectionController) {
        if let searchBar = (collectionContext?.cellForItem(at: 0, sectionController: self) as? SearchCell)?.searchBar {
            searchBar.text = ""
            searchBar.resignFirstResponder()
        }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, willBeginDragging sectionController: ListSectionController) {}
    func listAdapter(_ listAdapter: ListAdapter,
                     didEndDragging sectionController: ListSectionController,
                     willDecelerate decelerate: Bool) {}
    
}
