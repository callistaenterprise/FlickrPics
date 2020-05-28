//
//  ThumbImage.swift
//  FetchURL
//
//  Created by Stephen White on 2020-05-22.
//  Copyright © 2020 Stephen White. All rights reserved.
//

import SwiftUI
import Combine

struct ThumbImage: View {
    
    @ObservedObject var url: ImageLoader
    var width: Float = 170
    var height: Float = 110
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
            .aspectRatio(contentMode: .fill)
            .clipped().frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .cornerRadius(20)
    }
}

struct ThumbImage_Previews: PreviewProvider {
    static var previews: some View {
        ThumbImage(imageUrl: "https://live.staticflickr.com/65535/49562757353_523b4f486a_t.jpg")
    }
}
