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
                     align: NSTextAlignment,
                     lineSpacing: CGFloat = 0) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = align
        paragraphStyle.lineSpacing = lineSpacing
        let attributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: color,
            .font: font.size(size),
            .paragraphStyle: paragraphStyle
        ]
        self.init(string: text,
                  attributes: attributes)
    }
    
    static func + (lhr: NSAttributedString, rhr: NSAttributedString) -> NSAttributedString {
        let attrs = NSMutableAttributedString(attributedString: lhr)
        attrs.append(rhr)
        return attrs
    }
}
