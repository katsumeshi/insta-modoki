//
//  GarallyViewModel.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/8/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import UIKit.UIImage

final class GarallyViewModel: ObservableObject {
  //    @Published var imageRows: [[UIImage]] = []
  //  private var width: CGFloat = UIScreen.main.bounds.width
  //    @ObservedObject private var photos: PhotoAPI
  ////  @State private var selectIndex = 0
  static let columnNum = 4
  //    private var
  private var bag = Set<AnyCancellable>()
  @Published var rows: [[UIImage]] = []
  var images: [Int: UIImage] = [:]

  init(_ photoAPI: PhotoAPI) {

    photoAPI.namePublisher
      //      .compactMap {
      //        UIImage(data: $0.1)
      //      }
      //      .compactMap {
      //        $0.1
      //      }

      //        .scan(
      //      [:],
      //      { acc, cur -> [Int: Data] in
      //        var acc = acc
      //        acc[cur.0] = cur.1
      //        return acc
      //      }
      //    )
      //    .map {
      //      $0.compactMap { UIImage(data: $0.value) }
      //        .chunked(into: 4)
      //    }
      .receive(on: RunLoop.main)
      .sink(receiveValue: { [weak self] in
        guard let self = self else { return }
        self.images[$0.0] = $0.1
        self.rows = self.images.sorted { $0.0 < $1.0 }.map { $0.value }.chunked(into: 4)
        //        self.images.append($0)
        //        self.rows = self.images.chunked(into: 4)
      })
      //    .assign(to: \.rows, on: self)
      .store(in: &bag)

    //        photoAPI.imageAsset?.enumerateObjects({ (asset, start, stop) in
    //            photoAPI.fetchUIImage(asset: asset)
    //        })
    //        self.photos = PhotoAPI(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width))
    //        self.imageRows = self.photos.images.chunked(into: ViewModel.columnNum)
  }

  deinit {
    print("released GarallyViewModel")
  }

}
