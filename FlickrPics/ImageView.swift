//
//  ImageView.swift
//  FlickrPics
//
//  Created by Stephen White on 2020-05-28.
//  Copyright © 2020 Stephen White. All rights reserved.
//

import SwiftUI

struct ImageView: View {
    var photo: PhotoView
    var show: Bool = true
    @State var selection: String? = nil
    var body: some View {
        VStack {
            if(self.show){
                NavigationLink (destination: ImageDetails(selectedPhoto: photo), tag: self.photo.id, selection: self.$selection) {
                    EmptyView()
                }.frame(width: 0, height: 0)
                    .hidden()
                Button(action: {
                    self.selection = self.photo.id
                }) {
                    ThumbImage(imageUrl: photo.thumbnailUrl)
                }.buttonStyle(PlainButtonStyle())
            } else {
                EmptyView()
            }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 110, alignment: .center).padding(8)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(photo: PhotoView(id:"1", thumbnailUrl:"", largeUrl:""))
    }
}
