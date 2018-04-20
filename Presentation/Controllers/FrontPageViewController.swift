//
//  ViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 16.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class FrontPageViewController: SlideViewController {

    @IBOutlet weak var backgroundTextView: UITextView!
    @IBOutlet var excludeViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var paths = [UIBezierPath]()
        for (_, excludeView) in self.excludeViews.enumerated() {
            let viewFrame = excludeView.frame
            let exclusionRect = view.convert(viewFrame, to:backgroundTextView)
            let exclusion = UIBezierPath(rect:exclusionRect);
            paths.append(exclusion)
        }
        
        self.backgroundTextView.textContainer.exclusionPaths = paths
    }
}

