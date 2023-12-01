//
//  ComplicatedNestedList.swift
//  NestedListView
//
//  Created by Yusuke Hasegawa on 2023/12/01.
//

import SwiftUI

struct ComplicatedNestedList: View {
    
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
            ComplicatedNestedListView(items: items)
                .frame(maxHeight: .infinity)
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

struct ComplicatedNestedListView: View {
    
    var items: [SimpleParent]
    
    var body: some View {
        List {
            ForEach(items.indices, id: \.self) { index in
                VStack {
                    HStack {
                        Text(items[index].text)
                        Spacer()
                    }
                    
                    if items[index].children.count > 0 {
                        
                        List {
                            ForEach(items[index].children.indices, id: \.self) { index2 in
                                HStack {
                                    Spacer()
                                    Text(items[index].children[index2].text)
                                }
                            }
                        }
                        .listStyle(.plain)
                        .frame(height: 40 * CGFloat(items[index].children.count))
                       
                    }
                }
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
