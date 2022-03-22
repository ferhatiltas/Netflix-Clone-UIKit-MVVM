//
//  HeroHeaderUIView.swift
//  NetflixClone
//
//  Created by ferhatiltas on 8.03.2022.
//

import UIKit

class HeroHeaderUIView: UIView {
    // bu viewi homefeed tableview uzerinde olusturdugumuz boslugun icine ekleyecegiz
    
    private let heroImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill 
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    private let playButton : UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor .white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let downloadButton : UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
        applyConstraints()
    }
    
    private func applyConstraints(){
        // buttonun konumunu belirliyoruz sagdan 90 asagidan -25 olacak sekilde
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 90),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -20),
            playButton.widthAnchor.constraint(equalToConstant: 100) // buttonun genisligi
        ]
        let downloadButtonConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -90),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -20),
            downloadButton.widthAnchor.constraint(equalToConstant: 100) // buttonun genisligi
        ]
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstraints)
    }
    
    private func addGradient(){
         let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.systemBackground.cgColor]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    public func configure(with model : TitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        
        heroImageView.sd_setImage(with: url, completed: nil )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
