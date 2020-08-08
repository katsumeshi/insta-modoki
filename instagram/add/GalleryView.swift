//
//  GalleryView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/7/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Photos
import SwiftUI
import UIKit

struct GalleryView: View {

  private var width: CGFloat = UIScreen.main.bounds.width
  @ObservedObject private var photos = PhotoAPI(
    size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
  @State private var selectIndex = 0

  var body: some View {
    //    let images = self.photos.mapImages.map { $0.value }
    let rows = self.photos.images.chunked(into: 3)
    return
      VStack(spacing: 0) {
        ZStack {
          HStack {
            Spacer()
            Text("Gallary")
            Spacer()
          }
          HStack {
            Spacer()
            Image(systemName: "xmark").padding()
          }
        }.frame(height: 40)
        if rows.count > 0 && rows[0].count > 0 {
          Image(uiImage: rows[self.selectIndex / 3][self.selectIndex % 3])
            .resizable()
            .frame(width: width, height: width)
        }
        List {
          ForEach(0..<rows.count, id: \.self) { i in
            HStack(spacing: 0) {
              ForEach(0..<rows[i].count, id: \.self) { j in
                Button(action: { self.selectIndex = (i * 3) + j }) {
                  Image(uiImage: rows[i][j])
                    .resizable()
                    .frame(width: self.width / 3, height: self.width / 3)
                    .border(Color.secondary, width: 1)
                }.buttonStyle(PlainButtonStyle())
              }
            }.listRowInsets(.init())
          }
        }
      }
  }
}

struct GalleryView_Previews: PreviewProvider {
  static var previews: some View {
    GalleryView()
  }
}

class PhotoAPI: ObservableObject {
  @Published var images: [UIImage] = []
  private var mapImages: [Int: UIImage] = [:]

  var size: CGSize = .zero
  init(size: CGSize) {
    fetchGallaryData()
    self.size = size
  }

  private func fetchGallaryData() {
    let status = PHPhotoLibrary.authorizationStatus()
    if status == .denied || status == .restricted {
      return
    } else {
      PHPhotoLibrary.requestAuthorization { (authStatus) in
        if authStatus == .authorized {
          let imageAsset = PHAsset.fetchAssets(with: .image, options: nil)
          for index in 0..<imageAsset.count {
            self.fetchUIImage(asset: imageAsset[index])
          }
        }
      }
    }
  }

  private func fetchUIImage(asset: PHAsset) {
    let manager = PHImageManager.default()
    let options = PHImageRequestOptions()
    manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: options) {
      (image, info) in
      if let key = info?["PHImageResultRequestIDKey"] as? Int, let image = image {
        self.mapImages[key] = image
        DispatchQueue.main.async {
          self.images = self.mapImages
                            .sorted { $0.0 < $1.0 }
                            .map { $0.value }
        }
      }
    }
  }

}
