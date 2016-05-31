//
//  FontMetricksViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 18.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class FontMetricksViewController: TextViewSlideViewController {

    override func createAttributedString() -> NSAttributedString {
        let fontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptorFamilyAttribute : "Times New Roman"])
        let normalFont = UIFont(descriptor: fontDescriptor, size: 300)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Center
        
        let attributes = [NSFontAttributeName : normalFont, NSForegroundColorAttributeName : UIColor.darkTextColor(), NSParagraphStyleAttributeName : paragraphStyle];
        let attributedString = NSMutableAttributedString(string: "yKbx", attributes: attributes)
        return attributedString
    }
    
    override func setupLayoutManager() {
        self.layoutManager.showBaseline = true
        self.layoutManager.showMeanline = true
        self.layoutManager.showBoundingRect = true
    }
    
    @IBAction func capHeightSwitchValueChanged(sender: UISwitch) {
        self.layoutManager.showCapHeight = sender.on
        self.updateView()
    }
    @IBAction func xHeightSwitchValueChanged(sender: UISwitch) {
        self.layoutManager.showXHeight = sender.on
        self.updateView()
    }
    @IBAction func ascenderSwitchValueChanged(sender: UISwitch) {
        self.layoutManager.showAscender = sender.on
        self.updateView()
    }
    @IBAction func descenderHeightSwitchValueChanged(sender: UISwitch) {
        self.layoutManager.showDescender = sender.on
        self.updateView()
    }
    @IBAction func lineGapHeightSwitchValueChanged(sender: UISwitch) {
        self.layoutManager.showLineGap = sender.on
        self.updateView()
    }
    @IBAction func lineLineHeightSwitchValueChanged(sender: UISwitch) {
        self.layoutManager.showLineHeight = sender.on
        self.updateView()
    }
    
    func updateView() {
        self.layoutManager.invalidateDisplayForCharacterRange(NSMakeRange(0, self.textStorage.length))
    }
}
