//
//  WebViewVC.swift
//  Favourite-Films
//
//  Created by Michael Jessey on 05/03/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var navBar: UINavigationItem!
    
    
    var webView: WKWebView!
    var incomingUrl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView()
        container.addSubview(webView)
        self.webView.navigationDelegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        let frame = CGRectMake(0, 0, container.bounds.width, container.bounds.height)
        webView.frame = frame
        
        loadWebRequest(incomingUrl)
    }
    
    func loadWebRequest(urlString: String) {
        let urlStr = urlString
        let url = NSURL(string: urlStr)!
        let request = NSURLRequest(URL: url)
        
        webView.loadRequest(request)
    }
    
    // Display a loading indicator in the status bar when the requested web page is loading.
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}
