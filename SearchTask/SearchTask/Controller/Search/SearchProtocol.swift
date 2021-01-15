//
//  SearchProtocol.swift
//  SearchTask
//
//  Created by Melike Büşra Ayhan on 11.01.2021.
//

import Foundation 
// MARK: - Media
struct Media : Decodable {
    let name: String
    let category: Category
    enum Category: Decodable {
      case movies
      case music
      case apps
      case books
    }
//    let resultCount: Int
//    let results: [MediaResult]
}

extension Media.Category: CaseIterable { }
extension Media.Category: RawRepresentable {
  typealias RawValue = String
  
  init?(rawValue: RawValue) {
    switch rawValue {
    case "music-video": self = .movies
    case "music": self = .music
    case "software": self = .apps
    case "audiobook": self = .books
    default: return nil
    }
  }
  var rawValue: RawValue {
    switch self {
    case .movies: return "music-video"
    case .music: return "music"
    case .apps: return "software"
    case .books: return "audiobook"
    }
  }
}

// MARK: - Result
struct MediaResult {
       
       let artistName: String?
       let collectionName : String
       let artworkUrl100: String
       let collectionPrice: Double
       let releaseDate: Date
       let trackTimeMillis: Int
       let isStreamable: Bool
    
    init(_ dictionary: [String: Any]) {
        
        self.artistName = dictionary["artistName"] as? String
        self.collectionName = dictionary["artistName"] as! String
        self.artworkUrl100 = dictionary["artistName"] as! String
        self.collectionPrice = dictionary["artistName"] as! Double
        self.releaseDate = dictionary["artistName"] as! Date
        self.trackTimeMillis = dictionary["artistName"] as! Int
        self.isStreamable = (dictionary["artistName"] != nil)
         
    }
}
