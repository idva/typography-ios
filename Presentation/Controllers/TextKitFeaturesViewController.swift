//
//  TextKitFeaturesViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 22.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class TextKitFeaturesViewController: SlideViewController {

    @IBOutlet var labels: [YETIFallingLabel]!

    @IBAction func tap(_ sender: AnyObject) {
        for (_, view) in self.labels.enumerated() {
            // Анимация запускается при смене текста
            view.text = view.textStorage.string
        }
    }
}
