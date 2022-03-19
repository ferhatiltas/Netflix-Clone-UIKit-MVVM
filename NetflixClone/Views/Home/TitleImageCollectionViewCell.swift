//
//  TitleCollectionViewCell.swift
//  NetflixClone
//
//  Created by ferhatiltas on 16.03.2022.
//

import UIKit
import SDWebImage
class TitleImageCollectionViewCell: UICollectionViewCell {
    // Buraya tableview icindeki her bir collectionda olmasi gereken resimleri ekleuecegi bu resimleri api den cektik

    static let identifier = "TitleImageCollectionViewCell"
    
    private let posterImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with model : String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
            return
        }
        
        posterImageView.sd_setImage(with: url, completed: nil)
    }
}
