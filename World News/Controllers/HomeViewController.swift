//
//  TrindingViewController.swift
//  World News
//
//  Created by Macbook on 06/07/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    var breakingNews = [Results]()
    var recentNews = [Results]()
    private let headerBreakingLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Breaking News"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
        
    }()
    private let headerRecentLabel : UILabel = {
        
        let label = UILabel()
        label.text = "Recent News"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
        
    }()
    private let breakingCollectionView : UICollectionView = {
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(NewsCollectionViewCell.self, forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
        // collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.masksToBounds = true
        
        return collectionView
        
        
    }()
    
    private let recentCollectionView : UICollectionView = {
        
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
        view.addSubview(breakingCollectionView)
        view.addSubview(recentCollectionView)
        view.backgroundColor = .white
        view.addSubview(headerBreakingLabel)
        view.addSubview(headerRecentLabel)
        title = "World News"
        navigationController?.navigationBar.prefersLargeTitles = true
        getdate()
        breakingCollectionView.delegate = self
        breakingCollectionView.dataSource = self
        recentCollectionView.delegate = self
        recentCollectionView.dataSource = self
        applyConstrains()
    }
    private func getdate(){
        APICaller.getBreakingNews { result in
            switch result{
            case .success(let News):
                print(News)
                self.breakingNews = News
                print(self.breakingNews)
                self.breakingCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
        APICaller.getNews { result in
            switch result{
            case .success(let News):
                print(News)
                self.recentNews = News
                print(self.recentNews)
                self.recentCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
   private func applyConstrains(){
        let height = view.frame.height
        let margins = view.layoutMarginsGuide
        
        let headerBreakingLabelConstrains = [
            headerBreakingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 17),
            headerBreakingLabel.topAnchor.constraint(equalTo: margins.topAnchor,constant: 16 ),
        ]
        let collectionViewConstrains = [
            
            breakingCollectionView.topAnchor.constraint(equalTo: headerBreakingLabel.bottomAnchor ),
            breakingCollectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            breakingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 0),
            breakingCollectionView.heightAnchor.constraint(equalToConstant:height * 0.3)
            
        ]
        let headerRecentLabelConstrains = [
            headerRecentLabel.leadingAnchor.constraint(equalTo:headerBreakingLabel.leadingAnchor),
            headerRecentLabel.topAnchor.constraint(equalTo: breakingCollectionView.bottomAnchor,constant: 4 ),
        ]
        
        let recentCollectionViewConstrains = [
        
            recentCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 8),
            recentCollectionView.topAnchor.constraint(equalTo: headerRecentLabel.bottomAnchor,constant: 20),
            recentCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8),
            recentCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        
        ]
        NSLayoutConstraint.activate(recentCollectionViewConstrains)
        NSLayoutConstraint.activate(headerRecentLabelConstrains)
        NSLayoutConstraint.activate(headerBreakingLabelConstrains)
        NSLayoutConstraint.activate(collectionViewConstrains)
    }
    
    
}
extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView{
        case recentCollectionView :
            return recentNews.count
        case breakingCollectionView :
            return  breakingNews.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch collectionView{
        case breakingCollectionView :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath)as? NewsCollectionViewCell else{
                return UICollectionViewCell()
            }
            cell.configure(wiht: breakingNews[indexPath.row])
            return cell
        case recentCollectionView:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCollectionViewCell.identifer, for: indexPath)as? RecentCollectionViewCell else{
                return UICollectionViewCell()
            }
            
            cell.configure(with: recentNews[indexPath.row])
                    return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        switch collectionView{
        case breakingCollectionView:
            return CGSize(width: width / 1.3, height: height - 50)
        case recentCollectionView:
            return CGSize(width: width - 10, height: height * 0.26)
        default:
            return CGSize()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView{
        case breakingCollectionView:
            return 10
        case recentCollectionView:
            return 20
        default:
            return CGFloat()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
      
        let vc = DetailsViewController()
        switch collectionView{
            
        case breakingCollectionView:
            let model =  breakingNews[indexPath.row]
            let savedModel = DetailsModel(title: model.title, link: model.link, creator: model.creator, description: model.description, pubDate: model.pubDate, image_url: model.image_url, source_icon: model.source_icon)
        //    vc.savedNew = savedModel
            vc.detailsModel = model
           // vc.configer(with: detailsModel)
         //   vc.newsDetails = breakingNews[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            
            //code
        case recentCollectionView :
            let model = recentNews[indexPath.row]
            print(model)

            let savedModel = DetailsModel(title: model.title, link: model.link, creator: model.creator, description: model.description, pubDate: model.pubDate, image_url: model.image_url, source_icon: model.source_icon)
         //   vc.savedNew = savedModel
            vc.detailsModel = model
    
//            let detailsModel = DetailsModel(title: model.title, link: model.link, creator: nil, description: nil, pubDate: model.pubDate, image_url: model.image_url, source_icon: model.source_icon)
         //   vc.detailsModel = model
         //   vc.configer(with: detailsModel)
        //   vc.configer(with: model)
          //  vc.newsDetails = breakingNews[indexPath.row]

            navigationController?.pushViewController(vc, animated: true)
            // code
            
            
            
        default:
            print("error")
        }
    }
    
}
