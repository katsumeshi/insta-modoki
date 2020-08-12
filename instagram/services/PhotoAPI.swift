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
  private var thumbNailsize: CGSize

  init(size: CGSize = .zero) {
    thumbNailsize = size
  }

  func fetchGallaryData() -> AnyPublisher<PHFetchResult<PHAsset>, PhotoAPIError> {
    return Future { promise in
      let status = PHPhotoLibrary.authorizationStatus()
      if status == .denied || status == .restricted {
        promise(.failure(.permissionError))
      } else {
        PHPhotoLibrary.requestAuthorization { (authStatus) in
          if authStatus == .authorized {
            let imageAsset = PHAsset.fetchAssets(with: .image, options: nil)
            DispatchQueue.main.async {
              promise(.success(imageAsset))
              let options = PHImageRequestOptions()
              options.isNetworkAccessAllowed = true
              self.imageManager.startCachingImages(
                for: imageAsset.objects(at: IndexSet(0...imageAsset.count - 1)),
                targetSize: self.thumbNailsize,
                contentMode: .aspectFill, options: options)
            }
          }
        }
      }
    }
    .eraseToAnyPublisher()
  }

  func fetchUIImage(asset: PHAsset) -> AnyPublisher<UIImage, PhotoAPIError> {
    return Future { promise in
      let options = PHImageRequestOptions()
      options.isNetworkAccessAllowed = true
      self.imageManager.requestImage(
        for: asset,
        targetSize: PHImageManagerMaximumSize,
        contentMode: .aspectFit, options: .none
      ) { (image, info) in
        if let image = image {
          promise(.success(image))
        }
        promise(.failure(.fetchImageError))
      }
    }
    .eraseToAnyPublisher()
  }

  deinit {
    print("PhotoAPI released")
  }

  //  private func fetchUIImage(asset: PHAsset) {
  //    let manager = PHImageManager.default()
  //    let options = PHImageRequestOptions()
  //    options.deliveryMode = .fastFormat
  //    options.isNetworkAccessAllowed = true
  //
  //    manager.requestImage(
  //      for: asset,
  //      targetSize: PHImageManagerMaximumSize,
  //      contentMode: .aspectFit, options: .none
  //    ) { (image, info) in
  //      if let key = info?["PHImageResultRequestIDKey"] as? Int, let image = image {
  //        self.nameSubject.send((key, image))
  //      }
  //    }
  //
  //    //    manager.requestImageDataAndOrientation(for: asset, options: options) { data, _, _, info in
  //    //      if let key = info?["PHImageResultRequestIDKey"] as? Int, let data = data {
  //    //        //        promise.
  //    //        //        Just((key, data)).scan(
  //    //        //              [:],
  //    //        //              { acc, current -> [Int: Data] in
  //    //        //                var acc = acc
  //    //        //                acc[current.0] = current.1
  //    //        //                return acc
  //    //        //              }
  //    //        //        self.imageDataWithKey[key] = data
  //    //        self.nameSubject.send((key, data))
  //    //        //            DispatchQueue.main.async {
  //    //        //              self.imageDatas = self.imageDataWithKey
  //    //        //                .sorted { $0.0 < $1.0 }
  //    //        //                .map { $0.value }
  //    //        //            }
  //    //
  //    //      }
  //    //    }
  //
  //  }
}
