//
//  ArticleCell.swift
//  News
//
//  Created by USER on 25/07/2020.
//  Copyright © 2020 CJAPPS. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet var articleImageView: UIImageView!
    
    @IBOutlet var headlineLabel: UILabel!
    
    var articleToDisplay:Article?
    
    func displayArticle(_ article:Article) {
        
        // Clean up the cell before displaying the next article
        articleImageView.image = nil
        articleImageView.alpha = 0
        headlineLabel.text = ""
        headlineLabel.alpha = 0
        
        // Keep a reference to the article
        articleToDisplay = article
        
        // Set the headline
        headlineLabel.text = articleToDisplay!.title
        
        // Animate the label into view
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            
            self.headlineLabel.alpha = 1
        
        }, completion: nil)
        
        // Download and display the image
        
        // Check that the article actually has an image
        guard articleToDisplay!.urlToImage != nil else {
            return
        }
        // Create a url string
        let urlString = articleToDisplay!.urlToImage!
        
        // Check the cachemanager before downloading any image data
        if let imageData = CacheManager.retrieveData(urlString) {
            
            // There is image data, set the imageview and return
            articleImageView.image = UIImage(data: imageData)
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.articleImageView.alpha = 1
            
            }, completion: nil)
            
            return
        }
        
        // Create the url
        let url = URL(string: urlString)
        
        // Check that the url isn't nil
        guard url != nil else {
            print("Couldn't create url object")
            return
        }
        // Get a URLSession
        let session = URLSession.shared
        
        // Create a datatask
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
                // Check that there were no errors
                if error == nil && data != nil {
                    
                // Save the data into cache
                    CacheManager.saveData(urlString, data!)
                
                    // Check if the url string that the data went off to download matches the article this cell is set to display
                
                if self.articleToDisplay!.urlToImage == urlString {
                    
                    DispatchQueue.main.async {
                        // Display the image data in the image view
                        self.articleImageView.image = UIImage(data: data!)
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            
                            self.articleImageView.alpha = 1
                        
                        }, completion: nil)
                    
                     }

                    }
                     
                } // End if
                    
            } // End off the dataTask
                
                // Kick off the database
                dataTask.resume()
        }
            
            override func awakeFromNib() {
                super.awakeFromNib()
                
                // Initialization code
            }
            
            override func setSelected(_ selected: Bool, animated: Bool) {
                super.setSelected(selected, animated: animated)
                
                // Configure the view for the selected state
            }
            
        }
