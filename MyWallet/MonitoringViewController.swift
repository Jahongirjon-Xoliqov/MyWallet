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

final class MonitoringViewController: UIViewController {
    
    @IBOutlet weak var chartView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Monitoring"
        
        if #available(iOS 18.0, *) {
            drawPieChart(with: products)
        } else {
            drawPieChart(with: uiproducts)
        }
        
        
        
    }
    
    @available(iOS 18.0, *)
    func drawPieChart(with products : [Product]) {
        let pieChartView = UIChartView(products: products)
        let hostingController = UIHostingController(rootView: pieChartView)
        addChild(hostingController)
        chartView.addSubview(hostingController.view)
        hostingController.view.frame = chartView.bounds
        hostingController.didMove(toParent: self)
    }
    
    func drawPieChart(with uiproducts: [UIProduct]) {
        // Fallback on earlier versions
        let pieChartView = UIChartViewForLowerVersions(uiproducts)
        pieChartView.frame = chartView.bounds
        chartView.addSubview(pieChartView)
    }
    
}
