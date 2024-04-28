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
    let colors: [String]
}

final class MonitoringViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let products: [Product] = [
            .init(title: "Annual", revenue: 70, colors: ["a5078f"]),
            .init(title: "Monthly", revenue: 20, colors: ["8f00e6"]),
            .init(title: "Lifetime", revenue: 10, colors: ["cddc42"])
        ]
        
        let uiproducts: [UIProduct] = [
            .init(title: "Annual", revenue: 70, colors: ["a5078f", "cddc42"]),
            .init(title: "Monthly", revenue: 20, colors: ["8f00e6", "a5078f"]),
            .init(title: "Lifetime", revenue: 10, colors: ["cddc42", "a5078f"])
        ]
        
        
        if #available(iOS 18.0, *) {
            let pieChartView = UIChartView(products: products)
            let hostingController = UIHostingController(rootView: pieChartView)
            addChild(hostingController)
            view.addSubview(hostingController.view)
            hostingController.view.frame = CGRect(x: view.midX-100, y: view.midY-100, width: 200, height: 200)
            hostingController.didMove(toParent: self)
        } else {
            // Fallback on earlier versions
            let pieChartView = UIChartViewForLowerVersions(uiproducts)
            pieChartView.frame = CGRect(x: view.midX-100, y: view.midY-100, width: 200, height: 200)
            view.addSubview(pieChartView)
        }
        
        
        
        
    }
    
}
