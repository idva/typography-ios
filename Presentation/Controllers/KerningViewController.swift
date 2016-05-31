//
//  KerningViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 18.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class KerningViewController: TextViewSlideViewController {
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var kerningSwitch: UISwitch!
    
    override func createAttributedString() -> NSAttributedString {
        let normalFont = UIFont.systemFontOfSize(200)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Center
        
        let attributes = [
            NSFontAttributeName : normalFont,
            NSForegroundColorAttributeName : UIColor.darkTextColor(),
            NSParagraphStyleAttributeName : paragraphStyle,
            NSKernAttributeName : 0
        ];
        
        let attributedString = NSAttributedString(string: "Tornado", attributes: attributes)
        return attributedString
    }
    
    
    @IBAction func toggleKerning(sender: UISwitch) {
        if sender.on {
            // Удаляем установленное ранее значение атрибута, оставляем значение по умолчанию
            self.textStorage.removeAttribute(NSKernAttributeName, range: NSMakeRange(0, self.textStorage.length))
        } else {
            // Если для NSKernAttributeName установить значение 0, то кернинг будет отключен
            self.updateKerningValue(0)
            self.slider.value = 0
            self.slider.sendActionsForControlEvents(.ValueChanged)
        }
    }
    
    @IBAction func sliderValueDidChange(sender: UISlider) {
        self.updateKerningValue(slider.value)
    }
    
    func updateKerningValue(value: Float) {
        self.textStorage.addAttribute(NSKernAttributeName, value: value, range: NSMakeRange(0, self.textStorage.length))
    }
}
