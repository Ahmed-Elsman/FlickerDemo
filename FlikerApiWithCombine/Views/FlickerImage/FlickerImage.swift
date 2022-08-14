//
//  FlickerImage.swift
//  FlikerApiWithCombine
//
//  Created by Ahmed Elsman on 08/08/2022.
//

import SwiftUI

struct FlickerImage: View {
    
//    @StateObject var vm: FlickerImageViewModel
    let flickerItem: FlickerItem
    
    init(flickerItem: FlickerItem) {
        self.flickerItem = flickerItem
//        _vm = StateObject(wrappedValue: FlickerImageViewModel(flickerItem: flickerItem))
    }
    

    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: flickerItem.imagePath)) { currentImage in
                currentImage
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .cornerRadius(20)
            } placeholder: {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            /* old version of downloading images
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 150)
                    .cornerRadius(20)
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
            */
        }
    }
}

struct FlickerImage_Previews: PreviewProvider {
    static var previews: some View {
        FlickerImage(flickerItem: dev.flickerItem)
    }
}
