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

    override func drawUnderline(forGlyphRange glyphRange: NSRange, underlineType underlineVal: NSUnderlineStyle, baselineOffset: CGFloat, lineFragmentRect lineRect: CGRect, lineFragmentGlyphRange lineGlyphRange: NSRange, containerOrigin: CGPoint) {
        
        // Левая и правая X соордината фрагмента строки
        let firstPointX =  lineRect.minX + containerOrigin.x
        let secondPointX =  lineRect.maxX + containerOrigin.x
        
        let firstPointY =  lineRect.minY + containerOrigin.y
        let secondPointY =  lineRect.maxY + containerOrigin.y
        
        // Y координата линии шрифта
        let baselineOriginY = ceil(secondPointY - baselineOffset)
        
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.setLineWidth(2.0)
        
        // Достаем шрифт из атрибута первого символа
        if let glyphFont = self.textStorage?.attribute(NSAttributedStringKey.font, at: glyphRange.location, effectiveRange: nil) as? UIFont {
            
            if self.showLineFragment  {
                UIColor.magenta.set()
                let lineRect = CGRect(x: firstPointX, y: firstPointY, width: lineRect.width, height: lineRect.height)
                UIBezierPath(rect: lineRect).stroke()
            }
            
            if self.showAscender {
                UIColor(hex: 0x8C78A4).set()
                let ascenderRect = CGRect(x: firstPointX, y: firstPointY, width: lineRect.width, height: glyphFont.ascender)
                context?.fill(ascenderRect)
            }
            
            if self.showDescender {
                UIColor(hex: 0x88C288).set()
                let descenderRect = CGRect(x: firstPointX, y: baselineOriginY, width: lineRect.width, height: -glyphFont.descender)
                context?.fill(descenderRect)
            }
            
            if self.showXHeight {
                let xHeightOriginY = baselineOriginY - glyphFont.xHeight
                UIColor(hex: 0xF3E0AB).set()
                let xHeightRect = CGRect(x: firstPointX, y: xHeightOriginY, width: lineRect.width, height: glyphFont.xHeight)
                context?.fill(xHeightRect)
            }
            
            if self.showCapHeight {
                UIColor(hex: 0xF3ABAB).set()
                let originY = baselineOriginY - glyphFont.capHeight
                let capHeightRect = CGRect(x: firstPointX, y: originY, width: lineRect.width, height: glyphFont.capHeight)
                context?.fill(capHeightRect)
            }
            
            if self.showLineGap {
                let height = glyphFont.leading;
                let originY = secondPointY - glyphFont.leading;
                UIColor(hex: 0x66A6DB).set()
                let leadingRect = CGRect(x: firstPointX, y: originY, width: lineRect.width, height: height)
                context?.fill(leadingRect)
            }
            
            if self.showLineHeight {
                UIColor.lightGray.set()
                let ascenderRect = CGRect(x: firstPointX, y: firstPointY, width: lineRect.width, height: glyphFont.lineHeight)
                context?.fill(ascenderRect)
            }
            
            if self.showMeanline {
                let xHeightOriginY = baselineOriginY - glyphFont.xHeight
                UIColor.blue.set()
                context?.move(to: CGPoint(x: firstPointX, y: xHeightOriginY))
                context?.addLine(to: CGPoint(x: secondPointX, y: xHeightOriginY))
                context?.strokePath()
            }
        }
        
        if self.showBaseline {
            UIColor.red.set()
            context?.move(to: CGPoint(x: firstPointX, y: baselineOriginY))
            context?.addLine(to: CGPoint(x: secondPointX, y: baselineOriginY))
            context?.strokePath()
        }
        
        if self.showBoundingRectHeight {
            let boundingRectHeightString = NSString(format: "\(Int(lineRect.height))" as NSString)
            let point = CGPoint(x: secondPointX, y: firstPointY)
            boundingRectHeightString.draw(at: point, withAttributes: [NSAttributedStringKey.foregroundColor: UIColor.purple,
                NSAttributedStringKey.font: UIFont.systemFont(ofSize: min(20.0, lineRect.height))])
        }

        
        context?.restoreGState()
        
        super.drawUnderline(forGlyphRange: glyphRange, underlineType: underlineVal, baselineOffset: baselineOffset, lineFragmentRect: lineRect, lineFragmentGlyphRange: lineGlyphRange, containerOrigin: containerOrigin)
    }
    
    override func drawGlyphs(forGlyphRange glyphRange: NSRange, at origin: CGPoint) {
        let context = UIGraphicsGetCurrentContext();
        context?.saveGState()
        
        // Если нужно показать линию шрифта, дополнительно вызываем метод для отрисовки подчеркивания
        self.enumerateLineFragments(forGlyphRange: glyphRange, using: { (rect, usedRect, textContainer, glyphRange, stop) -> Void in
            self.underlineGlyphRange(glyphRange, underlineType: NSUnderlineStyle.styleNone, lineFragmentRect:usedRect, lineFragmentGlyphRange: glyphRange, containerOrigin:origin)
        })
        
        //Пробегаемся по всем символам и отрисовываем boundingRect для каждого
        if self.showBoundingRect {
            for i in glyphRange.location ..< NSMaxRange(glyphRange) {
                
                if let textContainer = self.textContainer(forGlyphAt: glyphRange.location, effectiveRange: nil) {
                    var glyphRect = self.boundingRect(forGlyphRange: NSMakeRange(i, 1), in:textContainer)
                    glyphRect.origin.x += origin.x;
                    glyphRect.origin.y += origin.y;
                    glyphRect = glyphRect.integral.insetBy(dx: 0.5, dy: 0.5);
                    
                    UIColor.purple.set()
                    let path = UIBezierPath(rect: glyphRect)
                    path.lineWidth = 2.0;
                    path.stroke()
                }
            }
        }
        
        context?.restoreGState()
        super.drawGlyphs(forGlyphRange: glyphRange, at: origin)
    }
}

    
