//
//  GalleryView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/7/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import Photos
import SwiftUI
import UIKit

struct GalleryView: View {
  private let size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
  static let thumbnailSize = CGSize(
    width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
  @ObservedObject var viewModel = GarallyViewModel()
  private let width = UIScreen.main.bounds.width
  let cellWidth = UIScreen.main.bounds.width / 4

  var body: some View {
    let y = self.viewModel.selectIndex / 4
    let x = self.viewModel.selectIndex % 4
    let arr = Array(0...max(((viewModel.assets.count) - 1), 0)).chunked(into: 4)
    return NavigationView {
      VStack(spacing: 0) {
        if viewModel.assets.count > 0 {
          GalleryCellView(asset: self.aaa(x: x, y: y), photos: self.viewModel.photos, width: width)
          List {
            ForEach(0..<arr.count, id: \.self) { i in
              HStack(spacing: 0) {
                ForEach(0..<arr[i].count, id: \.self) { j in
                  Button(
                    action: { self.viewModel.selectIndex = (i * 4) + j },
                    label: {
                      GalleryCellView(
                        asset: self.aaa(x: j, y: i), photos: self.viewModel.photos,
                        width: self.cellWidth)
                    }
                  ).buttonStyle(PlainButtonStyle())
                }
              }.listRowInsets(.init())
            }
          }
        }
      }.navigationBarTitle("Gallary", displayMode: .inline)
        .navigationBarItems(
          leading: Image(systemName: "xmark"),
          trailing:
            Button("Next") {
              print("Help tapped!")
            }
        )
    }
  }

  private func aaa(x: Int, y: Int) -> PHAsset? {
    return self.viewModel.assets.object(at: (y * 4) + x)
  }
}

struct GalleryView_Previews: PreviewProvider {
  static var previews: some View {
    GalleryView()

  }
}
