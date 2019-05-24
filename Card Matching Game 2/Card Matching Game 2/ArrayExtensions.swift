//
//  ArrayExtensions.swift
//  Card Matching Game 2
//
//  Created by student on 2019/3/27.
//  Copyright © 2019年 ntutlab412. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle() {
        if self.count < 2 { return }
        for i in 0..<(self.count - 1) {
            let j = Int(arc4random_uniform(UInt32(self.count - i))) + i
            self.swapAt(i, j)
        }
    }
}
