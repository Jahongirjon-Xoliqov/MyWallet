//
//  SavedOperationWidgetView.swift
//  MyWallet
//
//  Created by Dzakhon on 03/05/24.
//

import SwiftUI

struct SavedOperationWidgetView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.gray.opacity(0.1))
            VStack {
                Spacer(minLength: 5)
                Text("Dent 2 etaj")
                    .lineLimit(1)
                    .font(.system(size: 11, weight: .medium))
                Spacer(minLength: 5)
                Text("8600****7321")
                    .lineLimit(1)
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(.gray)
                Spacer(minLength: 5)
                Text("50 000 uzs")
                    .lineLimit(1)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.gray)
                Spacer(minLength: 5)
                ZStack {
                    RoundedRectangle(cornerRadius: 7.5)
                        .fill(.gray.opacity(0.2))
                    VStack {
                        Image("cardTypeLogoHumo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(minWidth: 20, maxWidth: 35)
                            .aspectRatio(1.5, contentMode: .fit)
                    }
                    .padding(.init(top: 5,
                                   leading: 10,
                                   bottom: 5,
                                   trailing: 10))
                }
            }
            .padding(.init(top: 0,
                           leading: 5,
                           bottom: 5,
                           trailing: 5))
        }
    }
}

struct SavedOperationWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        SavedOperationWidgetView()
            .previewLayout(.fixed(width: 100, height: 100))
    }
}
