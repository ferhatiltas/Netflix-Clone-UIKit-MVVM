//
//  SearchResultViewController.swift
//  NetflixClone
//
//  Created by ferhatiltas on 21.03.2022.
//

import UIKit

class SearchResultViewController: UIViewController {
    public var titles : [Title] = [Title]()
    
   public let searchResultCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collectionView.register(TitleImageCollectionViewCell.self, forCellWithReuseIdentifier: TitleImageCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(searchResultCollectionView)
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }
}

extension SearchResultViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleImageCollectionViewCell.identifier, for: indexPath) as? TitleImageCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(with: titles[indexPath.row].poster_path ?? "")
        return cell
    }
    
    
}
