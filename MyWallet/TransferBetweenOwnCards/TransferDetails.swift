//
//  TransferDetails.swift
//  MyWallet
//
//  Created by Dzakhon on 21/07/24.
//

import Foundation

enum TransferError: Error {
    case noTransferInfo
    case noTransferAmount
    case noSendingCard
    case noReceivingCard
}

enum TransferLimitsError: Error {
    case notEnoughtFounds
    case lowerThanMinLimit
}

protocol TransferDetailsDelegate {
    func didChangeTransferLimitsText()
}

class TransferDetails {
    private var transferAmount: Double?
    private var sendingCard: Card?
    private var receivingCard: Card?
    private var transferInfo: TransferInfo?
    
    init() {}
    init(sendingCard: Card, receivingCard: Card, transferInfo: TransferInfo) {
        self.sendingCard = sendingCard
        self.receivingCard = receivingCard
        self.transferInfo = transferInfo
    }
    func set(transferInfo: TransferInfo) {
        self.transferInfo = transferInfo
    }
    func set(sendingCard: Card) {
        self.sendingCard = sendingCard
    }
    func set(receivingCard: Card) {
        self.receivingCard = receivingCard
    }
    func set(transferAmount: Double) {
        self.transferAmount = transferAmount
    }
    func getTransferInfo() throws -> TransferInfo {
        guard let transferInfo else {
            throw TransferError.noTransferInfo
        }
        return transferInfo
    }
    func getSendingCard() throws -> Card {
        guard let sendingCard else {
            throw TransferError.noSendingCard
        }
        return sendingCard
    }
    func getReceivingCard() throws -> Card {
        guard let receivingCard else {
            throw TransferError.noReceivingCard
        }
        return receivingCard
    }
    func getTransferAmount() throws -> Double {
        guard let transferAmount else {
            throw TransferError.noTransferAmount
        }
        return transferAmount
    }
    func getWithdrawalTransferAmount() throws -> Double {
        let transferInfo = try getTransferInfo()
        let transferAmount = try getTransferAmount()
        let withdrawalAmount = transferAmount * (transferInfo.percent / 100 + 1)
        return withdrawalAmount
    }
    func checkTransferProcessDetails(withdrawalAmount: Double) throws {
        let sendingCard = try getSendingCard()
        let transferInfo = try getTransferInfo()
        if withdrawalAmount < transferInfo.send_min_limit {
            throw TransferLimitsError.lowerThanMinLimit
        }
        if sendingCard.balance < withdrawalAmount {
            throw TransferLimitsError.notEnoughtFounds
        }
    }
    func getCommissionAmount() throws -> Double {
        let transferInfo = try getTransferInfo()
        let transferAmount = try getTransferAmount()
        let commissionAmount = transferAmount * transferInfo.percent / 100
        return commissionAmount
    }
}


























struct TransferInfo {
    var percent: Double = 1.5
    let receive_min_limit: Double = 1000
    let receive_max_limit: Double = 1000000000
    let send_min_limit: Double = 100
    let send_max_limit: Double = 500000000
    let receive_currency: String = "UZS"
    let send_currency: String = "UZS"
    let currency_rate: Double = 1
    let currency_reverse = false
    let currency_rate_text: String? = nil
    let transaction_currency: String = "UZS"
    let cashback_percent: Double = 0
    let premium_percent: Double? = nil
    let premium_limit: Double = 0
    let receive_card_type: String = "UZCARD"
    let receive_card_number: String = "8600 55** **** 1882"
    let premium_commission_percent: Double = 0
}

class Card {
    var id = 11806465
    var card_number_hash = "DEF5D8F5B507C153284F39C193B4D4D9CE9E316B40B429E9FFE298C00FAA58C1"
    var currency_code = "UZS"
    var balance: Double = 0.0
}
