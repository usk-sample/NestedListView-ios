//
//  ContentView.swift
//  NestedListView
//
//  Created by Yusuke Hasegawa on 2023/12/01.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            SimpleNestedList()
                .tabItem { Label("simple list", systemImage: "globe") }
            ComplicatedNestedList()
                .tabItem { Label("complicated list", systemImage: "globe") }

        }
    }
}

#Preview {
    ContentView()
}
