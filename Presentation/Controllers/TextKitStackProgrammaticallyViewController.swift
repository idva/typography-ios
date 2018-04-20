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
        borderView.layer.borderColor = UIColor.red.cgColor
        borderView.layer.borderWidth = 2.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBorderViewFrameAnimated(false)
    }
    
    @IBAction func tapGesture(_ sender: AnyObject) {
        tapCount = tapCount + 1
        updateBorderViewFrameAnimated(true)
    }
    
    func updateBorderViewFrameAnimated(_ animated: Bool) {
        var borderViewRect = CGRect.zero
        
        switch tapCount % 4 {
            case 0:
                borderViewRect = CGRect(x: 94, y: 260, width: 756, height: 70)
                
            case 1:
                borderViewRect = CGRect(x: 94, y: 330, width: 756, height: 80)
                
            case 2:
                borderViewRect = CGRect(x: 94, y: 414, width: 756, height: 80)
                
            case 3:
                borderViewRect = CGRect(x: 94, y: 498, width: 850, height: 80)
                
            default:
                break
        }
        
        if animated {
            UIView.animate(withDuration: 0.35, animations: {
                self.borderView.frame = borderViewRect
            }) 
        } else {
            borderView.frame = borderViewRect
        }
    }
}
