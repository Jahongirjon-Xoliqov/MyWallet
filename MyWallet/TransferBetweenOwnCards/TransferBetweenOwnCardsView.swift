//
//  TransferBetweenOwnCardsView.swift
//  MyWallet
//
//  Created by Dzakhon on 17/07/24.
//

import SwiftUI

struct TransferBetweenOwnCardsView: View {
    @State var transferAmountString = ""
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    //navigate back
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                })
                Spacer()
                Text("Transfer between cards")
                Spacer()
                Button(action: {}, label: {
                    Image(systemName: "info.circle")
                })
            }.padding(
                EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            )
            HStack {
                Text("From card")
                    .font(.system(size: 17, weight: .bold))
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false, content: {
                let bankCardModel = UZBBankCardViewModel(
                    number: "9860 0903 9345 0022",
                    expirationDate: "08/26",
                    cardholderName: "JAHONGIRJON KHOLIKOV",
                    brandImageUrl: "bankCardLogoSQB",
                    typeImageUrl: "cardTypeLogoHumo",
                    coverImageUrl: "cardBackground"
                )
                HStack(spacing: 20) {
                    SQBCardView(model: bankCardModel)
                        .frame(width: 344, height: 220)
                    SQBCardView(model: bankCardModel)
                        .frame(width: 344, height: 220)
                    SQBCardView(model: bankCardModel)
                        .frame(width: 344, height: 220)
                    SQBCardView(model: bankCardModel)
                        .frame(width: 344, height: 220)
                    SQBCardView(model: bankCardModel)
                        .frame(width: 344, height: 220)
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            })
            ZStack(alignment: .top) {
                VStack {
                    HStack {
                        Text("To card")
                            .font(.system(size: 17, weight: .bold))
                        Spacer()
                    }.padding(
                        EdgeInsets(top: 17, leading: 30, bottom: 0, trailing: 0)
                    )
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        let bankCardModel = UZBBankCardViewModel(
                            number: "9860 0903 9345 0022",
                            expirationDate: "08/26",
                            cardholderName: "JAHONGIRJON KHOLIKOV",
                            brandImageUrl: "bankCardLogoSQB",
                            typeImageUrl: "cardTypeLogoHumo",
                            coverImageUrl: "cardBackground"
                        )
                        HStack(spacing: 20) {
                            SQBCardView(model: bankCardModel)
                                .frame(width: 344, height: 220)
                            SQBCardView(model: bankCardModel)
                                .frame(width: 344, height: 220)
                            SQBCardView(model: bankCardModel)
                                .frame(width: 344, height: 220)
                            SQBCardView(model: bankCardModel)
                                .frame(width: 344, height: 220)
                            SQBCardView(model: bankCardModel)
                                .frame(width: 344, height: 220)
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    })
                }
                Button(action: {
                    //
                }, label: {
                    Image(systemName: "chevron.down")
                        .foregroundColor(.white)
                })
                .frame(width: 40, height: 40)
                .background(Color.blue)
                .clipShape(Circle())
            }
            Spacer()
            TextField(
                "Family Name",
                text: $transferAmountString
            )
            
        }
    }
}

#Preview {
    TransferBetweenOwnCardsView()
}

import SwiftUI
import Combine

public struct KeyboardPaddingModifier: ViewModifier {
    @State private var bottomPadding: CGFloat? = .zero
    @State private var notification: KeyboardNotification?
    private var notificationPublisher: AnyPublisher<KeyboardNotification?, Never>
    private let animation: Animation

    public init(animation: Animation) {
        self.animation = animation

        notificationPublisher = NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .merge(with: NotificationCenter.default
                    .publisher(for: UIResponder.keyboardWillChangeFrameNotification))
            .merge(with: NotificationCenter.default
                    .publisher(for: UIResponder.keyboardWillHideNotification))
            .map { KeyboardNotification(notification: $0) }
            .eraseToAnyPublisher()
    }

    public func body(content: Content) -> some View {
        content
            .padding(.bottom, bottomPadding)
            .onReceive(Just(notification?.height), perform: { value in
                bottomPadding = 500
                guard let value else { return }

                if value == 0 {
                    withAnimation(animation) {
                        bottomPadding = .zero
                    }
                } else {
                    bottomPadding = 500
                }
            })
            
    }
}

private struct KeyboardNotification {
    let height: CGFloat

    init?(notification: UIKit.Notification) {
        guard
            [
                UIWindow.keyboardWillShowNotification,
                UIWindow.keyboardWillHideNotification,
                UIWindow.keyboardWillChangeFrameNotification
            ].contains(notification.name),
            let userInfo = notification.userInfo,
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return nil
        }

        let height: CGFloat = {
            switch notification.name {
                case UIWindow.keyboardWillShowNotification: return endFrame.height
                case UIWindow.keyboardWillChangeFrameNotification: return endFrame.height
                default: return 0
            }
        }()

        self.height = height
    }
}

public extension View {
    func keyboardPadding(animation: Animation = .easeOut) -> some View {
        modifier(KeyboardPaddingModifier(animation: animation))
    }
}
