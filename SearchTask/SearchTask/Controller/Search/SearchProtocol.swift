//
//  SearchProtocol.swift
//  SearchTask
//
//  Created by Melike Büşra Ayhan on 11.01.2021.
//

import Foundation 
// MARK: - Media
struct FilterSearch {
    var isActive: Bool
    var account: Filters
}
class Filters {
    var types: String = "" 
}
 
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
    case .movies: return "Movies"
    case .music: return "Music"
    case .apps: return "Apps"
    case .books: return "Books"
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

//APPS PROTOCOL

struct AppsProtocol {
    let resultCount: Int
    let results: [Result]
}

// Result.swift

import Foundation

// MARK: - Result
struct Result {
    let screenshotUrls, ipadScreenshotUrls: [String]
    let appletvScreenshotUrls: [Any?]
    let artworkUrl512: String
    let artistViewURL: String
    let artworkUrl60, artworkUrl100: String
    let supportedDevices: [String]
    let advisories: [Any?]
    let isGameCenterEnabled: Bool
    let features: [String]
    let kind: String
    let languageCodesISO2A: [String]
    let fileSizeBytes: String
    let sellerURL: String?
    let averageUserRatingForCurrentVersion: Double
    let userRatingCountForCurrentVersion: Int
    let trackContentRating: String
    let trackViewURL: String
    let contentAdvisoryRating, trackCensoredName: String
    let averageUserRating: Double
    let releaseDate: Date
    let trackID: Int
    let trackName: String
    let genreIDS: [String]
    let formattedPrice, primaryGenreName, minimumOSVersion: String
    let isVppDeviceBasedLicensingEnabled: Bool
    let sellerName: String
    let currentVersionReleaseDate: Date
    let releaseNotes: String?
    let primaryGenreID: Int
    let currency, resultDescription: String
    let artistID: Int
    let artistName: String
    let genres: [String]
    let price: Int
    let bundleID, version, wrapperType: String
    let userRatingCount: Int
}

