//
//  ControlImageView.swift
//  Pinch
//
//  Created by Vishesh Dugar on 27/07/23.
//

import SwiftUI

struct ControlImageView: View {
  let icon: String
    var body: some View {
      Image(systemName: icon)
        .font(.system(size: 36))
    }
}

struct ControlImageView_Previews: PreviewProvider {
    static var previews: some View {
      ControlImageView(icon: "plus.magnifyingglass")
    }
}
