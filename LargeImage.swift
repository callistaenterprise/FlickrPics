//
//  LargeImage.swift
//  FetchURL
//
//  Created by Stephen White on 2020-05-24.
//  Copyright © 2020 Stephen White. All rights reserved.
//

import SwiftUI

struct LargeImage: View {
    @ObservedObject var url: ImageLoader
    @State var scale: CGFloat = 1.0
    
    var width: Float?
    var height: Float?
    init(imageUrl: String){
        url = ImageLoader(imageUrl: imageUrl)
    }
    init(imageUrl: String, width: Float, height: Float){
        url = ImageLoader(imageUrl: imageUrl)
        self.width = width
        self.height = height

    }
    
    var body: some View {
        Image(uiImage: UIImage(data: url.data) ?? UIImage())
            .resizable()
            .scaleEffect(scale)
            .scaledToFit()
            .gesture(MagnificationGesture()
                .onChanged{value in
                    self.scale = value.magnitude
                }
        ).gesture(TapGesture(count: 2).onEnded{
            if(self.scale <= 2.0){
                self.scale = self.scale * 2
            } else if(self.scale >= 2.0){
                self.scale = 1.0
            }
        }).animation(.easeInOut(duration:0.2))
    }
}

struct LargeImage_Previews: PreviewProvider {
    static var previews: some View {
        LargeImage(imageUrl: "https://live.staticflickr.com/65535/49562757353_523b4f486a_b.jpg")
    }
}
