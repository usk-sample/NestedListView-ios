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
