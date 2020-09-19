//
//  Article.swift
//  News
//
//  Created by USER on 24/07/2020.
//  Copyright © 2020 CJAPPS. All rights reserved.
//

import Foundation

struct Article : Decodable {
    
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
}
