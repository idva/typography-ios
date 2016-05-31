//
//  ParagraphStyleViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 20.05.16.
//  Copyright © 2016 RC. All rights reserved.
//

import UIKit

class ParagraphStyleViewController: TextViewSlideViewController {
    
    @IBOutlet var sliders: [SliderView]!
    
    var paragraphStyle = NSMutableParagraphStyle()

    override func createAttributedString() -> NSAttributedString {
        let fontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute : "Times New Roman"])
        let normalFont = UIFont(descriptor: fontDescriptor, size: 38)
        
        let attributes = [NSFontAttributeName : normalFont,
                          NSForegroundColorAttributeName : UIColor.darkTextColor(),
                          NSParagraphStyleAttributeName : paragraphStyle.copy()];
        let attributedString = NSMutableAttributedString(string: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\nUt enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", attributes: attributes)
        return attributedString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.textContainerInset = UIEdgeInsetsZero
    }
    
    override func setupLayoutManager() {
        layoutManager.showLineFragment = true
        layoutManager.showBoundingRectHeight = true
        layoutManager.usesFontLeading = false;
        layoutManager.invalidateLayoutForCharacterRange(NSMakeRange(0, textStorage.length), actualCharacterRange: nil)
    }
    
    @IBAction func paragraphSpacingValueChanged(sender: UISlider) {
        paragraphStyle.paragraphSpacing = CGFloat(sender.value)
        updateParagraphStyleAttribute()
    }
    
    @IBAction func paragraphSpacingBeforeValueChanged(sender: UISlider) {
        paragraphStyle.paragraphSpacingBefore = CGFloat(sender.value)
        updateParagraphStyleAttribute()
    }
    
    @IBAction func paragraphStyleHeadIndentValueChanged(sender: UISlider) {
        paragraphStyle.headIndent = CGFloat(sender.value)
        updateParagraphStyleAttribute()
    }
    
    @IBAction func paragraphStyleTailIndentValueChanged(sender: UISlider) {
        paragraphStyle.tailIndent = CGFloat(sender.value)
        updateParagraphStyleAttribute()
    }
    
    @IBAction func paragraphStyleFirstLineHeadIndentValueChanged(sender: UISlider) {
        paragraphStyle.firstLineHeadIndent = CGFloat(sender.value)
        updateParagraphStyleAttribute()
    }
    
    func updateParagraphStyleAttribute() {
        textStorage.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle.copy(), range: NSMakeRange(0, textStorage.length))
    }
    
    @IBAction func reset(sender: AnyObject) {
        paragraphStyle = NSMutableParagraphStyle()
        let range = NSMakeRange(0, textStorage.length)
        textStorage.removeAttribute(NSParagraphStyleAttributeName, range: range)
        
        for (_, sliderView) in sliders.enumerate() {
            sliderView.slider.value = (sliderView.slider.minimumValue + sliderView.slider.maximumValue)/2
            sliderView.valueLabel.text = String(format:"0")
        }
    }
}
