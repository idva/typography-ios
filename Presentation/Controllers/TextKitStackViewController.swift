//
//  TextKitStackViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 19.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class TextKitStackViewController: SlideViewController {

    @IBOutlet weak var arrowView: UIView!
    @IBOutlet weak var mvcView: UIView!
    
    @IBOutlet weak var textViewLabel: UILabel!
    @IBOutlet weak var textStorageLabel: UILabel!
    @IBOutlet weak var layoutManagerLabel: UILabel!
    @IBOutlet weak var textContainerLabel: UILabel!
    
    
    @IBAction func tap(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in

            let initialState = self.arrowView.alpha > 0
            self.textViewLabel.center =  initialState ? CGPointMake(817, 440) : CGPointMake(258.0, 237.0)
            self.textStorageLabel.center = initialState ? CGPointMake(216, 569) : CGPointMake(507.0, 625.0)
            self.layoutManagerLabel.center = initialState ? CGPointMake(514, 275) : CGPointMake(507.0, 432.0)
            self.textContainerLabel.center = initialState ? CGPointMake(216, 440) : CGPointMake(762.0, 237.0)
            
            self.arrowView.alpha = 1 - self.arrowView.alpha
            self.mvcView.alpha = 1 - self.mvcView.alpha
        }, completion: nil)
    }
    
}

