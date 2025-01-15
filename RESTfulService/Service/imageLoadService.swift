//
//  imageLoadService.swift
//  RESTfulService
//
//  Created by Mert Ziya on 8.01.2025.
//

import Foundation
import UIKit

class ImageLoadService{
    
    static func loadImage(urlString : String , completion : @escaping (UIImage) -> () ){
        let errorImage = UIImage(systemName: "photo")!
        
        guard let url = URL(string: urlString) else{
            completion(errorImage)
            print("url error of image")
            return
        }
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            if let error = error{
                completion(errorImage)
            }else if let data = data{
                guard let targetImage = UIImage(data: data) else{
                    print("Error: image data")
                    completion(errorImage)
                    return
                }
                completion(targetImage)
            }
        }.resume()
    }
}
