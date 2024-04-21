//
//  ChartView.swift
//  MyWallet
//
//  Created by Dzakhon on 21/04/24.
//

import SwiftUI
import Charts

struct UIChartView: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            Chart {
                
            }
        } else {
            // Fallback on earlier versions
        }
    }
}


#Preview {
    UIChartView()
}


