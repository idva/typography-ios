//
//  TouchView.swift
//  Presentation
//
//  Created by Irina Dyagileva on 23/07/15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class SliderView: UIView {
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.slider.userInteractionEnabled = false
        self.slider.addTarget(self, action: #selector(SliderView.sliderValueChanged(_:)), forControlEvents: .ValueChanged)
        let panGsture = UIPanGestureRecognizer(target: self, action: #selector(SliderView.pan(_:)))
        self.addGestureRecognizer(panGsture)
    }
    
    func pan(recognizer:UIPanGestureRecognizer) {
        let point = recognizer.locationInView(slider)
        let multiplier = Float(point.x / slider.frame.size.width)
        let value = self.slider.minimumValue + multiplier * (self.slider.maximumValue - self.slider.minimumValue)

        self.slider.setValue(value, animated: true)
        self.slider.sendActionsForControlEvents(.ValueChanged)
    }
    
    func sliderValueChanged(slider: UISlider) {
        self.valueLabel.text = String(format:"%.1f", self.slider.value)
    }
}
