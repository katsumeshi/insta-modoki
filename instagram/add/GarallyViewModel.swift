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
      receiveValue: {
        self.assets = $0
      }
    )
    .store(in: &bag)

  }

  deinit {
    print("released GarallyViewModel")
  }

}
