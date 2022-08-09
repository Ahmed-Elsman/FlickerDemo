//
//  FlickerItemView.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 06/08/2022.
//

import SwiftUI

struct FlickerItemView: View {
    
    let flickerItem: FlickerItem
    
    var body: some View {
        VStack(spacing: 0) {
            flickerImage
            flickerTitle
        }
        .background(Color.theme.background)
        .cornerRadius(20)
        .shadow(color: Color.theme.accent.opacity(0.3), radius: 5, x: 0, y: 0)
    }
}

struct FlickerItemView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            FlickerItemView(flickerItem: dev.flickerItem)
                .padding()
        }
    }
}

extension FlickerItemView {
    private var flickerImage: some View {
        ZStack {
            FlickerImage(flickerItem: flickerItem)
        }
        .padding(8)
        .background(Color.theme.background)
        .cornerRadius(20)
    }
    
    private var flickerTitle: some View {
        Text(flickerItem.title)
            .font(.subheadline)
            .bold()
            .frame(height: 50)
            .multilineTextAlignment(.leading)
            .lineLimit(2)
            .padding(8)
    }
}
