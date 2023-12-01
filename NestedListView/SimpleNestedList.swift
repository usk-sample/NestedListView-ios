//
//  SimpleNestedList.swift
//  NestedListView
//
//  Created by Yusuke Hasegawa on 2023/12/01.
//

import SwiftUI

struct SimpleNestedList: View {
    
    @State var items: [SimpleParent] = [
        SimpleParent(text: "parent 1", children: [
            SimpleChild(text: "child 1"),
            SimpleChild(text: "child 2")
        ]),
        SimpleParent(text: "parent 2", children: [
            SimpleChild(text: "child 1"),
            SimpleChild(text: "child 2")
        ])
    ]
    
    var body: some View {
        
        VStack {
            SimpleNestedListView(items: items)
            HStack {
                Button("add parent") {
                    self.items.append(.init(text: "new parent", children: []))
                }
                Spacer()
                Button("add child") {
                    self.items[items.count-1].children.append(.init(text: "new child"))
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
}
