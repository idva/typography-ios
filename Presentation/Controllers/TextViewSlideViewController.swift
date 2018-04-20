//
//  TextViewSlideViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 18.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class TextViewSlideViewController: SlideViewController {
   
    @IBOutlet weak var textViewContainer: UIView!
    
    var layoutManager: LayoutManager!
    var textContainer: NSTextContainer!
    var textStorage: NSTextStorage!
    var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextKitStack()
        setupLayoutManager()
    }
    
    func setupTextKitStack() {
        // Создаем NSTextStorage
        textStorage = NSTextStorage(attributedString: self.createAttributedString())
        
        // Создаем NSLayoutManager и добавляем его в NSTextStorage
        layoutManager = LayoutManager()
        textStorage.addLayoutManager(layoutManager)

        // Создаем NSTextContainer и добавляем его в NSLayoutManager
        textContainer = NSTextContainer(size: textViewContainer.bounds.size)
        textContainer.lineFragmentPadding = 0
        layoutManager.addTextContainer(textContainer)
        
        // Создаем UITextView c заданным NSTextContainer
        textView = UITextView(frame: textViewContainer.bounds, textContainer: textContainer)
        textView.backgroundColor = UIColor.clear
        textView.textContainerInset = UIEdgeInsets.zero
        textView.isEditable = false
        textViewContainer.addSubview(textView)
    }
    
    func setupLayoutManager() {
        self.layoutManager.showBoundingRect = true
    }
    
    func createAttributedString() -> NSAttributedString {
        return NSAttributedString()
    }
}
