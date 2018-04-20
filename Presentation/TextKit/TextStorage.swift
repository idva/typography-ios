//
//  TextStorage.swift
//  TextAttributesDemo
//
//  Created by Irina Dyagileva on 13.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

/**
@author Irina Dyagileva

TextStorage, подменяющий & в подстроке Rambler&Co на картинку
*/
class TextStorage: NSTextStorage {
    // Хранилище данных
    var innerAttributedString = NSMutableAttributedString()

    override var string: String {
        return innerAttributedString.string
    }
   
    override func attributes(at location: Int, effectiveRange range: NSRangePointer?) -> [NSAttributedStringKey : Any] {
        return innerAttributedString.attributes(at: location, effectiveRange: range)
    }
    
    override func replaceCharacters(in range: NSRange, with str: String) {
        beginEditing()
        innerAttributedString.replaceCharacters(in: range, with:str)
        edited([.editedCharacters, .editedAttributes], range: range, changeInLength: str.characters.count - range.length)
        endEditing()
    }
    
    override func setAttributes(_ attrs: [NSAttributedStringKey : Any]!, range: NSRange) {
        beginEditing()
        innerAttributedString.setAttributes(attrs, range: range)
        edited(.editedAttributes, range: range, changeInLength: 0)
        endEditing()
    }
    
    override func processEditing() {
        let extendedRange = (self.string as NSString).paragraphRange(for: editedRange)
        
        removeAttribute(NSAttributedStringKey.backgroundColor, range: extendedRange)
        
        let pattern = "@channel"
        let regex = try! NSRegularExpression(pattern: pattern, options: [.caseInsensitive])
        
        regex.enumerateMatches(in: innerAttributedString.string, options: [], range: extendedRange) {
            match, flags, stop in
            self.innerAttributedString.addAttribute(NSAttributedStringKey.backgroundColor,
                                                    value: UIColor.yellow,
                                                    range: match!.range)
        }
        
        super.processEditing()
    }
}

