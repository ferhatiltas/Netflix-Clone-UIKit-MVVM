//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by ferhatiltas on 8.03.2022.
//

import UIKit

class HomeViewController: UIViewController {
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
        
//        configureNavBar()
       
        // tableview ust tarafindan verilen deger kadar bosluk birakir. Oraya olusturdugumuz HeroHeaderUIView ekleyecegiz
        let headerView = HeroHeaderUIView(frame:CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTableView.tableHeaderView = headerView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTableView.frame = view.bounds
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        // tableview x parcaya ayirir
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // ayrilan table viewda (numberOfSections) her bir parcaya kac tane eleman girecegi belirlenir
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else {
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
}

