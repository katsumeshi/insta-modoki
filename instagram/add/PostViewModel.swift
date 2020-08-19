//
//  PostViewModel.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/18/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import Photos
import UIKit.UIImage

final class PostViewModel: ObservableObject {
  @Published var uiImage: UIImage = UIImage()
  private var bag = Set<AnyCancellable>()

  init(image: UIImage?) {
    //    if let asset = asset {
    //      PhotoAPI.fetchMaxImage(asset: asset)
    //        .sink(receiveValue: { [weak self] in
    //          self?.uiImage = $0
    //        })
    //        .store(in: &bag)
    //    }
  }

  deinit {
    print("PostViewModel released")
  }
}
