//
//  TextViewInsetsViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 25.05.16.
//  Copyright © 2016 RC. All rights reserved.
//

import UIKit

class TextViewInsetsViewController: TextViewSlideViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBInspectable var lineFragmentPadding:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textContainer.lineFragmentPadding = lineFragmentPadding
        textViewContainer.bringSubviewToFront(imageView)
        textView.scrollEnabled = false
        updateExclusionPath()
        
        layoutManager.hyphenationFactor = 1.0
    }
    
    override func setupLayoutManager() {
        layoutManager.showBoundingRect = false
        layoutManager.showLineFragment = false
    }
    
    override func createAttributedString() -> NSAttributedString {
        let normalFont = UIFont(name: "Georgia", size: 25)
        let attributes = [
            NSFontAttributeName : normalFont!
        ];
        let text = "ГЛАВА I.  Среди общественных зданий в некоем городе, который по многим причинам благоразумнее будет не называть и которому я не дам никакого вымышленного наименования, находится здание, издавна встречающееся почти во всех городах, больших и малых, именно - работный дом. И в этом работном доме родился, я могу себя не утруждать указанием дня и числа, так как это не имеет никакого значения для читателя, во всяком случае на  данной стадии повествования, родился смертный, чье имя предшествует началу этой главы. Когда приходский врач ввел его в сей мир печали и скорбей, долгое время казалось весьма сомнительным, выживет ли ребенок, чтобы получить какое бы то ни было имя; по всей вероятности, эти мемуары никогда не вышли бы в свет, а если бы вышли, то заняли бы не более двух-трех страниц и благодаря этому бесценному качеству являли бы собою самый краткий и правдивый образец биографии из всех сохранившихся в литературе любого века или любой страны."
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        return attributedString
    }

    @IBAction func textContainerInsetValueChanged(sender: UISlider) {
        let value = CGFloat(sender.value)
        textView.textContainerInset = UIEdgeInsetsMake(value, value, value, value)
        updateExclusionPath()
    }
    
    @IBAction func lineFragmentPaddingValueChanged(sender: UISlider) {
        textContainer.lineFragmentPadding = CGFloat(sender.value)
    }

    @IBAction func toggleLineFragments(sender: UISlider) {
        layoutManager.showLineFragment = !layoutManager.showLineFragment
        let range = NSMakeRange(0, textStorage.length)
        layoutManager.invalidateDisplayForCharacterRange(range)
    }
    
    @IBAction func toggleTextViewBackgroundColor(sender: UISlider) {
        let hasNoColor = textView.backgroundColor!.isEqual(UIColor.clearColor())
        if hasNoColor {
            textView.backgroundColor = UIColor.lightGrayColor().colorWithAlphaComponent(0.2)
        } else {
            textView.backgroundColor = UIColor.clearColor()
        }
    }
    
    @IBAction func hyphenationFactorValueChanged(sender: UISlider) {
        layoutManager.hyphenationFactor = CGFloat(sender.value)
    }
    
    func updateExclusionPath() {
        var exclusionRect = imageView.frame
        exclusionRect = exclusionRect.offsetBy(dx: -textView.textContainerInset.left, dy: -textView.textContainerInset.top)
        let exclusionPath = UIBezierPath(rect: exclusionRect)
        textView.textContainer.exclusionPaths = [exclusionPath]
    }

}
