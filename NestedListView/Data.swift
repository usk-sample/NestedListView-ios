//
//  Data.swift
//  NestedListView
//
//  Created by Yusuke Hasegawa on 2023/12/01.
//

import Foundation

struct SimpleParent {
    let text: String
    var children: [SimpleChild]
}

struct SimpleChild {
    let text: String
}

struct Item: Identifiable {
    let id: String
    let text: String
    var subItems: [Item]
}

extension Item {
    static func item(text: String, subItems: [Item] = []) -> Item {
        return .init(id: UUID().uuidString, text: text, subItems: subItems)
    }
}
