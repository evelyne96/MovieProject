//
//  ImageDataLoader.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 18/04/2021.
//

import Alamofire
import Foundation
import UIKit

class ImageDataLoader: ImageAPIClient {
    func fetchImage(url: URL,
                   lastModified: Date?,
                   completion: @escaping (ImageLoaderResult) -> Void) -> Cancellable {
        
        let request = AF.request(url)
        request.validate(statusCode: 200..<300).responseData { response in
            switch response.result {
            case .success(let imageData):
                let image = UIImage(data: imageData) ?? UIImage()
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        return request
    }
}
