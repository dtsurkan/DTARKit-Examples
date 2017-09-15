//
//  UIImage+Extention.swift
//  DTARKit-Examples
//
//  Created by Dima Tsurkan on 9/15/17.
//  Copyright © 2017 Dima Tsurkan. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resize(toWidth width: CGFloat, toHeight height: CGFloat) -> UIImage? {
        let size = self.size
        
        let widthRatio  = width  / self.size.width
        let heightRatio = height / self.size.height
        
        var newSize: CGSize
        if (widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func dataRepresentation() -> Data? {
        return UIImagePNGRepresentation(self) as Data?
    }
    
}
