//
//  TextContainerExampleViewController.swift
//  Presentation
//
//  Created by Irina Dyagileva on 20.07.15.
//  Copyright (c) 2015 Rambler&Co. All rights reserved.
//

import UIKit

class TextContainerExampleViewController: SlideViewController {

    @IBOutlet weak var textViewContainer: UIView!

    var layoutManager = LayoutManager()
    let textStorage = NSTextStorage()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextKitStack()
    }
    
    func setupTextKitStack() {
        // Создаем NSTextStorage
        textStorage.setAttributedString(self.createAttributedString())
        
        // Создаем NSLayoutManager и добавляем его в NSTextStorage
        textStorage.addLayoutManager(layoutManager)
        
        // Создаем NSTextContainer и добавляем его в NSLayoutManager
        let textContainer = TextContainer(size: self.textViewContainer.bounds.size)
        layoutManager.addTextContainer(textContainer)
        
        // Создаем UITextView c заданным NSTextContainer
        let textView = UITextView(frame: self.textViewContainer.bounds, textContainer: textContainer)
        textView.backgroundColor = UIColor.clearColor()
        textView.editable = false;
        textViewContainer.addSubview(textView)
    }
    
    func createAttributedString() -> NSAttributedString {
        let normalFont = UIFont.systemFontOfSize(20.0)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.ByCharWrapping
        
        let attributes = [
            NSFontAttributeName : normalFont,
            NSForegroundColorAttributeName : UIColor.darkTextColor(),
            NSParagraphStyleAttributeName: paragraphStyle.copy()
        ];
        let text = "Компания RCO, специализирующаяся на компьютерной лингвистике, информационном поиске и обработке неструктурированной информации, вошла в группу компаний Rambler&Co. Об этом «Ленте.ру» сообщила PR-директор холдинга София Иванова. RCO разрабатывает программное обеспечение для «интеллектуальной» обработки текстов преимущественно на русском языке. Продукты компании позволяют извлекать из источников фактографическую информацию вроде упоминаний организаций, персон, географических объектов, брендов, событий с указанием участников и их ролей, а также категоризировать большие массивы текстов, объединять похожие по смыслу документы в сюжеты. Список партнеров и заказчиков компании составляют крупные корпорации и государственные структуры. «Мы видим большой потенциал для решения бизнес-задач группы компаний Rambler&Co. В первую очередь, в области совмещения технологий интеллектуального контент-анализа и рекламных технологий», — прокомментировал Максим Тадевосян, заместитель генерального директора Rambler&Co. Кроме того, по его словам, RCO поспособствуют выводу на рынок нового продукта для сбора в одном месте аналитики из разных цифровых СМИ и реакции пользователей на различные инфоповоды. В свою очередь для RCO — это выход за рамки корпоративного сектора и возможность применить разработки и опыт компании в сегменте публичных информационных сервисов и СМИ. «Объем обрабатываемых [в этой области] данных больше на порядки, сложность решаемых задач значительно выше», — отметил генеральный директор RCO Владимир Плешко.Rambler&Co — одна из крупнейших российских групп компаний в области медиа, технологий и электронной коммерции. По данным Rambler&Co, аудитория интернет-холдинга превышает 36 миллионов человек в месяц. В холдинг в 2013 году объединены активы «Афиши-Рамблера» (ООО «Рамблер Интернет Холдинг», ООО «Компания Афиша», ООО «Лента», ООО «Прайс-экспресс», ЗАО «Бегун», ООО «Рамблер-Игры») и SUP Media («Газета.ru», LiveJournal.com, «Чемпионат.com» и другие). С апреля 2014-го компания работает под единым брендом Rambler&Co. Председателем совета директоров и руководителем Rambler&Co является Александр Мамут."
        
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        return attributedString
    }
    
    @IBAction func toggleLineFragments(sender: UISlider) {
        layoutManager.showLineFragment = !layoutManager.showLineFragment
        let range = NSMakeRange(0, textStorage.length)
        layoutManager.invalidateDisplayForCharacterRange(range)
    }
}
