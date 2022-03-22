//
//  SearchResultViewController.swift
//  NetflixClone
//
//  Created by ferhatiltas on 21.03.2022.
//

import UIKit

protocol SearchResultViewControllerDelegate : AnyObject{
    func searchResultViewController(_ viewModel: TitlePreviewViewModel)
}

class SearchResultViewController: UIViewController {
    public var titles : [Title] = [Title]()
    public weak var delegate : SearchResultViewControllerDelegate?
    
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
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        let titleName = title.original_name ?? title.original_title ?? ""
        ApiCaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result{
            case .success(let videoElement):
                self?.delegate?.searchResultViewController(TitlePreviewViewModel(title: titleName, youtubeView:  videoElement, titleOverview: title.overview ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
