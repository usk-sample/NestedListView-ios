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
            List {
                
                ForEach(items.indices, id: \.self) { index in
                    VStack {
                        HStack {
                            Text(items[index].text)
                            Spacer()
                        }
                        
                        if items[index].children.count > 0 {
                            ForEach(items[index].children.indices, id: \.self) { index2 in
                                HStack {
                                    Spacer()
                                    Text(items[index].children[index2].text)
                                }
                            }
                           
                        }
                        
                    }
                }
                
            }
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

#Preview {
    SimpleNestedList()
}
