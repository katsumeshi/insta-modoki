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
  //  var asset: PHAsset?
  @ObservedObject private var viewModel: GarallyCellViewModel
  //    = GarallyCellViewModel(viewModel: nil)
  //  var parentViewModel: GarallyViewModel?
  //    @ObservedObject var photos
  //    private var bag = Set<AnyCancellable>()
  let width: CGFloat

  init(asset: PHAsset?, photos: PhotoAPI, width: CGFloat = .zero) {
    viewModel = GarallyCellViewModel(asset: asset, photos: photos)
    self.width = width
  }

  var body: some View {
    Image(uiImage: viewModel.uiImage)
      .resizable()
      .frame(width: self.width, height: self.width)
      .border(Color.secondary, width: 1)
    //          .overlay(Rectangle().fill(Color.white).opacity(self.getOp(i: i, j: j)))

  }
}

struct GalleryCellView_Previews: PreviewProvider {
  static var previews: some View {
    GalleryCellView(asset: PHAsset(), photos: PhotoAPI())
  }
}
