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
        self.slider.isUserInteractionEnabled = false
        self.slider.addTarget(self, action: #selector(SliderView.sliderValueChanged(_:)), for: .valueChanged)
        let panGsture = UIPanGestureRecognizer(target: self, action: #selector(SliderView.pan(_:)))
        self.addGestureRecognizer(panGsture)
    }
    
    
    @objc func pan(_ recognizer:UIPanGestureRecognizer) {
        let point = recognizer.location(in: slider)
        let multiplier = Float(point.x / slider.frame.size.width)
        let value = self.slider.minimumValue + multiplier * (self.slider.maximumValue - self.slider.minimumValue)

        self.slider.setValue(value, animated: true)
        self.slider.sendActions(for: .valueChanged)
    }
    
    @objc func sliderValueChanged(_ slider: UISlider) {
        self.valueLabel.text = String(format:"%.1f", self.slider.value)
    }
}
