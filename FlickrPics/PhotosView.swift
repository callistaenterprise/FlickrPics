//
//  PhotosView.swift
//  FetchURL
//
//  Created by Stephen White on 2020-05-26.
//  Copyright © 2020 Stephen White. All rights reserved.
//

import SwiftUI
struct PhotosView: View {
    @EnvironmentObject var flickrApi: FlickrApi
    @State var selection: String? = nil
    
    var body: some View {
        VStack{
            ActivityIndicator(shouldAnimate: $flickrApi.loading).padding(0)
                
            
            List (flickrApi.photoRows, id: \.id){ photoRow in
                
                HStack(alignment: .top ){
                    ImageView(photo: photoRow.photos[0])
                    ImageView(photo: photoRow.photos[1], show: photoRow.photos.count == 2)
                }.onAppear(perform: {self.flickrApi.lastElementCheck(id:photoRow.id)}).listRowInsets(EdgeInsets(top:0, leading: 0, bottom: 0, trailing: 0)).frame(minHeight: 110)
                
            }.onAppear(perform: {
                UITableView.appearance().separatorStyle = .none
            })
        }
    }
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosView()
    }
}
