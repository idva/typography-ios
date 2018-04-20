//
//  TextAttachmentViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 29.05.16.
//  Copyright © 2016 RC. All rights reserved.
//

import UIKit

class TextAttachmentViewController: SlideViewController {

    @IBOutlet weak var ramblerTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let attributedText = NSMutableAttributedString(attributedString: ramblerTextView.attributedText)
       
        // Создаем text attachment
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named:"rlogo");
        
        // Оборачиваем его в attributed string
        let attachmentString = NSAttributedString(attachment: attachment)
        
        // Добавляем к остальным символам
        attributedText.insert(attachmentString, at: 7)
        
        ramblerTextView.attributedText = attributedText.copy() as! NSAttributedString
    }
}
