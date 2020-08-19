//
//  GarallyCellViewModel.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/8/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import Photos
import UIKit.UIImage

final class GarallyCellViewModel: ObservableObject {
  @Published var uiImage: UIImage = UIImage()
  private var bag = Set<AnyCancellable>()

  init(asset: PHAsset?, photos: PhotoAPI, size: CGSize) {
    if let asset = asset {
      photos.fetchUIImage(asset: asset, size: size)
        .sink(receiveValue: { [weak self] in
          self?.uiImage = $0
        })
        .store(in: &bag)
    }
  }

  deinit {
    print("GarallyCellViewModel released")
  }
}
