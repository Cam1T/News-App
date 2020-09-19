//
//  DetailViewController.swift
//  News
//
//  Created by USER on 25/07/2020.
//  Copyright © 2020 CJAPPS. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet var webView: WKWebView!
    
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    var articleUrl:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Check that there's a url
        if articleUrl != nil {
            
            // Create the URL object
            let url = URL(string: articleUrl!)
            guard url != nil else {
                // Couldn't create the URL Object
                return
            }
            
            // Create the URLRequest object
            let request = URLRequest(url: url!)
            
            // Start spinner
            spinner.alpha = 1
            spinner.startAnimating()
        
            // Load it in the webview
            webView.load(request)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        // Stop the spinner and hide it
        spinner.stopAnimating()
        spinner.alpha = 0
    }
}
