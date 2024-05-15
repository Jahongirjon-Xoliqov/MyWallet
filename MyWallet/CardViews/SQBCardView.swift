//
//  SQBCardView.swift
//  MyWallet
//
//  Created by Dzakhon on 03/05/24.
//

import SwiftUI

struct SQBCardView: View {
    var model: UZBBankCardModelProtocol
    var body: some View {
        ZStack {
            Image(model.coverImageUrl)
                .renderingMode(.original)
                .resizable()
            VStack(alignment: .trailing) {
                Spacer()
                HStack(alignment: .bottom) {
                    Spacer()
                    Image(model.typeImageUrl)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 30)
                }
                .cornerRadius(3)
            }
            .padding(
                .init(top: 0,
                      leading: 0,
                      bottom: 10,
                      trailing: 20)
            )
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    HStack {
                        Image(model.brandImageUrl)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        Spacer()
                    }
                    Spacer(minLength: 20)
                    HStack(alignment: .center){
                        Image(systemName: "rectangle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                            .foregroundColor(.yellow)
                        Image(systemName: "dot.radiowaves.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
                        Spacer()
                    }
                    Spacer(minLength: 10)
                    Button(action: {
                        
                    }, label: {
                        Text(model.number)
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                    })
                    Spacer(minLength: 5)
                    HStack {
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Text(model.expirationDate)
                                .foregroundColor(.white)
                                .font(.system(size: 15))
                        })
                        Spacer()
                    }
                    Spacer(minLength: 3)
                    Text(model.cardholderName)
                        .foregroundColor(.white)
                        .font(.system(size: 17))
                }
            }
            .padding(.init(top: 20,
                           leading: 30,
                           bottom: 10,
                           trailing: 30))
        }
        .cornerRadius(12)
    }
}

struct SQBCardView_Previews: PreviewProvider {
    static var previews: some View {
        let bankCardModel = UZBBankCardViewModel(
            number: "9860 0903 9345 0022",
            expirationDate: "08/26",
            cardholderName: "JAHONGIRJON KHOLIKOV",
            brandImageUrl: "bankCardLogoSQB",
            typeImageUrl: "cardTypeLogoHumo",
            coverImageUrl: "cardBackground"
        )
        SQBCardView(model: bankCardModel)
            .previewLayout(.fixed(width: 344, height: 220))
    }
}
