//
//  LoadingView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/22/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
  var body: some View {
    VStack {
      ActivityIndicator(style: .large, color: .blue)
      Text("Loading...")
    }
  }
}

//private struct ActivityIndicator: UIViewRepresentable {
//
//  let style: UIActivityIndicatorView.Style
//
//  func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView
//  {
//    return UIActivityIndicatorView(style: style)
//  }
//
//  func updateUIView(
//    _ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>
//  ) {
//  }
//}

private struct ActivityIndicator: UIViewRepresentable {

  let style: UIActivityIndicatorView.Style
  let color: UIColor

  func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView
  {
    let indicatorView = UIActivityIndicatorView(style: style)
    indicatorView.color = color
    return indicatorView
  }

  func updateUIView(
    _ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>
  ) {
    uiView.startAnimating()
  }
}

struct LoadingView_Previews: PreviewProvider {
  static var previews: some View {
    LoadingView()
  }
}
