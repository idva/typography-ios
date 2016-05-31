//
//  TextStorageExampleViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 19.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class TextStorageExampleViewController: SlideViewController, UITextViewDelegate {

    @IBOutlet weak var textViewContainer: UIView!
    @IBOutlet weak var sourceView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextKitStack()
    }
    
    func setupTextKitStack() {
        // Создаем NSTextStorage
        let textStorage = TextStorage()
        textStorage.setAttributedString(self.createAttributedString())

        // Создаем NSLayoutManager и добавляем его в NSTextStorage
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        // Создаем NSTextContainer и добавляем его в NSLayoutManager
        let textContainer = NSTextContainer(size: self.textViewContainer.bounds.size)
        layoutManager.addTextContainer(textContainer)
        
        // Создаем UITextView c заданным NSTextContainer
        let textView = UITextView(frame: self.textViewContainer.bounds, textContainer: textContainer)
        textView.autocorrectionType = .No
        textView.keyboardType = .EmailAddress
        textView.backgroundColor = UIColor.clearColor()
        textViewContainer.addSubview(textView)
    }
    
    func createAttributedString() -> NSAttributedString {
        let normalFont = UIFont(name: "Georgia", size: 30)
        let attributes = [
            NSFontAttributeName : normalFont!
        ];
        let text = "Все докладчики приглашаются на фуршет :) Фуршет будет для вас бесплатен и очень вкусный (для всех) :) Начинается он в 31 мая, в 19:00 прямо в Сколково. Мы спустимся по широкой лестнице на зелёную лужайку и будем пировать. На случай дождя у нас есть багор и мешок с песком шатёр."
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        attributedString.addAttribute(NSStrikethroughStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: NSMakeRange(249, 22))
        return attributedString
    }
    
    @IBAction func tap(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.35, animations: { () -> Void in
            self.textViewContainer.alpha = 1 - self.textViewContainer.alpha
            self.sourceView.alpha = 1 - self.sourceView.alpha
        })
    }
}
