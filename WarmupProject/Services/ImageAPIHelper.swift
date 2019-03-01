//
//  ImageAPIHelper.swift
//  WarmupProject
//
//  Created by Richard Crichlow on 2/28/19.
//  Copyright © 2019 Richard Crichlow. All rights reserved.
//

import UIKit

class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func loadImage(from urlStr: String,
                   completionHandler: @escaping (UIImage) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        
        guard let url = URL(string: urlStr.removingWhitespaces()) else {
            errorHandler(AppError.invalidImage)
            return
        }
            let completion: (Data) -> Void = {(data: Data) in
                guard let onlineImage = UIImage(data: data) else {
                    return
                }
                completionHandler(onlineImage)
            }
            NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
                                                  completionHandler: completion,
                                                  errorHandler: errorHandler)
    }
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
