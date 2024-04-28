//
//  ChartView.swift
//  MyWallet
//
//  Created by Dzakhon on 21/04/24.
//

import SwiftUI
import Charts

@available(iOS 17.0,*)
struct UIChartView: View {
    
    var products: [Product]
    
    var body: some View {
        Chart(products) { product in
            SectorMark(
                angle: .value(
                    Text(verbatim: product.title),
                    product.revenue
                )
            )
            .foregroundStyle(
                Color(UIColor(hex: product.colors.first!)!)
            )
        }
    }
    
}


final class UIChartViewForLowerVersions: UIView {
    
    init(_ products: [UIProduct]) {
        super.init(frame: .zero)
        let chart =
        UIChart(products) { product in
            UISectorMark(
                angle: .value(
                    NSAttributedString(string: "\(product.revenue)"),
                    product.revenue,
                    product.startPoint)
            )
            .foregroundStyle(
                product.colors.map { UIColor(hex: $0) ?? .black }
            )
        }
        addSubview(chart)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
