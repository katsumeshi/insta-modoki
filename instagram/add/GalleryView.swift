//
//  GalleryView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/7/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import Combine
import Photos
import SwiftUI
import UIKit

struct GalleryView: View {
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject var viewModel = GarallyViewModel()
  private let width = UIScreen.main.bounds.width
  @Binding var showModal: Bool

  var body: some View {

    return NavigationView {
      TabView(selection: $viewModel.selectedTabItem) {
        VStack(spacing: 0) {
          if viewModel.assets.count > 0 {
            GalleryCellView(
              asset: self.viewModel.getAssetFromIndex(index: viewModel.selectIndex),
              photos: self.viewModel.photos, width: width, preview: true)
            List {
              ForEach(0..<self.viewModel.grid2dArr.count, id: \.self) { y in
                GalleryRowView(viewModel: self.viewModel, y: y)
              }
            }
          }
        }
        .tabItem {
          Text("GALLERY")
        }
        .tag(1)
        Text("PHOTO")
          .tabItem {
            Text("PHOTO")
          }
          .tag(2)
      }.navigationBarTitle("Gallary", displayMode: .inline)
        .navigationBarItems(
          leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
          }) {
            Image(systemName: "xmark")
          }.buttonStyle(PlainButtonStyle()),
          trailing:
            NavigationLink(
              destination: PostView(image: viewModel.previewImage, showModal: $showModal)
            ) {
              Text("Next")
            }
        )
    }

  }
}

private struct GalleryRowView: View {
  var viewModel: GarallyViewModel
  var y: Int = 0

  var body: some View {
    HStack(spacing: 0) {
      ForEach(0..<viewModel.grid2dArr[y].count, id: \.self) { x in
        Button(
          action: { self.viewModel.selectIndex = (self.y * Int(GarallyViewModel.columnNum)) + x },
          label: {
            GalleryCellView(
              asset: self.viewModel.getAsset(x: x, y: self.y), photos: self.viewModel.photos,
              width: GarallyViewModel.thumbNailWidth)
          }
        ).buttonStyle(PlainButtonStyle())
      }
    }.listRowInsets(.init())
  }
}

struct GalleryView_Previews: PreviewProvider {
  @State static var value = false

  static var previews: some View {
    GalleryView(showModal: $value)
  }
}
