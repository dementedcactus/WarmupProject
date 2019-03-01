//
//  AlbumListModel.swift
//  WarmupProject
//
//  Created by Richard Crichlow on 2/27/19.
//  Copyright © 2019 Richard Crichlow. All rights reserved.
//

import Foundation

// Fun Fact. In order to use Codable you need to have a coding key for every single possible key in the json or the data call will fail.
// Also a suprising amount of albums are missing information meaning that a lot of values might return nil
class Wrapper: Codable {
    let feed: Feed
    
    init(feed: Feed) {
        self.feed = feed
    }
}

class Feed: Codable {
    let title: String
    let id: String
    let author: Author
    let links: [Link]
    let copyright, country: String
    let icon: String
    let updated: String
    let results: [Result]
    
    init(title: String, id: String, author: Author, links: [Link], copyright: String, country: String, icon: String, updated: String, results: [Result]) {
        self.title = title
        self.id = id
        self.author = author
        self.links = links
        self.copyright = copyright
        self.country = country
        self.icon = icon
        self.updated = updated
        self.results = results
    }
}

class Author: Codable {
    let name: String?
    let uri: String?
    
    init(name: String?, uri: String?) {
        self.name = name
        self.uri = uri
    }
}

class Link: Codable {
    let linkSelf: String?
    let alternate: String?
    
    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
        case alternate
    }
    
    init(linkSelf: String?, alternate: String?) {
        self.linkSelf = linkSelf
        self.alternate = alternate
    }
}

class Result: Codable {
    let artistName, id, releaseDate, name: String
    let kind: Kind?
    let copyright, artistID: String?
    let artistURL: String?
    let artworkUrl100: String?
    let genres: [Genre]?
    let url: String?
    let contentAdvisoryRating: String?
    
    enum CodingKeys: String, CodingKey {
        case artistName, id, releaseDate, name, kind, copyright
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case artworkUrl100, genres, url, contentAdvisoryRating
    }
    
    init(artistName: String, id: String, releaseDate: String, name: String, kind: Kind?, copyright: String?, artistID: String?, artistURL: String?, artworkUrl100: String?, genres: [Genre]?, url: String?, contentAdvisoryRating: String?) {
        self.artistName = artistName
        self.id = id
        self.releaseDate = releaseDate
        self.name = name
        self.kind = kind
        self.copyright = copyright
        self.artistID = artistID
        self.artistURL = artistURL
        self.artworkUrl100 = artworkUrl100
        self.genres = genres
        self.url = url
        self.contentAdvisoryRating = contentAdvisoryRating
    }
}

class Genre: Codable {
    let genreID, name: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
    
    init(genreID: String?, name: String?, url: String?) {
        self.genreID = genreID
        self.name = name
        self.url = url
    }
}

enum Kind: String, Codable {
    case album = "album"
}
