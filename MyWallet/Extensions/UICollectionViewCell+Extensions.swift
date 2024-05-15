//
//  UICollectionViewCell+Extensions.swift
//  MyWallet
//
//  Created by Dzakhon on 11/05/24.
//

import UIKit
import SwiftUI

extension UICollectionViewCell {
    
    public func addSUIView<Content>(_ swiftUIView: Content, margins: (edges: Edge.Set, length: CGFloat) = (.all, 0)) where Content: View {
        if #available(iOS 16.0, *) {
            contentConfiguration = UIHostingConfiguration {
                swiftUIView
            }
            .margins(margins.edges, margins.length)
        } else {
            addSubSwiftUIView(swiftUIView)
        }
    }
    
}
