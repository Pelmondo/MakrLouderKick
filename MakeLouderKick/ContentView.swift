//
//  ContentView.swift
//  MakeLouderKick
//
//  Created by Сергей Прокопьев on 22.10.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CustomSlider()
    }
}

#Preview {
    ContentView()
}


struct CustomSlider: View {
    @State private var value = 0.0
    @State private var scaleY = 1.0
    @State private var scaleX = 1.0

    let size: CGSize

    init(size: CGSize = .init(width: 68, height: 146)) {
        self.size = size
    }

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .background(.ultraThinMaterial)
                .opacity(0.5)
                .overlay(
                    Color.cyan
                    .scaleEffect(y: value, anchor: .bottom),
                    alignment: .bottom
                )
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .frame(width: size.width, height: size.height)
        .scaleEffect(x: scaleX, y: scaleY, anchor: value > 0 ? .bottom : .top)
        .gesture(
            DragGesture()
                .onChanged { value in
                    strach(point: value)
                }
                .onEnded { value in
                    scaleY = 1
                    scaleX = 1
                }
        )
        .animation(.spring(dampingFraction: 0.8), value: scaleX)
        .animation(.spring(dampingFraction: 0.8), value: scaleY)
        .animation(.spring(dampingFraction: 0.8), value: value)
    }

    // MARK: - Private

    private func strach(point: DragGesture.Value) {
        switch point.location.y {
        case ..<0:
            let hieght = size.height + sqrt(-point.location.y)
            let wight = size.width - sqrt(-point.location.y)
            scaleY = hieght / size.height
            scaleX = wight / size.width
            value = 1
        case size.height...:
            let height = size.height + sqrt(point.location.y - size.height)
            let wight = size.width - sqrt(point.location.y - size.height)
            scaleY = height / size.height
            scaleX = wight / size.width
            value = 0
        default:
            scaleY = 1
            scaleX = 1
            value = 1 - (point.location.y / size.height)
        }
    }
}
