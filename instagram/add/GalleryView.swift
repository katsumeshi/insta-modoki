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
  @State private var selectIndex = 0
  @ObservedObject var photos = PhotoAPI()
  @ObservedObject var viewModel = GarallyViewModel(PhotoAPI())
  private let size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
  private let width = UIScreen.main.bounds.width
  let cellWidth = UIScreen.main.bounds.width / 4

  var body: some View {
    let y = self.selectIndex / 4
    let x = self.selectIndex % 4
    //    let rows: [[UIImage]] = viewModel.rows
    //    let cellWidth = self.width / CGFloat(rowNum)
    //    let rows = photos.ima
    //    let r = (photos.results?.count ?? 0) / 4
    let arr = Array(0...max(((photos.results?.count ?? 0) - 1), 0)).chunked(into: 4)
    print(arr.count)
    print(arr[0].count)
    return VStack(spacing: 0) {
      ZStack {
        HStack {
          Spacer()
          Text("Gallary")
          Spacer()
        }
        HStack {
          Image(systemName: "xmark").padding()
          Spacer()
          Text("Next").padding()
        }
      }.frame(height: 40)
      if viewModel.rows.count > 0 && viewModel.rows[0].count > 0 {
        Image(uiImage: viewModel.rows[y][x])
          .resizable()
          .frame(width: width, height: width)
      }
      List {
        ForEach(0..<arr.count, id: \.self) { i in
          HStack(spacing: 0) {
            ForEach(0..<arr[i].count, id: \.self) { j in
              Button(action: { self.selectIndex = (i * 4) + j }) {
                GalleryCellView(asset: self.aaa(x: j, y: i))
                //                Text("")
                //                Image(uiImage: abc())
                //                  .resizable()
                //                  .frame(width: self.cellWidth, height: self.cellWidth)
                //                  .border(Color.secondary, width: 1)
                //                  .overlay(Rectangle().fill(Color.white).opacity(self.getOp(i: i, j: j)))
              }.buttonStyle(PlainButtonStyle())
            }
          }.listRowInsets(.init())
        }
      }
    }
  }

  private func ccc(i: Int) -> Int {
    return (self.photos.results?.count ?? 0) - i * 4
  }

  private func aaa(x: Int, y: Int) -> PHAsset? {
    return self.photos.results?.object(at: (y * 4) + x)
  }
  //    self.viewModel.rows[i][j]
  //    private func abc() -> UIImage {
  //
  //    }

  private func getOp(i: Int, j: Int) -> Double {
    let y = self.selectIndex / 4
    let x = self.selectIndex % 4
    return (i == y && j == x) ? 0.6 : 0.0
  }
}

final class GarallyCellViewModel: ObservableObject {

  @Published var uiImage: UIImage = UIImage()

  func fetchUIImage(asset: PHAsset) {
    let manager = PHImageManager.default()
    let options = PHImageRequestOptions()
    options.deliveryMode = .fastFormat
    options.isNetworkAccessAllowed = true

    manager.requestImage(
      for: asset,
      targetSize: PHImageManagerMaximumSize,
      contentMode: .aspectFit, options: .none
    ) { (image, info) in
      if let key = info?["PHImageResultRequestIDKey"] as? Int, let image = image {
        //          self.nameSubject.send((key, image))
        self.uiImage = image
      }
    }
  }
}

struct GalleryCellView: View {
  var asset: PHAsset?
  let cellWidth = UIScreen.main.bounds.width / 4
  @ObservedObject var viewModel = GarallyCellViewModel()

  //    @State var uiImage: UIImage = UIImage()

  init(asset: PHAsset?) {

    if let asset = asset {
      viewModel.fetchUIImage(asset: asset)
    }
    //
    //            PHImageManager.default().requestImage(
    //                for: asset,
    //                targetSize: PHImageManagerMaximumSize,
    //                contentMode: .aspectFit, options: .none) { (image, info) in
    //                    if let image = image {
    //                        self.uiImage = image
    //                    }
    //
    //                }
    //    }
  }

  var body: some View {
    Image(uiImage: viewModel.uiImage)
      .resizable()
      .frame(width: self.cellWidth, height: self.cellWidth)
      .border(Color.secondary, width: 1)
    //          .overlay(Rectangle().fill(Color.white).opacity(self.getOp(i: i, j: j)))

  }
}

//private func fetchUIImage(asset: PHAsset) {
//  let manager = PHImageManager.default()
//  let options = PHImageRequestOptions()
//  options.deliveryMode = .fastFormat
//  options.isNetworkAccessAllowed = true
//
//  manager.requestImage(
//    for: asset,
//    targetSize: PHImageManagerMaximumSize,
//    contentMode: .aspectFit, options: .none
//  ) { (image, info) in
//    if let key = info?["PHImageResultRequestIDKey"] as? Int, let image = image {
//      self.nameSubject.send((key, image))
//    }
//  }

struct GalleryView_Previews: PreviewProvider {
  static var previews: some View {
    GalleryView()
  }
}
