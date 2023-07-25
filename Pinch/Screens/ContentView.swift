//
//  ContentView.swift
//  Pinch
//
//  Created by Vishesh Dugar on 25/07/23.
//

import SwiftUI

struct ContentView: View {
  // MARK: - Property
  @State private var isAnimated: Bool = false
  @State private var imageScale: CGFloat = 1
  
  // MARK: - Function
  
  // MARK: - Content
    var body: some View {
      NavigationView {
        ZStack {
          Image("magazine-front-cover")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
            .padding()
            .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
            .opacity(isAnimated ? 1 : 0)
            .animation(.linear(duration: 1), value: isAnimated)
            .scaleEffect(imageScale)
          
            //MARK: - 1. Tap Gesture
            .onTapGesture(count: 2) {
              if imageScale == 1 {
                withAnimation(.spring()) {imageScale = 5}
              } else {
                withAnimation(.spring()) {imageScale = 1}
              }
            }
        }
        .navigationTitle("Pinch & Zoom")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
          isAnimated = true
        })
      }
      .navigationViewStyle(.stack)
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
