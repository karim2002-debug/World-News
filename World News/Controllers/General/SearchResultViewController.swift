//
//  SearchResultViewController.swift
//  World News
//
//  Created by Macbook on 09/07/2024.
//

import UIKit

protocol SearchResultviewControllerDelgete{
    func SearchResultViewControllerDidTaped( _ model : Results)
}
class SearchResultViewController: UIViewController {
    
    //MARK: Outlets
    var delegete : SearchResultviewControllerDelgete?
    var searchedNews = [Results]()
    
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecentCollectionViewCell.self, forCellWithReuseIdentifier: RecentCollectionViewCell.identifer)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.masksToBounds = true
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
        
    }()
    //MARK: Start func
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    
}
//MARK: confirm collection view function

extension SearchResultViewController : UICollectionViewDelegate , UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedNews.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCollectionViewCell.identifer, for: indexPath)as? RecentCollectionViewCell else{
            return UICollectionViewCell()
        }
        let model = searchedNews[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegete?.SearchResultViewControllerDidTaped(searchedNews[indexPath.row])
    }
    
}

extension SearchResultViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width - 10 , height: height * 0.12)
    }
}
