//
//  QuickPayWidgetCell.swift
//  MyWallet
//
//  Created by Dzakhon on 05/05/24.
//

import UIKit

final class QuickPayWidgetCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.addSubSwiftUIView(QuickPayWidgetView())
    }

}
