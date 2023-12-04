//
//  ComplicatedNestedList.swift
//  NestedListView
//
//  Created by Yusuke Hasegawa on 2023/12/01.
//

import SwiftUI

struct ComplicatedNestedList: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            ComplicatedNestedListView(items: viewModel.items)
                .frame(maxHeight: .infinity)
            HStack {
                Button("add parent") {
                    viewModel.items.append(.init(text: "new parent", children: []))
                    viewModel.update()
                }
                Spacer()
                Button("add child") {
                    viewModel.items[viewModel.items.count-1].children.append(.init(text: "new child"))
                    viewModel.update()
                }
            }.padding()
        }
    }
}

struct ComplicatedNestedListView: View {
    
    var items: [SimpleParent]
    
    var body: some View {
        List {
            ForEach(items.indices, id: \.self) { index in
                ComplecatedNestedRow(item: items[index])
            }
        }
    }
}

struct ComplecatedNestedRow: View {
    
    var item: SimpleParent
    
    var body: some View {
        VStack {
            HStack {
                Text(item.text)
                Spacer()
            }
            
            if item.children.count > 0 {
                
                List {
                    ForEach(item.children.indices, id: \.self) { index in
                        ComplecatedNestedSubRow(child: item.children[index])
                    }
                }
                .listStyle(.plain)
                .frame(height: 40 * CGFloat(item.children.count))
               
            }
        }
    }
    
}

struct ComplecatedNestedSubRow: View {
    
    var child: SimpleChild
    
    var body: some View {
        HStack {
            Spacer()
            Text(child.text)
        }
    }
}

#Preview {
    ComplicatedNestedList()
}
