//
//  Line.swift
//  instagram
//
//  Created by Yuki Matsushita on 8/19/20.
//  Copyright © 2020 Yuki Matsushita. All rights reserved.
//

import SwiftUI

struct HorizontalLine: View {
  var color: Color
  var body: some View {
    Rectangle()
      .fill(color)
      .frame(height: 1)
  }
}

struct HorizontalLine_Previews: PreviewProvider {
  static var previews: some View {
    HorizontalLine(color: .blue)
  }
}
