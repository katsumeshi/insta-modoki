//
//  AddView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/7/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import SwiftUI

struct AddView: View {
  @State private var selectedItem = 1

  var body: some View {
    TabView(selection: $selectedItem) {
      GalleryView()
        .tabItem {
          Text("GALLERY")
        }
        .tag(1)
      Text("PHOTO")
        .tabItem {
          Text("PHOTO")
        }
        .tag(2)
    }
  }
}

struct AddView_Previews: PreviewProvider {
  static var previews: some View {
    AddView()
  }
}
