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
        let normalFont = UIFont.systemFont(ofSize: 200)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        let attributes = [NSAttributedStringKey.font : normalFont,
                          NSAttributedStringKey.foregroundColor : UIColor.darkText,
                          NSAttributedStringKey.paragraphStyle : paragraphStyle.copy(),
                          NSAttributedStringKey.kern: 0];
        
        let attributedString = NSAttributedString(string: "Tornado", attributes: attributes)
        return attributedString
    }
    
    
    @IBAction func toggleKerning(_ sender: UISwitch) {
        if sender.isOn {
            // Удаляем установленное ранее значение атрибута, оставляем значение по умолчанию
            self.textStorage.removeAttribute(NSAttributedStringKey.kern, range: NSMakeRange(0, self.textStorage.length))
        } else {
            // Если для NSKernAttributeName установить значение 0, то кернинг будет отключен
            self.updateKerningValue(0)
            self.slider.value = 0
            self.slider.sendActions(for: .valueChanged)
        }
    }
    
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        self.kerningSwitch.setOn(slider.value != 0, animated: true)
        self.updateKerningValue(slider.value)
    }
    
    func updateKerningValue(_ value: Float) {
        self.textStorage.addAttribute(NSAttributedStringKey.kern, value: value, range: NSMakeRange(0, self.textStorage.length))
    }
}
