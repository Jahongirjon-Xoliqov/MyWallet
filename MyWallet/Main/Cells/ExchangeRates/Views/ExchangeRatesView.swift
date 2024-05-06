//
//  ExchangeRatesView.swift
//  MyWallet
//
//  Created by Dzakhon on 05/05/24.
//

import SwiftUI

struct ExchangeRatesView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.gray.opacity(0.1))
            HStack {
                VStack {
                    HStack {
                        Image("cardBackground")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 20)
                        Text("$1 USD")
                            .font(.system(size: 14))
                        Spacer()
                    }
                    Spacer(minLength: 5)
                    HStack {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.green.opacity(0.1))
                            VStack(alignment: .leading) {
                                Text("Buy")
                                    .font(.system(size: 11))
                                    .foregroundColor(.gray)
                                Text("12 700 uzs")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black)
                            }
                            .padding(.init(top: 3, leading: 3, bottom: 3, trailing: 3))
                        }
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.red.opacity(0.1))
                            VStack(alignment: .leading) {
                                Text("Sell")
                                    .font(.system(size: 11))
                                    .foregroundColor(.gray)
                                Text("13 121 uzs")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black)
                            }
                            .padding(.init(top: 3, leading: 3, bottom: 3, trailing: 3))
                        }
                    }
                }
                Spacer()
                Image("cardBackground")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 8))
        }
        
    }
}

struct ExchangeRatesView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRatesView()
            .previewLayout(.fixed(width: 300, height: 70))
    }
}

