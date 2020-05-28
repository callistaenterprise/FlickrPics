//
//  ImageLoader.swift
//  FetchURL
//
//  Created by Stephen White on 2020-05-22.
//  Copyright © 2020 Stephen White. All rights reserved.
//
import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {
    var objectWillChange = PassthroughSubject<Data, Never>()
    
    var data = Data() {
        willSet{
            objectWillChange.send(data)
        }
    }
    
    init(imageUrl: String){
        guard let url = URL(string:imageUrl) else { return }
        URLSession.shared.dataTask(with:url){data, response, error in
            guard let data = data else {return}
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}
