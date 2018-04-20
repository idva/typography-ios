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
        let fontDescriptor = UIFontDescriptor(fontAttributes: [UIFontDescriptor.AttributeName.family : "Times New Roman"])
        let normalFont = UIFont(descriptor: fontDescriptor, size: 300)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        let attributes = [NSAttributedStringKey.font : normalFont, NSAttributedStringKey.foregroundColor : UIColor.darkText, NSAttributedStringKey.paragraphStyle : paragraphStyle];
        let attributedString = NSMutableAttributedString(string: "yKbx", attributes: attributes)
        return attributedString
    }
    
    override func setupLayoutManager() {
        self.layoutManager.showBaseline = true
        self.layoutManager.showMeanline = true
        self.layoutManager.showBoundingRect = true
    }
    
    @IBAction func capHeightSwitchValueChanged(_ sender: UISwitch) {
        self.layoutManager.showCapHeight = sender.isOn
        self.updateView()
    }
    @IBAction func xHeightSwitchValueChanged(_ sender: UISwitch) {
        self.layoutManager.showXHeight = sender.isOn
        self.updateView()
    }
    @IBAction func ascenderSwitchValueChanged(_ sender: UISwitch) {
        self.layoutManager.showAscender = sender.isOn
        self.updateView()
    }
    @IBAction func descenderHeightSwitchValueChanged(_ sender: UISwitch) {
        self.layoutManager.showDescender = sender.isOn
        self.updateView()
    }
    @IBAction func lineGapHeightSwitchValueChanged(_ sender: UISwitch) {
        self.layoutManager.showLineGap = sender.isOn
        self.updateView()
    }
    @IBAction func lineLineHeightSwitchValueChanged(_ sender: UISwitch) {
        self.layoutManager.showLineHeight = sender.isOn
        self.updateView()
    }
    
    func updateView() {
        self.layoutManager.invalidateDisplay(forCharacterRange: NSMakeRange(0, self.textStorage.length))
    }
}
