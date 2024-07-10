//
//  DetailsViewController.swift
//  World News
//
//  Created by Macbook on 06/07/2024.
//

import UIKit
import SDWebImage
import SafariServices
class DetailsViewController: UIViewController {
    
    // MARK: OUTLETS
    var exist : Bool = false
    var savedNews = [String]()
    var fromSavedViewController : Bool = false
    var detailsModel : Results!
    var deleteNews = NewsInfo()
   
    private let scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
        
    }()
    
    private let contentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()
    
    private let posterImage : UIImageView = {
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
        
    }()
    
    private let sourceImage : UIImageView = {
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = image.frame.width / 2
        return image
        
    }()
    
    private let creatorLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        label.numberOfLines = 2
        label.sizeToFit()
        
        return label
        
    }()
    
    private let pubDateLabel : UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    private let descreptionLabel : UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.sizeToFit()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    // MARK: Start func

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if fromSavedViewController{
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: self, action: #selector(didTapedSaervesButton)),
                UIBarButtonItem(image: UIImage(systemName: "bookmark.fill"), style: .done, target: self, action: #selector(didTapedUnSavedButton))
            ]
            
        }else{
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .done, target: self, action: #selector(didTapedSaervesButton)),
                UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .done, target: self, action: #selector(didTapedSavedButton))
            ]
        }
        
        
        navigationController?.navigationBar.tintColor = .label

        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(descreptionLabel)
        contentView.addSubview(posterImage)
        contentView.addSubview(pubDateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(creatorLabel)
        contentView.addSubview(sourceImage)
        view.backgroundColor = .systemBackground
        getData()
        configer()
        applyConstrains()
    
    }
    // MARK: Action

    @objc func didTapedUnSavedButton(){
        
        DataPersistenceManger.deleteNews(model: deleteNews) { result in
            switch result {
            case .success():
                print("Deleted from date base")
                NotificationCenter.default.post(name: NSNotification.Name("didTabedUNsavedButton"), object:nil)
                self.navigationController?.popViewController(animated: true)
            case .failure(let failure):
                print(failure)

            }
        }
    }
   private func getData(){

        DataPersistenceManger.getSavedNews { [self] result in
            switch result{
            case .success(let newsSaved):
                if newsSaved.count > 0{
                    for i in 0 ... newsSaved.count - 1{
                        self.savedNews.append(newsSaved[i].title!)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    @objc func didTapedSavedButton(){
        guard let detailsModel = detailsModel else {
            return
        }
        
        if savedNews.count == 0{
            saveNew()
        }
        
        for i in 0 ... savedNews.count - 1{
            
            if detailsModel.title == savedNews[i]{
                print("this model is exist")
                exist = true
            }
        }
        if exist == false{
            saveNew()
        }
    }
    
    func saveNew(){
        DataPersistenceManger.saveNew(model: detailsModel) { [self] result in
            switch result{
            case .success():
                self.savedNews.append(detailsModel.title!)
                NotificationCenter.default.post(name: NSNotification.Name("didTapedSavedButtonTodataBase"), object: nil)
                let vc = UIAlertController(title: nil, message: "You Saved this News ", preferredStyle: .alert)
                vc.addAction(UIAlertAction(title: "Done", style: .default))
                self.present(vc, animated: true)
                print("Added to saved")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func didTapedSaervesButton(){
        let url = detailsModel.link
        let vc = SFSafariViewController(url: URL(string: url!)!)
        present(vc, animated: true)
    }
    
 
    
    func configer(){
        titleLabel.text = detailsModel.title
        pubDateLabel.text = detailsModel.pubDate
        creatorLabel.text = "By \(detailsModel.creator?.first ?? "Not known")"
        descreptionLabel.text = detailsModel.description
        posterImage.sd_setImage(with: URL(string: detailsModel.image_url ?? ""))
        sourceImage.sd_setImage(with: URL(string:detailsModel.source_icon ?? "" ))
    }
    
    
    private func applyConstrains(){
//        let guardArea = view.safeAreaLayoutGuide
        let scrollConstrains = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ]
        let contentViewConstrains = [
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ]
        let posterImageConstrains = [
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 0),
            posterImage.heightAnchor.constraint(equalToConstant: 300),
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 4)
        ]
        let titleLabelConstrains = [
            titleLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor,constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor ,constant: -8)
        ]
        let sourceImageConstrains = [
            sourceImage.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            sourceImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 24),
            sourceImage.widthAnchor.constraint(equalToConstant: 40),
            sourceImage.heightAnchor.constraint(equalToConstant: 40),
        ]
        let creatorlabelConstrains = [
            creatorLabel.centerYAnchor.constraint(equalTo: sourceImage.centerYAnchor),
          //  creatorLabel.topAnchor.constraint(equalTo: sourceImage.topAnchor,constant: 12),
             creatorLabel.leadingAnchor.constraint(equalTo: sourceImage.trailingAnchor,constant: 8),
            creatorLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        let pubDatelabelConstrains = [
            pubDateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor,constant: -4),
            pubDateLabel.centerYAnchor.constraint(equalTo: creatorLabel.centerYAnchor)
        ]
        let descreptionConstrains = [
            descreptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descreptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descreptionLabel.topAnchor.constraint(equalTo: sourceImage.bottomAnchor, constant: 32),
            descreptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(sourceImageConstrains)
        NSLayoutConstraint.activate(scrollConstrains)
        NSLayoutConstraint.activate(contentViewConstrains)
        NSLayoutConstraint.activate(titleLabelConstrains)
        NSLayoutConstraint.activate(posterImageConstrains)
        NSLayoutConstraint.activate(creatorlabelConstrains)
        NSLayoutConstraint.activate(pubDatelabelConstrains)
        NSLayoutConstraint.activate(descreptionConstrains)
    }

}
