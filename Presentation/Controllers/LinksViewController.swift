//
//  LinksViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 24/07/15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class LinksViewController: SlideViewController {

    @IBOutlet weak var textKitTextView: UITextView!
    @IBOutlet weak var attributedStringTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textKitUrl = NSURL(string: "https://developer.apple.com/library/ios/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/CustomTextProcessing/CustomTextProcessing.html")
        textKitTextView.textStorage.addAttribute(NSLinkAttributeName, value: textKitUrl!, range: NSMakeRange(1, textKitTextView.textStorage.length-1))
        
        let attributedStringUrl = NSURL(string: "https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/AttributedStrings/Articles/standardAttributes.html")
        attributedStringTextView.textStorage.addAttribute(NSLinkAttributeName, value: attributedStringUrl!, range: NSMakeRange(1, attributedStringTextView.textStorage.length-1))
    }
}
