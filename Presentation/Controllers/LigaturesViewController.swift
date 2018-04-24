//
//  LigaturesViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 18.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class LigaturesViewController: TextViewSlideViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let options = ["No ligatures", "Default ligatures", "All ligatures"]
    
    @IBOutlet weak var pickerView: UIPickerView!

    override func createAttributedString() -> NSAttributedString {
        let normalFont = UIFont(name: "HoeflerText-Italic", size: 300)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        
        let attributes = [NSAttributedStringKey.font : normalFont!,
                          NSAttributedStringKey.foregroundColor : UIColor.darkText,
                          NSAttributedStringKey.paragraphStyle : paragraphStyle.copy(),
                          NSAttributedStringKey.ligature: 0];
        
        let attributedString = NSAttributedString(string: "still", attributes: attributes)
        return attributedString
    }
    
    // MARK: - Picker View

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let normalFont = UIFont.systemFont(ofSize: 100.0)
        let attributes = [NSAttributedStringKey.font : normalFont, NSAttributedStringKey.foregroundColor : UIColor.darkText];
        return NSAttributedString(string: "\(options[row])", attributes: attributes)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.textStorage.addAttribute(NSAttributedStringKey.ligature, value: row, range: NSMakeRange(0, self.textStorage.length))
    }
}
