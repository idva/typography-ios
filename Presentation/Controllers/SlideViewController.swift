//
//  SlideViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 18.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class SlideViewController: UIViewController {
    var slideIndexLabel :UILabel!
    
    var slideIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideIndexLabel = UILabel()
        let verticalConstraint = NSLayoutConstraint(
            item: slideIndexLabel,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 0)
        let horizontalConstraint = NSLayoutConstraint(
            item: slideIndexLabel!,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Right,
            multiplier: 1.0,
            constant: -20)
        slideIndexLabel.textColor = UIColor.darkTextColor()
        slideIndexLabel.translatesAutoresizingMaskIntoConstraints = false
        slideIndexLabel.font = UIFont(name: "Rambler-Regular", size: 25)
        slideIndexLabel.text = slideIndex > 0 ? "\(slideIndex)" : ""
        view.addSubview(slideIndexLabel)
        view.addConstraints([verticalConstraint, horizontalConstraint])
    }
}
