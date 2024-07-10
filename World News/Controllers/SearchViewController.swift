//
//  HomeViewController.swift
//  World News
//
//  Created by Macbook on 06/07/2024.
//

import UIKit
import SafariServices
class SearchViewController: UIViewController{
    
    
    var news = [Results]()
    
    private let searchController : UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchResultViewController())
        searchController.searchBar.placeholder = "Search for news"
        searchController.searchBar.tintColor = .label
        searchController.searchBar.searchBarStyle = .minimal
        return searchController
        
    }()

    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecentCollectionViewCell.self, forCellWithReuseIdentifier: RecentCollectionViewCell.identifer)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.masksToBounds = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = .systemBackground
        title = "Searching"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        getNews()
        
    }
    
    func getNews(){
        APICaller.getsearchNews { result in
            switch result {
            case .success(let success):
                self.news = success
                self.collectionView.reloadData()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
}
extension SearchViewController : UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return news.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCollectionViewCell.identifer, for: indexPath)as? RecentCollectionViewCell else{
            return UICollectionViewCell()
        }
        let model = news[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = news[indexPath.row]
        let vc = DetailsViewController()
        vc.detailsModel = model
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width - 10 , height: height * 0.12)
    }
    
    
    
}
extension SearchViewController : UISearchResultsUpdating , SearchResultviewControllerDelgete{
 
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        
        // check that query not empty and its count >= 3
        guard let query = searchBar.text ,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3 ,
            let resultController = searchController.searchResultsController as? SearchResultViewController else{
                return
            } 
         resultController.delegete = self
        
        APICaller.searchForNews(query: query) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let searchedNews):
                    print("Searched News",searchedNews)
                    resultController.searchedNews = searchedNews
                    resultController.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }

        
    }
    func SearchResultViewControllerDidTaped(_ model: Results) {
        DispatchQueue.main.async { [weak self] in
            let vc = DetailsViewController()
            vc.detailsModel = model
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
