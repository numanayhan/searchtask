//
//  MediaCell.swift
//  SearchTask
//
//  Created by Melike Büşra Ayhan on 11.01.2021.
//

import UIKit

class MediaCell: UICollectionViewCell {
    
    let artistName : UILabel = {
        let title  =  UILabel()
        title.textColor = UIColor.init(named: "header")
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 10)
        return title
    }()
    let collectionName : String
    let artworkUrl100  : UIImageView = {
        let image  = UIImageView()
         image.backgroundColor = UIColor.white
         image.translatesAutoresizingMaskIntoConstraints = true
         return image
     }()
    let collectionPrice: UILabel = {
        let title  =  UILabel()
        title.textColor = UIColor.init(named: "header")
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 10)
        return title
    }()
    let releaseDate: UILabel = {
        let title  =  UILabel()
        title.textColor = UIColor.init(named: "header")
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 10)
        return title
    }()
    let trackTimeMillis: Int = 0
    let isStreamable: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setViews()
    }
    func setViews(){
        
        addSubview(artistName)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init has not been implemented")
    }
}
