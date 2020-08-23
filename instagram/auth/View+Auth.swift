//
//  View+Auth.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/22/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import SwiftUI

enum FieldType {
  case input
  case button
}

extension View {
  func style() -> some View {
    return
      self
      .padding(8)
      .background(Color.secondarySystemBackground)
      .cornerRadius(6)
  }

}

extension Text {
  func style() -> some View {
    return self.fontWeight(.semibold)
      .frame(minWidth: 0, maxWidth: .infinity)
      .padding(.vertical, 8)
      .foregroundColor(.white)
      .background(Color.blue)
      .cornerRadius(6)
  }
  func errorStyle() -> some View {
    return self.foregroundColor(.red)
  }
}
