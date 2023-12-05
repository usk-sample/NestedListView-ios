//
//  NestedListView.swift
//  NestedListView
//
//  Created by Yusuke Hasegawa on 2023/12/04.
//

import SwiftUI

struct NestedListView: View {
    
    @State var items: [Item] = [
        .item(text: "task 1"),
        .item(text: "task 2", subItems: [
            .item(text: "sub task a"),
            .item(text: "sub task b")
        ])
    ]
    
    var body: some View {

        VStack {
            
            List {
                ForEach(items) { item in
                    DisclosureGroup(
                        isExpanded: .constant(true), // always shows sub items
                        content: {
                            ForEach(item.subItems) { sub in
                                Text(sub.text)
                            }
                            .onMove { indexSet, index in

                                var item = item
                                item.subItems.move(fromOffsets: indexSet, toOffset: index)
                                                                
                                if let i = item.subItems.firstIndex(where: { $0.id == item.id }) {
                                    item.subItems.move(fromOffsets: indexSet, toOffset: index)
                                    items[i] = item
                                }
                            }
                            .listRowInsets(.init(top: 0, leading: 30, bottom: 0, trailing: 0))
                        },
                        label: { Text(item.text) }

                    ).tint(.clear) // erase expand/collapse icon
                    
                }
                .onMove { indexSet, index in
                    items.move(fromOffsets: indexSet, toOffset: index)
                }
            }
            
            HStack {
                Spacer()
                Button("Add") {
                    self.add()
                }
            }.padding()
            
        }

    }
    
    private func add() {
        
        let isParent = [true, false, false, false].randomElement()!
        if isParent {
            debugPrint("add parent task")
            items.append(.item(text: "new task"))
        } else {
            debugPrint("add sub task")
            items[items.count-1].subItems.append(.item(text: "new sub task"))
        }
        
    }
    
}

#Preview {
    NestedListView()
}
