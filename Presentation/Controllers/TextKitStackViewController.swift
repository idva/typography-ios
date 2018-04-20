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
    
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in

            let initialState = self.arrowView.alpha > 0
            self.textViewLabel.center =  initialState ? CGPoint(x: 817, y: 440) : CGPoint(x: 258.0, y: 237.0)
            self.textStorageLabel.center = initialState ? CGPoint(x: 216, y: 569) : CGPoint(x: 507.0, y: 625.0)
            self.layoutManagerLabel.center = initialState ? CGPoint(x: 514, y: 275) : CGPoint(x: 507.0, y: 432.0)
            self.textContainerLabel.center = initialState ? CGPoint(x: 216, y: 440) : CGPoint(x: 762.0, y: 237.0)
            
            self.arrowView.alpha = 1 - self.arrowView.alpha
            self.mvcView.alpha = 1 - self.mvcView.alpha
        }, completion: nil)
    }
    
}

