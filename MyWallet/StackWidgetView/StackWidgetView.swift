//
//  StackWidgetView.swift
//  MyWallet
//
//  Created by Dzakhon on 21/06/24.
//

import SwiftUI

struct StackWidgetData: Identifiable {
    var id: Int
    var name: String
}

struct StackWidgetView: View {
    @State var data: [StackWidgetData] = [
        StackWidgetData(id: 1, name: "Alex"),
        StackWidgetData(id: 2, name: "Joe"),
        StackWidgetData(id: 3, name: "Mark"),
        StackWidgetData(id: 4, name: "Terry")
    ]
    var body: some View {
        List {
            ForEach(data) { data in
                CollectionView(content: data)
            }
        }
    }
    private struct CollectionView: View {
        @State var content: StackWidgetData
        var body: some View {
            Text("\(content.name)")
        }
    }
}

#Preview {
    StackWidgetView()
}
