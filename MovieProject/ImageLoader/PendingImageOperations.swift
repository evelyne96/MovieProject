//
//  PendingImageOperations.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 20/05/2021.
//

import Foundation

protocol Cancellable {
    func doCancel()
}

class PendingImageOperations {
    lazy var imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "ImageDownloadQueue queue"
        queue.maxConcurrentOperationCount = 8
        return queue
    }()
}
