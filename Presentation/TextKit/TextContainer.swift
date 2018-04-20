//
//  TextContainer.swift
//  Presentation
//
//  Created by Irina Dyagileva on 20.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

/**
@author Irina Dyagileva

TextContainer, отображающий текст в области, заданной через UIBezierPath
*/
class TextContainer: NSTextContainer {
    
    override func lineFragmentRect(forProposedRect proposedRect: CGRect,
                                   at characterIndex: Int,
                                   writingDirection baseWritingDirection: NSWritingDirection,
                                   remaining remainingRect: UnsafeMutablePointer<CGRect>?) -> CGRect{
        let lineFragmentRect = super.lineFragmentRect(forProposedRect: proposedRect, at:characterIndex, writingDirection:baseWritingDirection, remaining:remainingRect)
       
        var result = lineFragmentRect
        
        /*
        Если заданная область отрисовки текста состоит из нескольких частей,
        как в случае с android.svg, то могут быть ситуации, что вернется пустая область.
        В этом случае LayoutManager прекратит дальнейшую отрисовку текста.

        Поэтому возвращаемый CGRect всегда должен быть не пустым!
        
        Подробнее почитать можно здесь:
        https://books.google.ru/books?id=LJeOAgAAQBAJ&pg=PA377&dq=lineFragmentRectForProposedRect+empty+rect&hl=ru&sa=X&ved=0CBwQ6AEwAGoVChMImIzvz8f2xgIVA41yCh1DmA-c#v=onepage&q=lineFragmentRectForProposedRect%20empty%20rect&f=false
        */

//        let cgPath = PocketSVG.pathFromSVGFileNamed("android").takeUnretainedValue()
        let cgPath = PocketSVG.path(fromSVGFileNamed: "rlogo").takeUnretainedValue()
        let path = UIBezierPath(cgPath: cgPath)

        var originX = result.origin.x
        let originY = result.midY
        
        // Пробегаем слева по каждой точке, пока не встретим пересечение с заданной областью
        while !path.contains(CGPoint(x: originX, y: originY)) {
            originX += 0.5
            if originX > result.maxX {
                return CGRect.zero
            }
        }
        
        result.origin.x = originX
        result.size.width = 0;
        while path.contains(CGPoint(x: result.maxX, y: originY)) {
            result.size.width += 0.5
        }
        
        remainingRect?.pointee = CGRect(x: result.maxX, y: proposedRect.origin.y, width: proposedRect.width, height: proposedRect.height)
        
        return result
    }
}
