//
//  ExchangeRatesWidgetCell.swift
//  MyWallet
//
//  Created by Dzakhon on 05/05/24.
//

import UIKit

final class ExchangeRatesWidgetCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        addSUIView(ExchangeRatesView())
    }

}
