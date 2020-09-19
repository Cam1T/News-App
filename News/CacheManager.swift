//
//  CacheManager.swift
//  News
//
//  Created by USER on 26/07/2020.
//  Copyright © 2020 CJAPPS. All rights reserved.
//

import Foundation

class CacheManager {
    
    static var imageDictionairy = [String:Data]()
    static func saveData(_ url:String, _ imageData:Data) {
        
        // Save the image data along with the url
        imageDictionairy[url] = imageData
        
    }
    
    static func retrieveData(_ url:String) -> Data? {
        
        // Return the saved image data or nil
        return imageDictionairy[url]
    }
}
