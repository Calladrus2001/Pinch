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
  @State private var imageOffset: CGSize = .zero
  
  
  // MARK: - Function
  func resetImageState() {
    return withAnimation(.spring()) {imageScale = 1; imageOffset = .zero}
  }
  
  // MARK: - Content
    var body: some View {
      NavigationView {
        ZStack {
          
          Color.clear
          
          Image("magazine-front-cover")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
            .padding()
            .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
            .opacity(isAnimated ? 1 : 0)
            .animation(.linear(duration: 1), value: isAnimated)
            .offset(x: imageOffset.width, y: imageOffset.height)
            .scaleEffect(imageScale)
          
            //MARK: - 1. Tap Gesture
            .onTapGesture(count: 2) {
              if imageScale == 1 {
                withAnimation(.spring()) {imageScale = 5; imageOffset = .zero}
              } else {
                resetImageState()
              }
            }
          
            //MARK: - 2. Drag Gesture
            .gesture(
              DragGesture()
                .onChanged {
                  value in withAnimation(.linear(duration: 1)) {
                    imageOffset = value.translation
                  }
                }
                .onEnded {_ in
                  if (imageScale <= 1) {
                    resetImageState()
                  }
                }
            )
        }
        .navigationTitle("Pinch & Zoom")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
          isAnimated = true
        })
        
        //MARK: - Info Panel
        .overlay(
          InfoPanelView(scale: imageScale, offset: imageOffset),
          alignment: .top
        )
        
        //MARK: - Controls
        .overlay(
          Group {
            HStack {
              // SCALE DOWN
              Button {
                withAnimation(.spring()) {
                  if imageScale > 1 {
                    imageScale -= 1
                    
                    if imageScale <= 1 {
                      resetImageState()
                    }
                  }
                }
              } label: {
                ControlImageView(icon: "minus.magnifyingglass")
              }
              
              // RESET
              Button {
                resetImageState()
              } label: {
                ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
              }
              
              // SCALE UP
              Button {
                withAnimation(.spring()) {
                  if imageScale < 5 {
                    imageScale += 1
                    
                    if imageScale > 5 {
                      imageScale = 5
                    }
                  }
                }
              } label: {
                ControlImageView(icon: "plus.magnifyingglass")
              }
              
            } //: CONTROLS
            .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            .opacity(isAnimated ? 1 : 0)
          }
            .padding(.bottom, 30)
          , alignment: .bottom
        )
      }
      .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
