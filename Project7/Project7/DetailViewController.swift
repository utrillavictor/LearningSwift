//
//  DetailViewController.swift
//  Project7
//
//  Created by Victor Cordero Utrilla on 11/2/16.
//  Copyright © 2016 utrillavictor. All rights reserved.
//
import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var detailItem: [String: String]!

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard detailItem != nil else { return }

        if let body = detailItem["body"] {
            var html = "<html>"
            html += "<head>"
            html += "<meta name=\"viewport\" content=\"with=device-width, initial-scale=1\">"
            html += "<style> body { font-size: 150%; } </style>"
            html += "</head>"
            html += "<body>"
            html += body
            html += "</body>"
            html += "</html>"
            webView.loadHTMLString(html, baseURL: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
