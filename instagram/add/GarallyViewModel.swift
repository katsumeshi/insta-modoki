//
//  GarallyViewModel.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/8/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import Photos
import SwiftUI

final class GarallyViewModel: ObservableObject {
  @Published var selectIndex: Int = 0
  @Published var assets: PHFetchResult<PHAsset> = PHFetchResult()
  @Published var grid2dArr: [[Int]] = []
  @Published var selectedTabItem = 1
  @Published var previewImage: UIImage = UIImage()

  static let columnNum: CGFloat = 4
  static let thumbNailWidth = UIScreen.main.bounds.width / GarallyViewModel.columnNum
  static let previewSize = CGSize(
    width: UIScreen.main.bounds.width * 3, height: UIScreen.main.bounds.width * 3)
  static let actualThumbnailSize = CGSize(
    width: GarallyViewModel.thumbNailWidth * 3, height: GarallyViewModel.thumbNailWidth * 3)
  var photos: PhotoAPI
  private var bag = Set<AnyCancellable>()

  init() {
    photos = PhotoAPI()
    photos.fetchGallaryData(size: GarallyViewModel.actualThumbnailSize).sink(
      receiveCompletion: { _ in
      },
      receiveValue: { [weak self] in
        self?.assets = $0
        self?.grid2dArr = Array(0...max((($0.count) - 1), 0)).chunked(
          into: Int(GarallyViewModel.columnNum))
        self?.setPreviewImage(index: self?.selectIndex ?? 0)
      }
    )
    .store(in: &bag)

    $selectIndex.sink(receiveValue: { [weak self] index in
      self?.setPreviewImage(index: index)
    }).store(in: &bag)
  }

  private func setPreviewImage(index: Int) {
    if let asset = self.getAssetFromIndex(index: index) {
      self.photos.fetchUIImage(asset: asset, size: PHImageManagerMaximumSize)
        .sink(receiveValue: { [weak self] in
          self?.previewImage = $0
        }).store(in: &self.bag)
    }
  }

  func getAssetFromIndex(index: Int) -> PHAsset? {
    return getAsset(
      x: index % Int(GarallyViewModel.columnNum),
      y: index / Int(GarallyViewModel.columnNum))
  }

  func getAsset(x: Int, y: Int) -> PHAsset? {
    if assets.count > 0 {
      return assets.object(at: (y * Int(GarallyViewModel.columnNum)) + x)
    }
    return nil
  }

  deinit {
    print("GarallyViewModel released")
  }

}
