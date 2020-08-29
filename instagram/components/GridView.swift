//
//  GridView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/28/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import SDWebImageSwiftUI
import SwiftUI

struct GridView: View {
  var grid2dArr: [[String]]
  private let column = 4

  var body: some View {
    List {
      ForEach(0..<grid2dArr.count, id: \.self) { y in
        GridRowView(
          row: self.grid2dArr[y],
          width: UIScreen.main.bounds.width / CGFloat(self.column))
      }
    }
  }
}

private struct GridRowView: View {
  var row: [String]
  var width: CGFloat

  var body: some View {
    HStack(spacing: 0) {
      ForEach(0..<row.count, id: \.self) { x in
        GridCellView(imageUrl: self.row[x], width: self.width)
      }
    }.listRowInsets(.init())
  }
}

private struct GridCellView: View {
  var imageUrl: String
  var width: CGFloat

  var body: some View {
    WebImage(url: URL(string: imageUrl))
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: self.width, height: self.width)
      .border(Color.secondary, width: 1)
      .clipped()
  }
}

struct GridView_Previews: PreviewProvider {
  static var previews: some View {
    GridView(grid2dArr: [])
  }
}
