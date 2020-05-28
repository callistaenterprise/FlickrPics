//
//  SearchBar.swift
//  FetchURL
//
//  Created by Stephen White on 2020-05-22.
//  Copyright © 2020 Stephen White. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    
    var placeholder: String

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            searchBar.showsCancelButton = true;
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
               searchBar.resignFirstResponder()
               searchBar.endEditing(true)
            searchBar.showsCancelButton = false;
           }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            searchBar.endEditing(true)
            searchBar.showsCancelButton = false;
        }
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
        uiView.placeholder = placeholder
    }
}
