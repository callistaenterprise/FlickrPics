//
//  SearchViewState.swift
//  FetchURL
//
//  Created by Stephen White on 2020-05-25.
//  Copyright © 2020 Stephen White. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class SearchViewState: ObservableObject {
    @Published var searchText: String = "rocket, spacex"
    @Published var dst: String = ""
    private var disposables = Set<AnyCancellable>()
    init(){
        self.$searchText
            .debounce(for: .milliseconds(1000), scheduler: DispatchQueue.main).removeDuplicates()
          .sink { searchText in
            self.dst = searchText
        }.store(in: &disposables)
    }
}
