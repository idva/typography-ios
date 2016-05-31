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
   
    override func attributesAtIndex(location: Int, effectiveRange range: NSRangePointer) -> [String : AnyObject] {
        return innerAttributedString.attributesAtIndex(location, effectiveRange: range)
    }
    
    override func replaceCharactersInRange(range: NSRange, withString str: String) {
        beginEditing()
        innerAttributedString.replaceCharactersInRange(range, withString:str)
        edited([.EditedCharacters, .EditedAttributes], range: range, changeInLength: str.characters.count - range.length)
        endEditing()
    }
    
    override func setAttributes(attrs: [String : AnyObject]!, range: NSRange) {
        beginEditing()
        innerAttributedString.setAttributes(attrs, range: range)
        edited(.EditedAttributes, range: range, changeInLength: 0)
        endEditing()
    }
    
    override func processEditing() {
        let extendedRange = (self.string as NSString).paragraphRangeForRange(editedRange)
        
        removeAttribute(NSBackgroundColorAttributeName, range: extendedRange)
        
        let pattern = "@channel"
        let regex = try! NSRegularExpression(pattern: pattern, options: [.CaseInsensitive])
        
        regex.enumerateMatchesInString(innerAttributedString.string, options: [], range: extendedRange) {
            match, flags, stop in
            self.innerAttributedString.addAttribute(NSBackgroundColorAttributeName,
                                                    value: UIColor.yellowColor(),
                                                    range: match!.range)
        }
        
        super.processEditing()
    }
}

