//
//  ImageAPIClient.swift
//  FlickrProject
//
//  Created by Suto, Evelyne on 18/04/2021.
//

import Alamofire
import Foundation
import UIKit

enum DownloadState {
    case new
    case inProgress
    case downloaded
    case failed
}

enum ImageLoaderResult {
    case success(UIImage)
    case failure(Error)
}

protocol ImageAPIClient: class {
    func fetchImage(url: URL, lastModified: Date?, completion: @escaping (ImageLoaderResult) -> Void) -> Cancellable
}

