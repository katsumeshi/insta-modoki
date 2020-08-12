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
  let thumbNailsize = CGSize(
    width: GarallyViewModel.thumbNailWidth, height: GarallyViewModel.thumbNailWidth)
  var photos: PhotoAPI
  private var bag = Set<AnyCancellable>()

  init() {
    photos = PhotoAPI(size: GalleryView.thumbnailSize)
    photos.fetchGallaryData().sink(
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
