//
//  FlickrApi.swift
//  FetchURL
//
//  Created by Stephen White on 2020-05-24.
//  Copyright © 2020 Stephen White. All rights reserved.
//

import Combine
import Foundation

class FlickrApi: ObservableObject {
    @Published var searchText: String = "Rocket, spacex"
    var searchViewState: SearchViewState
    @Published var photos: [Photo] = []
    @Published var photoRows: [PhotoRow] = []
    @Published var loading: Bool = false
    var page:Page = Page()
    private var disposables = Set<AnyCancellable>()
    
    init(searchViewState: SearchViewState){
        self.searchViewState = searchViewState
        self.searchViewState.$dst
            .debounce(for: .milliseconds(100), scheduler: DispatchQueue.main).removeDuplicates()
            .sink { searchText in
                self.loadData(searchText: searchText)
        }.store(in: &disposables)
    }
    
    func getUrl(searchText: String, page: Int = 1, perpage: Int = 18) -> String {
        var _searchText = searchText
        if( searchText.isEmpty) {
            return "";
        }
        var text = _searchText.components(separatedBy: ",")
        var _cat = "";
        if(text.count > 1){
            _searchText = text[text.count-1].trimmingCharacters(in: .whitespacesAndNewlines);
            text.removeLast()
            _cat = text.joined(separator: ",")
        } else {
            _searchText = text[0].trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        let safeText = _searchText.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        let safeCat = _cat.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        
        let safeUrl = "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=f46b7b3920dc5855bdfdbeacd14b3ebd&tags=\(safeCat)&text=\(safeText)&privacy_filter=1&content_type=1&extras=url_s%2C+url_o%2C+url_t%2C+url_m%2C+url_l&per_page=\(perpage)&page=\(page)&format=json&nojsoncallback=1"
        
        return safeUrl
    }
    
    func loadData(searchText: String){

        self.searchText = searchText
        let searchUrl = getUrl(searchText: searchText)
        if(searchUrl.isEmpty) {
            return
        }
        guard let url = URL(string: searchUrl) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url:url)
        self.loading = true
        URLSession.shared.dataTask(with: request){data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
                    DispatchQueue.main.async {
                        self.photos = decodedResponse.photos.photo
                        
                        self.buildPhotoRows()
                        self.page = Page(page: decodedResponse.photos.page, pages: decodedResponse.photos.pages, perpage: decodedResponse.photos.perpage, total: decodedResponse.photos.total)
                        self.loading = false
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    func loadMore(){
        let searchUrl = getUrl(searchText: self.searchText, page: self.page.page+1)
        guard let url = URL(string: searchUrl) else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url:url)
        URLSession.shared.dataTask(with: request){data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data){
                    DispatchQueue.main.async {
                        self.photos.append(contentsOf: decodedResponse.photos.photo)
                        self.buildPhotoRows()
                        self.page = Page(page: decodedResponse.photos.page, pages: decodedResponse.photos.pages, perpage: decodedResponse.photos.perpage, total: decodedResponse.photos.total)
                    }
                    return
                }
            }
            print("Load MoreFetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    func lastElementCheck(id: String){
        if(self.photoRows.last?.id == id) {
            loadMore()
        }
    }
    
    func buildPhotoView(photo: Photo) -> PhotoView {
        if let largeUrl = photo.url_l {
            return PhotoView(id: photo.id, thumbnailUrl: photo.url_s, largeUrl: largeUrl )
        } else if let ol = photo.url_o {
            return PhotoView(id: photo.id, thumbnailUrl: photo.url_s, largeUrl: ol )
        } else {
            return PhotoView(id: photo.id, thumbnailUrl: photo.url_s, largeUrl: photo.url_t)
        }
        
        
    }
    
    func buildPhotoRows(){
        self.photoRows  = []
        var i = 0;
        for photo in self.photos {
            if(i % 2 == 0){
                self.photoRows.append( PhotoRow(id: photo.id, photos: [buildPhotoView(photo:photo)]))
            } else {
                self.photoRows[self.photoRows.count-1].photos.append(buildPhotoView(photo:photo))
            }
            i += 1
        }
    }
}
