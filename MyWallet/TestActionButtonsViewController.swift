//
//  TestActionButtonsViewController.swift
//  ClickEvolution_iOS
//
//  Created by Dzakhon on 16/03/24.
//  Copyright © 2024 Click LLC. All rights reserved.
//

import UIKit

class TestActionButtonsViewController: UIViewController {

    @IBOutlet weak var simpleActionButton: ActionButton!
    @IBOutlet weak var bottomActionButton: BottomImageActionButton!
    @IBOutlet weak var leftAlignedActionButton: LeftAlignedActionButton!
    @IBOutlet weak var rightAlignedActionButton: RightAlignedActionButton!
    @IBOutlet weak var identityActionButton: IdentityActionButton!
    @IBOutlet weak var identityRightActionButton: IdentityRightAlignedActionButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simpleActionButton.clipsToBounds = true
        simpleActionButton.layer.cornerRadius = 10
        simpleActionButton.backgroundColor = .systemGroupedBackground
        simpleActionButton.setImage(UIImage(systemName: "books.vertical.fill"), tintColor: .blue)
        simpleActionButton.setAttributedTitle(Attr(text: "New action\nfor button", color: .darkText, font: .MONTSERRAT_REGULAR, size: 14, align: .center))
        simpleActionButton.setImage(UIImage.strokedCheckmark, tintColor: .lightGray, for: .highlighted)
        simpleActionButton.setAttributedTitle(Attr(text: "New action\nfor button", color: .darkText, font: .MONTSERRAT_REGULAR, size: 14, align: .center), for: .highlighted)
        
        bottomActionButton.clipsToBounds = true
        bottomActionButton.layer.cornerRadius = 10
        bottomActionButton.backgroundColor = .systemGroupedBackground
        bottomActionButton.setImage(UIImage(systemName: "books.vertical.fill"), tintColor: .blue)
        bottomActionButton.setAttributedTitle(Attr(text: "New action for button this new button title exeeds bounds of uibutton", color: .darkText, font: .MONTSERRAT_REGULAR, size: 14, align: .center))
        bottomActionButton.setImage(UIImage(systemName: "books.vertical.fill"), tintColor: .lightGray, for: .highlighted)
        bottomActionButton.setAttributedTitle(Attr(text: "New action\nfor button", color: .darkText, font: .MONTSERRAT_REGULAR, size: 14, align: .center), for: .highlighted)
        
        leftAlignedActionButton.clipsToBounds = true
        leftAlignedActionButton.layer.cornerRadius = 10
        leftAlignedActionButton.backgroundColor = .systemGroupedBackground
        leftAlignedActionButton.setImage(UIImage(systemName: "books.vertical.fill"), tintColor: .blue)
        leftAlignedActionButton.setAttributedTitle(Attr(text: "New action\nfor button", color: .darkText, font: .MONTSERRAT_REGULAR, size: 14, align: .left))
        leftAlignedActionButton.setImage(UIImage(systemName: "books.vertical.fill"), tintColor: .lightGray, for: .highlighted)
        leftAlignedActionButton.setAttributedTitle(Attr(text: "New action\nfor button", color: .darkText, font: .MONTSERRAT_REGULAR, size: 14, align: .left), for: .highlighted)
     
        rightAlignedActionButton.clipsToBounds = true
        rightAlignedActionButton.layer.cornerRadius = 10
        rightAlignedActionButton.backgroundColor = .systemGroupedBackground
        rightAlignedActionButton.setImage(UIImage(systemName: "books.vertical.fill"), tintColor: .blue)
        rightAlignedActionButton.setAttributedTitle(Attr(text: "New action\nfor button", color: .darkText, font: .MONTSERRAT_REGULAR, size: 14, align: .right))
        rightAlignedActionButton.setImage(UIImage(systemName: "books.vertical.fill"), tintColor: .lightGray, for: .highlighted)
        rightAlignedActionButton.setAttributedTitle(Attr(text: "New action\nfor button", color: .darkText, font: .MONTSERRAT_REGULAR, size: 14, align: .right), for: .highlighted)
        
        identityActionButton.clipsToBounds = true
        identityActionButton.layer.cornerRadius = 10
        identityActionButton.backgroundColor = .systemGroupedBackground
        identityActionButton.setImage(UIImage(systemName: "books.vertical.fill"), tintColor: .blue)
        identityActionButton.setAttributedTitle(Attr(text: "New action\nfor button", color: .darkText, font: .MONTSERRAT_REGULAR, size: 14, align: .center))
        identityActionButton.setImage(UIImage(systemName: "books.vertical.fill"), tintColor: .lightGray, for: .highlighted)
        identityActionButton.setAttributedTitle(Attr(text: "New action\nfor button", color: .darkText, font: .MONTSERRAT_REGULAR, size: 14, align: .center), for: .highlighted)
        
        identityRightActionButton.clipsToBounds = true
        identityRightActionButton.layer.cornerRadius = 10
        identityRightActionButton.backgroundColor = .systemGroupedBackground
        identityRightActionButton.setImage(UIImage(systemName: "books.vertical.fill"), tintColor: .blue)
        identityRightActionButton.setAttributedTitle(Attr(text: "New action\nfor button", color: .darkText, font: .MONTSERRAT_REGULAR, size: 14, align: .center))
        identityRightActionButton.setImage(UIImage(systemName: "books.vertical.fill"), tintColor: .lightGray, for: .highlighted)
        identityRightActionButton.setAttributedTitle(Attr(text: "New action\nfor button", color: .darkText, font: .MONTSERRAT_REGULAR, size: 14, align: .center), for: .highlighted)
        identityRightActionButton.isEnabled = true
        
    }
    
}
