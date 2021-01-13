//
//  SearchProtocol.swift
//  SearchTask
//
//  Created by Melike Büşra Ayhan on 11.01.2021.
//

import Foundation 
// MARK: - Media
struct Media {
    let resultCount: Int
    let results: [MediaResult]
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
