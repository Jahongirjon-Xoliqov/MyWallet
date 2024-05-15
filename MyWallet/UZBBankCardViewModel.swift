//
//  UZBBankCardViewModel.swift
//  MyWallet
//
//  Created by Dzakhon on 14/05/24.
//

import Foundation

final class UZBBankCardViewModel: UZBBankCardModelProtocol {
    var number: String
    var expirationDate: String
    var cardholderName: String
    var brandImageUrl: String
    var typeImageUrl: String
    var coverImageUrl: String
    init(
        number: String,
        expirationDate: String,
        cardholderName: String,
        brandImageUrl: String,
        typeImageUrl: String,
        coverImageUrl: String
    ) {
        self.number = number
        self.expirationDate = expirationDate
        self.cardholderName = cardholderName
        self.brandImageUrl = brandImageUrl
        self.typeImageUrl = typeImageUrl
        self.coverImageUrl = coverImageUrl
    }
}
