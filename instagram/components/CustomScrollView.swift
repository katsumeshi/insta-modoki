//
//  CustomScrollView.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/29/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import SwiftUI

struct CustomScrollView<Content: View>: UIViewRepresentable {
  var width: CGFloat
  var height: CGFloat

  let content: () -> Content

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func makeUIView(context: Context) -> UIScrollView {
    let control = UIScrollView()
    control.refreshControl = UIRefreshControl()
    control.refreshControl?.addTarget(
      context.coordinator, action: #selector(Coordinator.handleRefreshControl), for: .valueChanged)
    control.delegate = context.coordinator

    let childView = UIHostingController(rootView: content())
    childView.view.frame = CGRect(x: 0, y: 0, width: width, height: height)

    control.addSubview(childView.view)
    return control
  }

  func updateUIView(_ uiView: UIScrollView, context: Context) {}

  class Coordinator: NSObject, UIScrollViewDelegate {
    var control: CustomScrollView<Content>
    init(_ control: CustomScrollView) {
      self.control = control
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
      if (scrollView.contentOffset.y + 1)
        >= (scrollView.contentSize.height - scrollView.frame.size.height)
      {
        print("bottom reached")
        // not working
      }
    }

    @objc func handleRefreshControl(sender: UIRefreshControl) {
      sender.endRefreshing()
    }
  }
}

struct CustomScrollView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      GeometryReader { geometry in
        CustomScrollView(width: geometry.size.width, height: geometry.size.height) {
          List {
            Text("1")
            Text("2")
            Text("3")
          }
        }
      }
    }
  }
}
