//
//  LeadingViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 21.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class LeadingViewController: TextViewSlideViewController {

    @IBOutlet var sliders: [SliderView]!
    
    var paragraphStyle = NSMutableParagraphStyle()
    
    override func createAttributedString() -> NSAttributedString {
        let fontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.family : "Times New Roman"])
        let normalFont = UIFont(descriptor: fontDescriptor, size: 181)        
        let attributes = [NSAttributedStringKey.font : normalFont,
                          NSAttributedStringKey.foregroundColor : UIColor.darkText,
                          NSAttributedStringKey.paragraphStyle : paragraphStyle.copy()];
        let attributedString = NSMutableAttributedString(string: "yKbnyKbx", attributes: attributes)
    
        return attributedString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 40)
    }
    
    override func setupLayoutManager() {
        layoutManager.showBaseline = true
        layoutManager.showBoundingRect = true
        layoutManager.showBoundingRectHeight = true
        layoutManager.usesFontLeading = false;
        layoutManager.invalidateLayout(forCharacterRange: NSMakeRange(0, textStorage.length), actualCharacterRange: nil)
    }
    
    @IBAction func baselineValueChanged(_ sender: UISlider) {
        textStorage.addAttribute(NSAttributedStringKey.baselineOffset, value: sender.value, range: NSMakeRange(0, textStorage.length))
    }
    
    @IBAction func lineSpacingChanged(_ sender: UISlider) {
        paragraphStyle.lineSpacing = CGFloat(sender.value)
        updateParagraphStyleAttribute()
    }
    
    @IBAction func lineHeightMultipleChanged(_ sender: UISlider) {
        paragraphStyle.lineHeightMultiple = CGFloat(sender.value)
        updateParagraphStyleAttribute()
    }
    
    @IBAction func minimumLineHeightChanged(_ sender: UISlider) {
        paragraphStyle.minimumLineHeight = CGFloat(sender.value)
        updateParagraphStyleAttribute()
    }
    
    @IBAction func maximumLineHeightChanged(_ sender: UISlider) {
        paragraphStyle.maximumLineHeight = CGFloat(sender.value)
        updateParagraphStyleAttribute()
    }
    
    func updateParagraphStyleAttribute() {
        textStorage.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle.copy(), range: NSMakeRange(0, textStorage.length))
    }
    
    @IBAction func reset(_ sender: AnyObject) {
        paragraphStyle = NSMutableParagraphStyle()
        let range = NSMakeRange(0, textStorage.length)
        textStorage.removeAttribute(NSAttributedStringKey.paragraphStyle, range: range)
        textStorage.removeAttribute(NSAttributedStringKey.baselineOffset, range: range)
        
        for (_, sliderView) in sliders.enumerated() {
            sliderView.slider.value = (sliderView.slider.minimumValue + sliderView.slider.maximumValue)/2
            sliderView.valueLabel.text = String(format:"0")
        }
    }
}
