//
//  PostView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/18/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import FirebaseStorage
import Photos
import SwiftUI

struct PostView: View {
  @Environment(\.presentationMode) var presentationMode
  var image: UIImage
  @State private var text = ""
  @Binding var showModal: Bool

  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 50, height: 50)
          .clipped()
        TextField("Write a caption...", text: $text)
      }.padding()
      Divider()
      Spacer()
    }
    .navigationBarItems(
      trailing:
        Button(action: {
          self.showModal = false
          FileUtils.upload(image: self.image, comment: self.text)
        }) {
          Text("Share")
        }
    )
  }
}

struct PostView_Previews: PreviewProvider {
  @State static var value = false
  static var previews: some View {
    PostView(image: UIImage(), showModal: $value)
  }
}
