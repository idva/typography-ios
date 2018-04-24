//
//  TextViewInsetsViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 25.05.16.
//  Copyright © 2016 RC. All rights reserved.
//

import UIKit

class TextViewInsetsViewController: TextViewSlideViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBInspectable var lineFragmentPadding:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textContainer.lineFragmentPadding = lineFragmentPadding
        textViewContainer.bringSubview(toFront: imageView)
        textView.isScrollEnabled = false
        updateExclusionPath()
        
        layoutManager.hyphenationFactor = 1.0
    }
    
    override func setupLayoutManager() {
        layoutManager.showBoundingRect = false
        layoutManager.showLineFragment = false
    }
    
    override func createAttributedString() -> NSAttributedString {
        let normalFont = UIFont(name: "Georgia", size: 25)
        let attributes = [
            NSAttributedStringKey.font : normalFont!
        ];
        let text = "CHAPTER 1. Among other public buildings in a certain town, which for many reasons it will be prudent to refrain from mentioning, and to which I will assign no fictitious name, there is one anciently common to most towns, great or small: to wit, a workhouse; and in this workhouse was born; on a day and date which I need not trouble myself to repeat, inasmuch as it can be of no possible consequence to the reader, in this stage of the business at all events; the item of mortality whose name is prefixed to the head of this chapter. For a long time after it was ushered into this world of sorrow and trouble, by the parish surgeon, it remained a matter of considerable doubt whether the child would survive to bear any name at all; in which case it is somewhat more than probable that these memoirs would never have appeared; or, if they had, that being comprised within a couple of pages, they would have possessed the inestimable merit of being the most concise and faithful specimen of biography, extant in the literature of any age or country."
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        return attributedString
    }

    @IBAction func textContainerInsetValueChanged(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        textView.textContainerInset = UIEdgeInsetsMake(value, value, value, value)
        updateExclusionPath()
    }
    
    @IBAction func lineFragmentPaddingValueChanged(_ sender: UISlider) {
        textContainer.lineFragmentPadding = CGFloat(sender.value)
    }

    @IBAction func toggleLineFragments(_ sender: UISlider) {
        layoutManager.showLineFragment = !layoutManager.showLineFragment
        let range = NSMakeRange(0, textStorage.length)
        layoutManager.invalidateDisplay(forCharacterRange: range)
    }
    
    @IBAction func toggleTextViewBackgroundColor(_ sender: UISlider) {
        let hasNoColor = textView.backgroundColor!.isEqual(UIColor.clear)
        if hasNoColor {
            textView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        } else {
            textView.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func hyphenationFactorValueChanged(_ sender: UISlider) {
        layoutManager.hyphenationFactor = CGFloat(sender.value)
    }
    
    func updateExclusionPath() {
        var exclusionRect = imageView.frame
        exclusionRect = exclusionRect.offsetBy(dx: -textView.textContainerInset.left, dy: -textView.textContainerInset.top)
        let exclusionPath = UIBezierPath(rect: exclusionRect)
        textView.textContainer.exclusionPaths = [exclusionPath]
    }

}
