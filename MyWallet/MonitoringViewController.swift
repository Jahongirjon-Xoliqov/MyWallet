//
//  MonitoringViewController.swift
//  MyWallet
//
//  Created by Dzakhon on 03/03/24.
//

import UIKit
import SwiftUI

struct Product: Identifiable {
    let id = UUID()
    let title: String
    let revenue: Double
    let colors: [String]
}

struct UIProduct: Identifiable {
    let id = UUID()
    let title: String
    let revenue: NSNumber
    let startPoint: NSNumber
    let colors: [String]
}

let products: [Product] = [
    .init(title: "Annual", revenue: 20, colors: ["a5078f"]),
    .init(title: "Monthly", revenue: 40, colors: ["8f00e6"]),
    .init(title: "Lifetime", revenue: 40, colors: ["cddc42"])
]

let uiproducts: [UIProduct] = [
    .init(title: "Annual", revenue: 25, startPoint: 0,  colors: ["#2DD4BF", "#2DD4BF"]),
    .init(title: "Monthly", revenue: 40, startPoint: 25, colors: ["#FACC15", "#FACC15"]),
    .init(title: "Lifetime", revenue: 35, startPoint: 65, colors: ["#685FFF", "#685FFF"])
]

struct MonitoringData: Identifiable {
    let id = UUID()
    let title: String
    let amount: Decimal
}

let monitoringData: [MonitoringData] = [
    .init(title: "P2P", amount: -2_234_000),
    .init(title: "Internet Provider Comnet", amount: -200_000),
    .init(title: "B2P", amount: 20_000_000)
]

final class MonitoringViewController: UIViewController {
    
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var expenseButton: UIButton!
    @IBOutlet weak var incomeButton: UIButton!
    @IBOutlet weak var fromDateLabel: UILabel!
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    @IBOutlet weak var recentConfigsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Monitoring"
        
        if #available(iOS 17.0, *) {
            drawPieChart(with: products)
        } else {
            drawPieChart(with: uiproducts)
        }
        
        fromDateLabel.attributedText = Attr.init(
            text: "From:",
            color: .black,
            font: .MONTSERRAT_REGULAR,
            size: 17,
            align: .left
        )
        
        toDateLabel.attributedText = Attr.init(
            text: "To:",
            color: .black,
            font: .MONTSERRAT_REGULAR,
            size: 17,
            align: .left
        )
        
        fromDatePicker.datePickerMode = .date
        fromDatePicker.locale = Locale(identifier: "uz")
        
        toDatePicker.datePickerMode = .date
        toDatePicker.locale = Locale(identifier: "uz")
        
        setTotalIncome(with: Money<UZS>.init(33_232_000).monitoringDisplayableString())
        setTotalExpense(with: Money<UZS>.init(2_033_000).monitoringDisplayableString())
        
    }
    
    @available(iOS 17.0, *)
    private func drawPieChart(with products : [Product]) {
        chartView.backgroundColor = .clear
        chartView.addSubSwiftUIView(UIChartView(products: products))
    }
    
    private func drawPieChart(with uiproducts: [UIProduct]) {
        chartView.backgroundColor = .clear
        chartView.addSubview(UIChartViewForLowerVersions(uiproducts))
    }
    
    
    private func setTotalExpense(with amount: String) {
        
        let hintAttrForNormalState = Attr.init(
            text: "Expenses:\n",
            color: .darkText,
            font: .MONTSERRAT_REGULAR,
            size: 14,
            align: .left,
            lineSpacing: 5
        )
        
        let hintAttrForHightlightedState = Attr.init(
            text: "Expenses:\n",
            color: .lightGray,
            font: .MONTSERRAT_REGULAR,
            size: 14,
            align: .left,
            lineSpacing: 5
        )
        
        let attrForNormalState = Attr.init(
            text: amount,
            color: .systemRed,
            font: .MONTSERRAT_BOLD,
            size: 17,
            align: .left,
            lineSpacing: 5
        )
        
        let attrForHightlightedState = Attr.init(
            text: amount,
            color: .lightGray,
            font: .MONTSERRAT_BOLD,
            size: 17,
            align: .left,
            lineSpacing: 5
        )
        
        if #available(iOS 15.0, *) {} else {
            expenseButton.titleLabel?.numberOfLines = 0
        }
        
        expenseButton.setAttributedTitle(
            hintAttrForNormalState + attrForNormalState,
            for: .normal)
        
        expenseButton.setAttributedTitle(
            hintAttrForHightlightedState + attrForHightlightedState,
            for: .disabled)
        
        expenseButton.setAttributedTitle(
            hintAttrForHightlightedState + attrForHightlightedState,
            for: .highlighted)
        
    }
    
    private func setTotalIncome(with amount: String) {
        
        let hintAttrForNormalState = Attr.init(
            text: "Incomes:\n",
            color: .darkText,
            font: .MONTSERRAT_REGULAR,
            size: 14,
            align: .left,
            lineSpacing: 5
        )
        
        let hintAttrForHightlightedState = Attr.init(
            text: "Incomes:\n",
            color: .lightGray,
            font: .MONTSERRAT_REGULAR,
            size: 14,
            align: .left,
            lineSpacing: 5
        )
        
        let attrForNormalState = Attr.init(
            text: amount,
            color: .systemGreen,
            font: .MONTSERRAT_BOLD,
            size: 17,
            align: .left,
            lineSpacing: 5
        )
        
        let attrForHightlightedState = Attr.init(
            text: amount,
            color: .lightGray,
            font: .MONTSERRAT_BOLD,
            size: 17,
            align: .left,
            lineSpacing: 5
        )
        
        if #available(iOS 15.0, *) {} else {
            incomeButton.titleLabel?.numberOfLines = 0
        }
        
        incomeButton.setAttributedTitle(
            hintAttrForNormalState + attrForNormalState,
            for: .normal)
        
        incomeButton.setAttributedTitle(
            hintAttrForHightlightedState + attrForHightlightedState,
            for: .disabled)
        
        incomeButton.setAttributedTitle(
            hintAttrForHightlightedState + attrForHightlightedState,
            for: .highlighted)
        
    }
    
}
