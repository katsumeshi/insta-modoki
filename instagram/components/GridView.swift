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
    var column: Int
    var didClick: (_ position: Int) -> Void

  var body: some View {
    ScrollView {
        

        LazyVStack(alignment: .leading, spacing: 0) {
      ForEach(0..<grid2dArr.count, id: \.self) { y in
        GridCellView(y: y, width: UIScreen.main.bounds.width / CGFloat(self.column))
      }
        }
    }
  }
    func GridCellView(y: Int, width: CGFloat) -> some View {
      LazyHStack(spacing: 0) {
        ForEach(0..<grid2dArr[y].count, id: \.self) { x in
            GridCellView(x: x, y: y, width: width)
        }
      }
    }
    func GridCellView(x: Int, y: Int, width: CGFloat) -> some View {
      Button(action: {
          didClick(y * column + x)
      }) {
          WebImage(url: URL(string: grid2dArr[y][x]))
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: width)
            .border(Color.secondary, width: 1)
            .clipped()
      }
    }
}

struct GridView_Previews: PreviewProvider {
  static var previews: some View {
    GridView(grid2dArr: [], column: 3) {_ in 
        
    }
  }
}
