//
//  ActionViewController.swift
//  Extension
//
//  Created by Victor Cordero Utrilla on 11/15/16.
//  Copyright © 2016 utrillavictor. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var script: UITextView!

    var pageTitle = ""
    var pageUrl = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide , object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))

        if let inputItem = extensionContext!.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first as? NSItemProvider {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [unowned self] (dict, error) in
                    let itemDictionary = dict as! NSDictionary
                    let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as! NSDictionary

                    self.pageTitle = javaScriptValues["title"] as! String
                    self.pageUrl = javaScriptValues["URL"] as! String

                    DispatchQueue.main.async {
                        self.title = self.pageTitle
                    }
                }
            }
        }
    }

    func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!

        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == Notification.Name.UIKeyboardWillHide {
            script.contentInset = UIEdgeInsets.zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }

        script.scrollIndicatorInsets = script.contentInset

        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }

    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]

        extensionContext!.completeRequest(returningItems: [item])
    }

}
