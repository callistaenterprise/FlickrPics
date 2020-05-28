//
//  ActivityIndicator.swift
//  FlickrPics
//
//  Created by Stephen White on 2020-05-28.
//  Copyright © 2020 Stephen White. All rights reserved.
//
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    @Binding var shouldAnimate: Bool
    func makeUIView(context: Context) -> UIActivityIndicatorView{
        return UIActivityIndicatorView()
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context){
        if( self.shouldAnimate ){
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
}
