//
//  NewsCollectionViewCell.swift
//  World News
//
//  Created by Macbook on 06/07/2024.
//

import UIKit
import SDWebImage
class NewsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "NewsCollectionViewCell"
     var titleLabel : UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 17, weight: .bold)
         label.textColor = .systemBackground
        return label
    }()
     let view : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .label
        view.alpha = 0.8
         view.layer.cornerRadius = 0
        return view
    }()
     var posterImageView : UIImageView = {

        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 25
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        return image
    
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(posterImageView)
        addSubview(view)
        addSubview(titleLabel)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        //  posterImageView.frame = contentView.bounds
        applycontrains()
        
    }
    func configure(wiht model : Results){
        titleLabel.text = model.title
      guard let url = URL(string: model.image_url ?? "https://www.bicesteradvertiser.net/resources/images/18277766/?type=app&htype=0")else{return}
        posterImageView.sd_setImage(with: url)
    }
    private func applycontrains(){
        let posterImageViewConstrains = [
            
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -2),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        let viewConstrains = [
            view.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            view.topAnchor.constraint(equalTo: posterImageView.centerYAnchor , constant: 12)
        ]
        let titleLabelContrains = [
            
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            //  titleLabel.trailingAnchor.constraint(equalTo: posterImageView.trailingAnchor ,constant: -8),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor ,constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor ,constant: 20),
            // titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: 4)
        ]
        NSLayoutConstraint.activate(posterImageViewConstrains)
        NSLayoutConstraint.activate(viewConstrains)
        NSLayoutConstraint.activate(titleLabelContrains)        
    }
}
