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

  static let columnNum: CGFloat = 4
  static let thumbNailWidth = UIScreen.main.bounds.width / GarallyViewModel.columnNum
  static let thumbnailSize = CGSize(
    width: GarallyViewModel.thumbNailWidth, height: GarallyViewModel.thumbNailWidth)
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
      }
    )
    .store(in: &bag)

  }

  func getAssetFromIndex() -> PHAsset? {
    return getAsset(
      x: selectIndex % Int(GarallyViewModel.columnNum),
      y: selectIndex / Int(GarallyViewModel.columnNum))
  }

  func getAsset(x: Int, y: Int) -> PHAsset? {
    return assets.object(at: (y * Int(GarallyViewModel.columnNum)) + x)
  }

  deinit {
    print("GarallyViewModel released")
  }

}
