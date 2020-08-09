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

final class PhotoAPI: ObservableObject {
  @Published var imageDatas: [Data] = []
  private var imageDataWithKey: [Int: Data] = [:]
  //    var publisher: AnyPublisher<[Data], Error>
  //  private var bag = Set<AnyCancellable>()

  //  private let nameSubject = PassthroughSubject<(Int, Data), Never>()
  //  var namePublisher: AnyPublisher<(Int, Data), Never> {
  //    return nameSubject.eraseToAnyPublisher()
  //  }

  private let nameSubject = PassthroughSubject<(Int, UIImage), Never>()
  var namePublisher: AnyPublisher<(Int, UIImage), Never> {
    return nameSubject.eraseToAnyPublisher()
  }

  @Published var results: PHFetchResult<PHAsset>?

  var size: CGSize = .zero

  init(  //    size: CGSize
  ) {
    fetchGallaryData()
    //    self.size = size

    //    self.nameSubject.scan(
    //      [:],
    //      { acc, current -> [Int: Data] in
    //        var acc = acc
    //        acc[current.0] = current.1
    //        return acc
    //      }
    //    ).map {
    //      $0.map { $0.value }
    //    }
    //    .assign(to: \.imageDatas, on: self)
    //    .store(in: &self.bag)

    //    .namePublisher.scan(
    //      [:],
    //      { acc, current -> [Int: Data] in
    //        var acc = acc
    //        acc[current.0] = current.1
    //        return acc
    //      }
    //    )
    //        .map {
    //      $0.compactMap { UIImage(data: $0.value) }
    //        .chunked(into: 4)
    //    }
    //    .receive(on: RunLoop.main)
    //    .assign(to: \.rows, on: self)
    //    .store(in: &bag)
  }

  private func fetchGallaryData() {
    let status = PHPhotoLibrary.authorizationStatus()
    if status == .denied || status == .restricted {
      return
    } else {
      PHPhotoLibrary.requestAuthorization { (authStatus) in
        if authStatus == .authorized {
          let imageAsset = PHAsset.fetchAssets(with: .image, options: nil)
          DispatchQueue.main.async {
            self.results = imageAsset
          }
          //          for index in 0..<imageAsset.count {
          //            self.fetchUIImage(asset: imageAsset[index])
          //          }
        }
      }
    }
  }

  private func fetchUIImage(asset: PHAsset) {
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
        self.nameSubject.send((key, image))
      }
    }

    //    manager.requestImageDataAndOrientation(for: asset, options: options) { data, _, _, info in
    //      if let key = info?["PHImageResultRequestIDKey"] as? Int, let data = data {
    //        //        promise.
    //        //        Just((key, data)).scan(
    //        //              [:],
    //        //              { acc, current -> [Int: Data] in
    //        //                var acc = acc
    //        //                acc[current.0] = current.1
    //        //                return acc
    //        //              }
    //        //        self.imageDataWithKey[key] = data
    //        self.nameSubject.send((key, data))
    //        //            DispatchQueue.main.async {
    //        //              self.imageDatas = self.imageDataWithKey
    //        //                .sorted { $0.0 < $1.0 }
    //        //                .map { $0.value }
    //        //            }
    //
    //      }
    //    }

  }
}
