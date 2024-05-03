//
//  CardsContainerCollectionViewCell.swift
//  MyWallet
//
//  Created by Dzakhon on 01/05/24.
//

import UIKit

final class CardsContainerCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.addSubSwiftUIView(SQBCardView())
    }

}
