//
//  ContentView.swift
//  FetchURL
//
//  Created by Stephen White on 2020-05-22.
//  Copyright © 2020 Stephen White. All rights reserved.
//
import SwiftUI
import Combine
import Foundation

struct ContentView: View {
    let device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        
        NavigationView{
            VStack {
                SearchView()
                PhotosView()
            }.navigationBarTitle(Text("Flickr Pics"))
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ImageDetails: View {
    var selectedPhoto: PhotoView
    var body: some View {
        VStack{
            LargeImage(imageUrl: selectedPhoto.largeUrl)
        }
        
    }
}
