//
//  UZBBankCardModelProtocol.swift
//  MyWallet
//
//  Created by Dzakhon on 14/05/24.
//

import Foundation

protocol UZBBankCardModelProtocol: AnyObject {
    var number: String { get set }
    var expirationDate: String { get set }
    var cardholderName: String { get set }
    var brandImageUrl: String { get set }
    var typeImageUrl: String { get set }
    var coverImageUrl: String { get set }
}
