//
//  BotlImageCache.swift
//  Botl
//
//  Created by Dima Tsurkan on 9/6/17.
//  Copyright © 2017 Botl. All rights reserved.
//

import Foundation
import UIKit

let spm_identifier  = "com.botlimagecache.tg"

final class BotlImageCache: NSObject {
    var cachePath: URL?
    let fileManager = FileManager.default
    
    override init() {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let rootCachePath = paths[0]
        
        
        cachePath = URL(string: rootCachePath)?.appendingPathComponent(spm_identifier)
        
        if let path = cachePath, !fileManager.fileExists(atPath:path.absoluteString) {
            do {
                try fileManager.createDirectory(atPath: path.absoluteString, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error)
            }
        }
        super.init()
    }
    
    func save(image: UIImage?, atURL URL: URL) {
        guard let image = image else { return }
        
        let fileExtension = URL.pathExtension
        var data : NSData?
        if fileExtension == "png" {
            data = UIImagePNGRepresentation(image) as NSData?
        } else if fileExtension == "jpg" || fileExtension == "jpeg" {
            data = UIImageJPEGRepresentation(image, 1.0) as NSData?
        }
        
        guard let imageData = data, let cachePath = self.cachePath else { return }
        imageData.write(toFile: cachePath.appendingPathComponent(String(format: "%u.%@", URL.absoluteString.hash, fileExtension)).absoluteString, atomically: true)
        
    }
    
    func image(forURL URL: URL) -> UIImage? {
        if  let path = self.cachePath?.appendingPathComponent(String(format: "%u.%@", URL.absoluteString.hash, URL.pathExtension)),
            self.fileManager.fileExists(atPath: path.absoluteString) {
            
            if let data = NSData(contentsOfFile: path.absoluteString) {
                return UIImage(data: data as Data)
            }
        }
        return nil
    }
}
