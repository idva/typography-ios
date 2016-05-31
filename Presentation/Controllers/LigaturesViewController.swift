//
//  LigaturesViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 18.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class LigaturesViewController: TextViewSlideViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let options = ["Отключить лигатуры", "Обязательные лигатуры", "Все лигатуры"]

    @IBOutlet weak var pickerView: UIPickerView!

    override func createAttributedString() -> NSAttributedString {
        let normalFont = UIFont(name: "HoeflerText-Italic", size: 300)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Center
        
        let attributes = [
            NSFontAttributeName : normalFont!,
            NSForegroundColorAttributeName : UIColor.darkTextColor(),
            NSParagraphStyleAttributeName : paragraphStyle,
            NSLigatureAttributeName : 0
        ];
        
        let attributedString = NSAttributedString(string: "still", attributes: attributes)
        return attributedString
    }
    
    // MARK: - Picker View

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let normalFont = UIFont.systemFontOfSize(100.0)
        let attributes = [NSFontAttributeName : normalFont, NSForegroundColorAttributeName : UIColor.darkTextColor()];
        return NSAttributedString(string: "\(options[row])", attributes: attributes)
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.textStorage.addAttribute(NSLigatureAttributeName, value: row, range: NSMakeRange(0, self.textStorage.length))
    }
}
