//
//  SwiftExtensions.swift
//  MovieProject
//
//  Created by Suto, Evelyne on 20/05/2021.
//

import SwiftUI

// https://developer.apple.com/documentation/swiftui/viewmodifier
struct ViewDidLoadModifier: ViewModifier {
    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }
}

extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}

extension ObservableObject {
    func performOnMain(block: @escaping () -> (Void)) {
        DispatchQueue.main.async {
            block()
        }
    }
}

extension UIImage {
    class var photoSystemImage: UIImage { return UIImage(systemName: "photo")! }
}

extension TimeInterval {
    static let oneMinute: TimeInterval = 60
    static let oneHour: TimeInterval = oneMinute * 60 
    static let oneDay: TimeInterval = oneHour * 24
}
