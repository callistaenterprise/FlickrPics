//
//  SearchView.swift
//  FetchURL
//
//  Created by Stephen White on 2020-05-25.
//  Copyright © 2020 Stephen White. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

struct SearchView: View {
    @EnvironmentObject var searchViewState: SearchViewState
    
    var body: some View {
        SearchBar(text: self.$searchViewState.searchText, placeholder: "Categories ..., Free text").onAppear(perform: {
            
        })
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        Text("hello")
    }
}
