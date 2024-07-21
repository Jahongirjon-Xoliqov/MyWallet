//
//  TBAViewController.swift
//  MyWallet
//
//  Created by Dzakhon on 21/07/24.
//

import UIKit

final class TBAViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var transferLimitsLabel: UILabel!
    
    private var transferDetails = TransferDetails()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        configureTransferProcessDetails()
    }
    
    @IBAction func didReceiveTranferInfo(_ sender: UIButton) {
        var transferInfo = TransferInfo()
        transferInfo.percent = Double(Int.random(in: 5...10)) / 10
        transferDetails.set(transferInfo: transferInfo)
        configureTransferProcessDetails()
        
        sender.setTitle("\(transferInfo.percent)", for: .normal)
    }
    
    @IBAction func didSelectSendingCard(_ sender: UIButton) {
        let card = Card()
        card.balance = Double(Int.random(in: 1...10) * 10000)
        transferDetails.set(sendingCard: card)
        configureTransferProcessDetails()

        sender.setTitle("\(card.balance)", for: .normal)
    }
    
    @IBAction func didSelectReceivingCard(_ sender: UIButton) {
        let card = Card()
        card.balance = Double(Int.random(in: 1...10) * 10000)
        transferDetails.set(receivingCard: card)
        configureTransferProcessDetails()
        
        sender.setTitle("\(card.balance)", for: .normal)
    }
    
    private func configureTransferProcessDetails() {
        do {
            let withdrawalAmount = try transferDetails.getWithdrawalTransferAmount()
            try transferDetails.checkTransferProcessDetails(withdrawalAmount: withdrawalAmount)
            let commissionAmount = try transferDetails.getCommissionAmount()
            
            transferLimitsLabel.text = "\(commissionAmount)"
            transferLimitsLabel.textColor = .black
        } catch TransferError.noTransferAmount {
            transferLimitsLabel.text = "no transfer amount"
            transferLimitsLabel.textColor = .red
        } catch TransferError.noSendingCard {
            transferLimitsLabel.text = "no sending card"
            transferLimitsLabel.textColor = .red
        } catch TransferError.noReceivingCard {
            transferLimitsLabel.text = "no receive card"
            transferLimitsLabel.textColor = .red
        } catch TransferError.noTransferInfo {
            transferLimitsLabel.text = "no transfer info"
            transferLimitsLabel.textColor = .red
        } catch TransferLimitsError.lowerThanMinLimit {
            transferLimitsLabel.text = "lower min limit"
            transferLimitsLabel.textColor = .red
        } catch TransferLimitsError.notEnoughtFounds {
            transferLimitsLabel.text = "not enought balance"
            transferLimitsLabel.textColor = .red
        } catch {
            transferLimitsLabel.text = "unexpected error occured"
            transferLimitsLabel.textColor = .red
        }
    }
    
}


extension TBAViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let transferAmount = Double(textField.text!)!
        transferDetails.set(transferAmount: transferAmount)
        configureTransferProcessDetails()
        
    }
    
}
