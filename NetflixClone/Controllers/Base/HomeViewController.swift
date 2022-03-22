//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by ferhatiltas on 8.03.2022.
//

import UIKit

enum Sections : Int{
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    private var randomTrendingMovie : Title?
    private var headerView : HeroHeaderUIView?
    let sectionTitles : [String] = ["Trending Movies","Tranding TV","Popular","Upcoming Movies","Top Rated"]
    private let homeFeedTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped  ) // tableview ust tarafinda bosluk birakir
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier:CollectionTableViewCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTableView)
        
        homeFeedTableView.delegate = self
        homeFeedTableView.dataSource = self
        
        configureNavBar()
        
       
        // tableview ust tarafindan verilen deger kadar bosluk birakir. Oraya olusturdugumuz HeroHeaderUIView ekleyecegiz
        headerView = HeroHeaderUIView(frame:CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTableView.tableHeaderView = headerView
        configureHeroHeaderView()
    }
    
    private func configureHeroHeaderView(){
        ApiCaller.shared.getTrandingMovies { [weak self] result in
            switch result{
            case .success(let titles):
                let selectedTitle = titles.randomElement()
                self?.randomTrendingMovie = selectedTitle
                self?.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? ""))
                 
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureNavBar(){
        var image = UIImage(named: "netflix_logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,  style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)]
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTableView.frame = view.bounds
    }
    

}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        // tableview x parcaya ayirir
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // ayrilan table viewda (numberOfSections) her bir parcaya kac tane eleman girecegi belirlenir
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        switch indexPath.section{
        case Sections.TrendingMovies.rawValue:
            ApiCaller.shared.getTrandingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TrendingTv.rawValue:
            ApiCaller.shared.getTrandingTv { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            ApiCaller.shared.getPopuler { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            ApiCaller.shared.getUpcomingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            ApiCaller.shared.getTopRated { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    // her bir satirin yuksekligini degistir
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    // tableview icindeki headerler icin basliklar atayacagiz
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    // tableview icindeki header yani icindeki textin gorunumunu degistirecegiz
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight:.semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // asagiya dogru scroll ettigimizde appbar yukari kayip kaybolacak
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController : CollectionTableViewCellDelegate{
    func collectionViewTableCellDidTapCell(_ cell: CollectionTableViewCell, viewModel: TitlePreviewViewModel) {
         // tiklama islemi burada gerceklesiyor veriler diger sayfaya burada aktariliyor
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            print(viewModel)
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    
}
