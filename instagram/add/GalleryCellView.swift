//
//  GalleryCellView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/8/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import Photos
import SwiftUI

struct GalleryCellView: View {
  @ObservedObject private var viewModel: GarallyCellViewModel
  private let width: CGFloat

  init(asset: PHAsset?, photos: PhotoAPI, width: CGFloat = .zero, preview: Bool = false) {
    if preview {
      viewModel = GarallyCellViewModel(
        asset: asset, photos: photos, size: PHImageManagerMaximumSize)
    } else {
      viewModel = GarallyCellViewModel(
        asset: asset, photos: photos, size: GarallyViewModel.actualThumbnailSize)
    }
    self.width = width
  }

  var body: some View {
    Image(uiImage: viewModel.uiImage)
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: self.width, height: self.width)
      .border(Color.secondary, width: 1)
      .clipped()
    //          .overlay(Rectangle().fill(Color.white).opacity(self.getOp(i: i, j: j)))

  }
}

struct GalleryCellView_Previews: PreviewProvider {
  static var previews: some View {
    GalleryCellView(asset: PHAsset(), photos: PhotoAPI())
  }
}
