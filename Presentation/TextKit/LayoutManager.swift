//
//  LayoutManager.swift
//  TextAttributesDemo
//
//  Created by Irina Dyagileva on 19.06.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

/**
 @author Irina Dyagileva
 
 LayoutManager, that can highlight font metrics
 */
class LayoutManager: NSLayoutManager {
    
    var showBaseline = false
    var showBoundingRect = false
    var showMeanline = false
    var showCapHeight = false
    var showXHeight = false
    var showAscender = false
    var showDescender = false
    var showLineGap = false
    var showLineHeight = false
    var showLineFragment = false
    var showBoundingRectHeight = false

    override func drawUnderlineForGlyphRange(glyphRange: NSRange, underlineType underlineVal: NSUnderlineStyle, baselineOffset: CGFloat, lineFragmentRect lineRect: CGRect, lineFragmentGlyphRange lineGlyphRange: NSRange, containerOrigin: CGPoint) {
        
        // Левая и правая X соордината фрагмента строки
        let firstPointX =  CGRectGetMinX(lineRect) + containerOrigin.x
        let secondPointX =  CGRectGetMaxX(lineRect) + containerOrigin.x
        
        let firstPointY =  CGRectGetMinY(lineRect) + containerOrigin.y
        let secondPointY =  CGRectGetMaxY(lineRect) + containerOrigin.y
        
        // Y координата линии шрифта
        let baselineOriginY = ceil(secondPointY - baselineOffset)
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)
        CGContextSetLineWidth(context, 2.0)
        
        // Достаем шрифт из атрибута первого символа
        if let glyphFont = self.textStorage?.attribute(NSFontAttributeName, atIndex: glyphRange.location, effectiveRange: nil) as? UIFont {
            
            if self.showLineFragment  {
                UIColor.magentaColor().set()
                let lineRect = CGRectMake(firstPointX, firstPointY, lineRect.width, lineRect.height)
                UIBezierPath(rect: lineRect).stroke()
            }
            
            if self.showAscender {
                UIColor(hex: 0x8C78A4).set()
                let ascenderRect = CGRectMake(firstPointX, firstPointY, lineRect.width, glyphFont.ascender)
                CGContextFillRect(context, ascenderRect)
            }
            
            if self.showDescender {
                UIColor(hex: 0x88C288).set()
                let descenderRect = CGRectMake(firstPointX, baselineOriginY, lineRect.width, -glyphFont.descender)
                CGContextFillRect(context, descenderRect)
            }
            
            if self.showXHeight {
                let xHeightOriginY = baselineOriginY - glyphFont.xHeight
                UIColor(hex: 0xF3E0AB).set()
                let xHeightRect = CGRectMake(firstPointX, xHeightOriginY, lineRect.width, glyphFont.xHeight)
                CGContextFillRect(context, xHeightRect)
            }
            
            if self.showCapHeight {
                UIColor(hex: 0xF3ABAB).set()
                let originY = baselineOriginY - glyphFont.capHeight
                let capHeightRect = CGRectMake(firstPointX, originY, lineRect.width, glyphFont.capHeight)
                CGContextFillRect(context, capHeightRect)
            }
            
            if self.showLineGap {
                let height = glyphFont.leading;
                let originY = secondPointY - glyphFont.leading;
                UIColor(hex: 0x66A6DB).set()
                let leadingRect = CGRectMake(firstPointX, originY, lineRect.width, height)
                CGContextFillRect(context, leadingRect)
            }
            
            if self.showLineHeight {
                UIColor.lightGrayColor().set()
                let ascenderRect = CGRectMake(firstPointX, firstPointY, lineRect.width, glyphFont.lineHeight)
                CGContextFillRect(context, ascenderRect)
            }
            
            if self.showMeanline {
                let xHeightOriginY = baselineOriginY - glyphFont.xHeight
                UIColor.blueColor().set()
                CGContextMoveToPoint(context, firstPointX, xHeightOriginY)
                CGContextAddLineToPoint(context,secondPointX, xHeightOriginY)
                CGContextStrokePath(context)
            }
        }
        
        if self.showBaseline {
            UIColor.redColor().set()
            CGContextMoveToPoint(context, firstPointX, baselineOriginY)
            CGContextAddLineToPoint(context,secondPointX, baselineOriginY)
            CGContextStrokePath(context)
        }
        
        if self.showBoundingRectHeight {
            let boundingRectHeightString = NSString(format: "\(Int(lineRect.height))")
            let point = CGPointMake(secondPointX, firstPointY)
            boundingRectHeightString.drawAtPoint(point, withAttributes: [NSForegroundColorAttributeName: UIColor.purpleColor(),
                NSFontAttributeName: UIFont.systemFontOfSize(min(20.0, lineRect.height))])
        }

        
        CGContextRestoreGState(context)
        
        super.drawUnderlineForGlyphRange(glyphRange, underlineType: underlineVal, baselineOffset: baselineOffset, lineFragmentRect: lineRect, lineFragmentGlyphRange: lineGlyphRange, containerOrigin: containerOrigin)
    }
    
    override func drawGlyphsForGlyphRange(glyphRange: NSRange, atPoint origin: CGPoint) {
        let context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context)
        
        // Если нужно показать линию шрифта, дополнительно вызываем метод для отрисовки подчеркивания
        self.enumerateLineFragmentsForGlyphRange(glyphRange, usingBlock: { (rect, usedRect, textContainer, glyphRange, stop) -> Void in
            self.underlineGlyphRange(glyphRange, underlineType: NSUnderlineStyle.StyleNone, lineFragmentRect:usedRect, lineFragmentGlyphRange: glyphRange, containerOrigin:origin)
        })
        
        //Пробегаемся по всем символам и отрисовываем boundingRect для каждого
        if self.showBoundingRect {
            for i in glyphRange.location ..< NSMaxRange(glyphRange) {
                
                if let textContainer = self.textContainerForGlyphAtIndex(glyphRange.location, effectiveRange: nil) {
                    var glyphRect = self.boundingRectForGlyphRange(NSMakeRange(i, 1), inTextContainer:textContainer)
                    glyphRect.origin.x += origin.x;
                    glyphRect.origin.y += origin.y;
                    glyphRect = CGRectInset(CGRectIntegral(glyphRect), 0.5, 0.5);
                    
                    UIColor.purpleColor().set()
                    let path = UIBezierPath(rect: glyphRect)
                    path.lineWidth = 2.0;
                    path.stroke()
                }
            }
        }
        
        CGContextRestoreGState(context)
        super.drawGlyphsForGlyphRange(glyphRange, atPoint: origin)
    }
}

    