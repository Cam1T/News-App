//
//  ArticleModal.swift
//  News
//
//  Created by USER on 24/07/2020.
//  Copyright © 2020 CJAPPS. All rights reserved.
//

import Foundation

protocol ArticleModeProtocol {
    
    func articlesRetrieved(_ articles:[Article])
}

class ArticleModel {
    
    var delegate:ArticleModeProtocol?
    
    func getArticles() {
        
        // Fire off the request to the API
        
        // Create a string URL
        let stringURL = "http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=0dad8e86204a493681019b2797e1cdac"
        
        // Create a URL object
        let url = URL(string: stringURL)
        
        // Check that it isnt nil
        guard url != nil else {
            print("couldn't create a url object")
            return
        }
        
        // Get the URL Session
        let session = URLSession.shared
        
        // Create the data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check that there are no errors and that there is data
            if error == nil && data != nil {
                
                // Attempt to parse the JSON
                let decoder = JSONDecoder()
                
                do {
                    // Parse the Json into ArticleService
                    let articleService = try decoder.decode(ArticleService.self, from: data!)
                    
                    // Get the articles
                    let articles = articleService.articles!
                    
                    // Parse it back to the view controller in the main thread
                    DispatchQueue.main.async {
                        self.delegate?.articlesRetrieved(articles)
                        
                    }
                }
                    
                catch {
                    
                    print("Error parsing the JSON")
                }
                
            }
        }
        
        // Start the data task
        dataTask.resume()
    }
}
