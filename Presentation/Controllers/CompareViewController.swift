//
//  CompareViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 03.05.16.
//  Copyright © 2016 RC. All rights reserved.
//

import UIKit

class CompareViewController: SlideViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var lineFragmentButton: UIButton!
    @IBOutlet weak var textContainerInsetButton: UIButton!
    @IBOutlet weak var fontLeadingButton: UIButton!
    @IBOutlet weak var boundingRectTextView: UITextView!
    
    var tapCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.textContainer.heightTracksTextView = true
        addBorderToView(textView);
        addBorderToView(label);
    }
    
    func addBorderToView(view: UIView) {
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.purpleColor().CGColor
    }
    
    @IBAction func usesFontLeadingButtonTapped(sender: UIButton) {
        sender.selected = !sender.selected
        textView.layoutManager.usesFontLeading = !sender.selected
        textView.layoutManager.invalidateLayoutForCharacterRange(NSMakeRange(0, textView.text.characters.count), actualCharacterRange: nil)        
    }
    
    @IBAction func textContainerInsetButtonTapped(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
            textView.textContainerInset = UIEdgeInsetsZero
        } else {
            textView.textContainerInset = UIEdgeInsetsMake(8, 0, 8, 0)
        }
        textView.layoutIfNeeded()
    }
    
    @IBAction func textContainerLineFragmentPaddingButtonTapped(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
            textView.textContainer.lineFragmentPadding = 0
        } else {
            textView.textContainer.lineFragmentPadding = 5
        }
        textView.layoutManager.invalidateLayoutForCharacterRange(NSMakeRange(0, textView.text.characters.count), actualCharacterRange: nil)
        textView.layoutManager.invalidateDisplayForCharacterRange(NSMakeRange(0, textView.text.characters.count))
    }
    
    @IBAction func tapGesture(sender: UITapGestureRecognizer) {
        boundingRectTextView.hidden = true

        switch tapCount % 4 {
            case 0:
                lineFragmentButton.hidden = !lineFragmentButton.hidden
                
            case 1:
                textContainerInsetButton.hidden = !textContainerInsetButton.hidden
                
            case 2:
                fontLeadingButton.hidden = !fontLeadingButton.hidden
            
            case 3:
                lineFragmentButton.hidden = true
                textContainerInsetButton.hidden = true
                fontLeadingButton.hidden = true
                boundingRectTextView.hidden = false
            
            default:
                break
        }
        
        tapCount = tapCount + 1
    }
}
