//
//  SavedViewController.swift
//  World News
//
//  Created by Macbook on 06/07/2024.
//

import UIKit

class SavedViewController: UIViewController {
    
    //MARK: Outlets
    var savedNews : [NewsInfo] = [NewsInfo]()
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
    
    //MARK: Start func
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved"
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        getData()
        confirmNotificationCenter()
    }
    //MARK: will Start func
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(didTapedDeleteAllButton))
        navigationController?.navigationBar.tintColor = .red
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    //MARK: Action
    private func confirmNotificationCenter(){
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("didTabedUNsavedButton"), object: nil, queue: .none) { _ in
            self.getData()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("didTabedUNsavedAllButton"), object: nil, queue: .none) { _ in
            self.getData()
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name("didTapedSavedButtonTodataBase"), object: nil, queue: .none) { _ in
            self.getData()
        }
        
    }
    
    @objc func didTapedDeleteAllButton(){
        let alert = AlertViewController()
        alert.showAlert(message: "Are you sure about deleting all", titleName: nil, image: UIImage(named: "alert"), isDestractive: true)
        alert.delegete = self
        alert.modalPresentationStyle = .overFullScreen
        present(alert, animated: true)
    }
    
    private func getData(){
        
        DataPersistenceManger.getSavedNews { [weak self] result in
            switch result{
            case .success(let newsSaved):
                self?.savedNews = newsSaved
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
//MARK: confirm collection view function
extension SavedViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedNews.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentCollectionViewCell.identifer, for: indexPath)as? RecentCollectionViewCell else{
            return UICollectionViewCell()
        }
        let model = savedNews[indexPath.row]
        let ResultModel = Results(title: model.title, link: model.link, creator:nil, description: model.desc, pubDate: model.pubDate, image_url: model.image_url, source_icon: model.source_icon)
        cell.configure(with: ResultModel)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = savedNews[indexPath.row]
        let vc = DetailsViewController()
        let detailsModel = Results(title: model.title, link: model.link, creator: nil, description: model.desc, pubDate: model.pubDate, image_url: model.image_url, source_icon: model.source_icon)
        vc.detailsModel = detailsModel
        vc.deleteNews = model
        vc.fromSavedViewController = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SavedViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width - 10 , height: height * 0.12)
    }
}



extension SavedViewController : didTapedAlertButtonsDelegete{
    
    func didTapedNormalButton() {
        dismiss(animated: true)
    }
    
    func didTapedDestractiveButton() {
        if savedNews.count == 0{
            print("Breaked")
        }
        else{
            for i in 0...savedNews.count - 1{
                DataPersistenceManger.deleteNews(model: savedNews[i]) { result in
                    switch result {
                    case .success():
                        print("done")
                    case .failure(let failure):
                        print(print(failure))
                    }
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name("didTabedUNsavedAllButton"), object:nil)
        }
        dismiss(animated: true)
    }
    
    
}
