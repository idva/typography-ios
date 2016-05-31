//
//  TextKitStackProgrammaticallyViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 14.05.16.
//  Copyright © 2016 RC. All rights reserved.
//

import UIKit

class TextKitStackProgrammaticallyViewController: SlideViewController {
    
    @IBOutlet weak var borderView: UIView!
    var tapCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        borderView.layer.borderColor = UIColor.redColor().CGColor
        borderView.layer.borderWidth = 2.0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateBorderViewFrameAnimated(false)
    }
    
    @IBAction func tapGesture(sender: AnyObject) {
        tapCount = tapCount + 1
        updateBorderViewFrameAnimated(true)
    }
    
    func updateBorderViewFrameAnimated(animated: Bool) {
        var borderViewRect = CGRectZero
        
        switch tapCount % 4 {
            case 0:
                borderViewRect = CGRectMake(94, 260, 756, 70)
                
            case 1:
                borderViewRect = CGRectMake(94, 330, 756, 80)
                
            case 2:
                borderViewRect = CGRectMake(94, 414, 756, 80)
                
            case 3:
                borderViewRect = CGRectMake(94, 498, 850, 80)
                
            default:
                break
        }
        
        if animated {
            UIView.animateWithDuration(0.35) {
                self.borderView.frame = borderViewRect
            }
        } else {
            borderView.frame = borderViewRect
        }
    }
}
