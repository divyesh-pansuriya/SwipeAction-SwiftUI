//
//  DemoListView.swift
//  SwipeAction-SwftUI
//
//  Created by Divyesh Pansuriya on 1/3/25.
//




import SwiftUI

struct DemoListView: View {
    let items = ["Item 1", "Item 2", "Item 3", "Item 4"]

    var body: some View {
        List(items, id: \.self) { item in
            Text(item)
                .padding() // Add some padding for better touch targets
                .background(Color.clear) // Make the background clear
                .listRowInsets(EdgeInsets()) // Remove the default row insets
        }
        .listStyle(PlainListStyle()) // Use a plain style to avoid additional separators
    }
}
#Preview {
    DemoListView()
}



