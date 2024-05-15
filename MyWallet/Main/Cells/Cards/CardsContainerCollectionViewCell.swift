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
        let bankCardModel = UZBBankCardViewModel(
            number: "9860 0903 9345 0022",
            expirationDate: "08/26",
            cardholderName: "JAHONGIRJON KHOLIKOV",
            brandImageUrl: "bankCardLogoSQB",
            typeImageUrl: "cardTypeLogoHumo",
            coverImageUrl: "cardBackground"
        )
        addSUIView(SQBCardView(model: bankCardModel))
    }

}

