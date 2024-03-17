//
//  NSAttributedString+Extension.swift
//  MyWallet
//
//  Created by Dzakhon on 16/03/24.
//

import UIKit

typealias Attr = NSAttributedString

extension NSAttributedString {
    convenience init(text: String,
                     color: UIColor,
                     font: Font,
                     size: CGFloat,
                     align: NSTextAlignment) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = align
        let attributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: color,
            .font: font.size(size),
            .paragraphStyle: paragraphStyle
        ]
        self.init(string: text,
                  attributes: attributes)
    }
}
