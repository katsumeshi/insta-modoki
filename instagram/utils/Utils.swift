//
//  Utils.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/7/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Foundation

extension Array {
  func chunked(into size: Int) -> [[Element]] {
    return stride(from: 0, to: count, by: size).map {
      Array(self[$0..<Swift.min($0 + size, count)])
    }
  }
}
