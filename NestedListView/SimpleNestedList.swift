//
//  SimpleNestedList.swift
//  NestedListView
//
//  Created by Yusuke Hasegawa on 2023/12/01.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    var items: [SimpleParent] = [
        SimpleParent(text: "parent 1", children: [
            SimpleChild(text: "child 1"),
            SimpleChild(text: "child 2")
        ]),
        SimpleParent(text: "parent 2", children: [
            SimpleChild(text: "child 1"),
            SimpleChild(text: "child 2")
        ])
    ]
    
    func getItems() -> [SimpleParent] {
        return items
    }
    
    func update() {
        objectWillChange.send()
    }
    
}

struct SimpleNestedList: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        
        VStack {
            SimpleNestedListView(items: viewModel.getItems())
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

struct SimpleNestedListView: View {
    
    var items: [SimpleParent]
    
    var body: some View {
        List {
            
            ForEach(items.indices, id: \.self) { index in
                SimpleNestedRow(item: items[index])
            }
            
        }
        .frame(maxHeight: .infinity)
    }
    
}

struct SimpleNestedRow: View {
    
    var item: SimpleParent
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(item.text)
                Spacer()
            }
            
            if item.children.count > 0 {
                ForEach(item.children.indices, id: \.self) { index in
                    SimpleNestedSubRow(child: item.children[index])
                }
                
                Text("count:\(item.children.count)")
            }
            
            Button("Add") {
                guard let index = viewModel.getItems().firstIndex(where: { $0.text == item.text }) else { return }
                viewModel.items[index].children.append(.init(text: "new child"))
                viewModel.update()
            }
            
        }
    }
    
}

struct SimpleNestedSubRow: View {
    
    var child: SimpleChild
    
    var body: some View {
        HStack {
            Spacer()
            Text(child.text)
        }
    }
}

#Preview {
    SimpleNestedList()
        .environmentObject(ViewModel())
}
