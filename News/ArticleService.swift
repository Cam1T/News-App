//
//  ArticleService.swift
//  News
//
//  Created by USER on 24/07/2020.
//  Copyright © 2020 CJAPPS. All rights reserved.
//

import Foundation

struct ArticleService : Decodable {
    
    var totalResults:Int?
    var articles:[Article]?
}
