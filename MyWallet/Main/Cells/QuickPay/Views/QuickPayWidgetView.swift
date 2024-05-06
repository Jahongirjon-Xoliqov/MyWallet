//
//  QuickPayWidgetView.swift
//  MyWallet
//
//  Created by Dzakhon on 05/05/24.
//

import SwiftUI

struct QuickPayWidgetView: View {
    var body: some View {
        ZStack {
            HStack(spacing: 20) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.clear)
                    VStack(spacing: 10) {
                        Image("tempQR")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(12)
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.gray.opacity(0.2))
                            VStack(alignment: .leading) {
                                Text("99 000 uzs")
                                    .font(.system(size: 17, weight: .bold))
                                Spacer()
                                Text("9860 **** 8332")
                                    .font(.system(size: 14, weight: .regular))
                                Text("Click Salary Card")
                                    .font(.system(size: 14, weight: .regular))
                            }
                            .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                        }
                        .aspectRatio(2, contentMode: .fit)
                    }
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.clear)
                    VStack(spacing: 10) {
                        Image("tempQR")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(12)
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.gray.opacity(0.2))
                            VStack(alignment: .leading) {
                                Text("12 000 uzs")
                                    .font(.system(size: 17, weight: .bold))
                                Spacer()
                                Text("3212 0220 0022 2312")
                                    .font(.system(size: 14, weight: .regular))
                                Text("Korzinka")
                                    .font(.system(size: 14, weight: .regular))
                            }
                            .padding(.init(top: 10, leading: 10, bottom: 10, trailing: 10))
                        }
                        .aspectRatio(2, contentMode: .fit)
                    }
                }
            }
        }
    }
}

struct QuickPayWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        QuickPayWidgetView()
            .previewLayout(.fixed(width: 400, height: 300))
    }
}
