//
//  ListModel.swift
//  WarmupProject
//
//  Created by Richard Crichlow on 2/27/19.
//  Copyright © 2019 Richard Crichlow. All rights reserved.
//

import Foundation

struct ListAPIClient {
    
    private init() { }
    static let manager = ListAPIClient()
    
    func getAlbums(pickerViewString: String,
                   success: @escaping ([Result]) -> Void,
                   failure: @escaping (Error) -> Void) {
        let urlStr = "https://rss.itunes.apple.com/api/v1/us/apple-music/\(pickerViewString.lowercased())/all/10/explicit.json"
        guard let url = URL(string: urlStr) else {
            failure(AppError.badURL(str: urlStr))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let parseDataIntoList: (Data) -> Void = {(data) in
            do{
                let decoder = JSONDecoder()
                let appleMusicList = try decoder.decode(Wrapper.self, from: data)
                success(appleMusicList.feed.results)
            } catch {
                failure(AppError.codingError(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: urlRequest,
                                              completionHandler: parseDataIntoList,
                                              errorHandler: failure)
    }
}
