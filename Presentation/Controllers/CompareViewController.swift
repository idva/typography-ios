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
    
    func addBorderToView(_ view: UIView) {
        view.layer.borderWidth = 1.5
        view.layer.borderColor = UIColor.purple.cgColor
    }
    
    @IBAction func usesFontLeadingButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        textView.layoutManager.usesFontLeading = !sender.isSelected
        textView.layoutManager.invalidateLayout(forCharacterRange: NSMakeRange(0, textView.text.count), actualCharacterRange: nil)
    }
    
    @IBAction func textContainerInsetButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            textView.textContainerInset = UIEdgeInsets.zero
        } else {
            textView.textContainerInset = UIEdgeInsetsMake(8, 0, 8, 0)
        }
        textView.layoutIfNeeded()
    }
    
    @IBAction func textContainerLineFragmentPaddingButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            textView.textContainer.lineFragmentPadding = 0
        } else {
            textView.textContainer.lineFragmentPadding = 5
        }
        textView.layoutManager.invalidateLayout(forCharacterRange: NSMakeRange(0, textView.text.characters.count), actualCharacterRange: nil)
        textView.layoutManager.invalidateDisplay(forCharacterRange: NSMakeRange(0, textView.text.characters.count))
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        boundingRectTextView.isHidden = true

        switch tapCount % 4 {
            case 0:
                lineFragmentButton.isHidden = !lineFragmentButton.isHidden
                
            case 1:
                textContainerInsetButton.isHidden = !textContainerInsetButton.isHidden
                
            case 2:
                fontLeadingButton.isHidden = !fontLeadingButton.isHidden
            
            case 3:
                lineFragmentButton.isHidden = true
                textContainerInsetButton.isHidden = true
                fontLeadingButton.isHidden = true
                boundingRectTextView.isHidden = false
            
            default:
                break
        }
        
        tapCount = tapCount + 1
    }
}
