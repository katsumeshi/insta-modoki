//
//  photoAPI.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/8/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import Foundation
import Photos
import UIKit

enum PhotoAPIError: Error {
  case fetchImageError
  case permissionError
}

final class PhotoAPI: ObservableObject {
  private let imageManager = PHCachingImageManager()
  private static var options: PHImageRequestOptions {
    let options = PHImageRequestOptions()
    options.isNetworkAccessAllowed = true
    options.isSynchronous = true
    return options
  }

  init() {}

  func fetchGallaryData(size: CGSize) -> AnyPublisher<PHFetchResult<PHAsset>, PhotoAPIError> {
    return Future { promise in
      let status = PHPhotoLibrary.authorizationStatus()
      if status == .denied || status == .restricted {
        promise(.failure(.permissionError))
      } else {
        PHPhotoLibrary.requestAuthorization { (authStatus) in
          if authStatus == .authorized {
            let imageAsset = PHAsset.fetchAssets(with: .image, options: nil)
            DispatchQueue.main.async { [weak self] in
              promise(.success(imageAsset))
              self?.imageManager.startCachingImages(
                for: imageAsset.objects(at: IndexSet(0...imageAsset.count - 1)),
                targetSize: size,
                contentMode: .aspectFit, options: PhotoAPI.options)
            }
          }
        }
      }
    }
    .eraseToAnyPublisher()
  }

  func fetchUIImage(asset: PHAsset, size: CGSize) -> AnyPublisher<UIImage, Never> {
    let subject = CurrentValueSubject<UIImage, Never>(UIImage())
    self.imageManager.requestImage(
      for: asset,
      targetSize: size,
      contentMode: .aspectFit,
      options: PhotoAPI.options
    ) { (image, info) in
      if let image = image {
        subject.send(image)
      }
    }
    return subject.eraseToAnyPublisher()
  }

  static func fetchMaxImage(asset: PHAsset) -> AnyPublisher<UIImage, Never> {
    let subject = CurrentValueSubject<UIImage, Never>(UIImage())
    PHImageManager.default().requestImage(
      for: asset,
      targetSize: PHImageManagerMaximumSize,
      contentMode: .aspectFit,
      options: PhotoAPI.options
    ) { (image, info) in
      if let image = image {
        subject.send(image)
      }
    }
    return subject.eraseToAnyPublisher()
  }

  deinit {
    print("PhotoAPI released")
  }
}
