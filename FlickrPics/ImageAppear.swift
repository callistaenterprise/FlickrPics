//
//  ImageAppear.swift
//  FetchURL
//
//  Created by Stephen White on 2020-05-22.
//  Copyright © 2020 Stephen White. All rights reserved.
//

import SwiftUI

struct ImagePreviewModel {
    var urlString : String
    var width : CGFloat = 100.0
    var height : CGFloat = 100.0
}

struct ImageAppear: View {
    let viewModel: ImagePreviewModel
    @State var initialImage = UIImage()
    var body: some View {
        Image(uiImage: initialImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: self.width, height: self.height)
            .onAppear {
                guard let url = URL(string: self.viewModel.urlString) else { return }
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let data = data else { return }
                    guard let image = UIImage(data: data) else { return }

                    RunLoop.main.perform {
                        self.initialImage = image
                    }

                }.resume()
            }
    }
    var width: CGFloat { return max(viewModel.width, 100.0) }
    var height: CGFloat { return max(viewModel.height, 100.0) }
}

struct ImageAppear_Previews: PreviewProvider {
    static var previews: some View {
        ImageAppear(viewModel: ImagePreviewModel(urlString: "https://live.staticflickr.com/65535/49922371176_a83ac96a00_t.jpg"))
    }
}
