//
//  RecentCollectionViewCell.swift
//  World News
//
//  Created by Macbook on 06/07/2024.
//

import UIKit

class RecentCollectionViewCell: UICollectionViewCell {
    static let identifer = "RecentCollectionViewCell"
    
    let view : UIView = {
       
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
       view.backgroundColor = .label
       view.layer.cornerRadius = 20
       return view
   }()
    
    var titleLabel : UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.numberOfLines = 2
       label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .systemBackground
       return label
       
   }()
    var creatorLabel : UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .label
       return label
       
   }()
    var posterImageView : UIImageView = {
       
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
       image.layer.cornerRadius = 15
       image.translatesAutoresizingMaskIntoConstraints = false
       image.layer.masksToBounds = true

       return image
       
   }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(view)
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(creatorLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        // We should but the views
        contentView.addSubview(view)
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(creatorLabel)
        applyConstrains()

    }
    
    func configure(with model : Results){
        titleLabel.text = model.title
        let url = URL(string: model.image_url ?? "https://www.bicesteradvertiser.net/resources/images/18277766/?type=app&htype=0")
        posterImageView.sd_setImage(with: url)
       // creatorLabel.text = model.creator?.first
    }

    
    private func applyConstrains(){
        let width = contentView.frame.width

        let viewConstrains = [
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

         ]
        let posterImageConstrains = [
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 6),
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 12),
            posterImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -12),
            posterImageView.widthAnchor.constraint(equalToConstant: width * 0.30),
        ]
        let titleLabelConstrains = [
        
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor,constant: 16),
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor ,constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -4),

        ]
        let createLabelConstrains = [
        
            creatorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8),
            creatorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        
        ]
        NSLayoutConstraint.activate(viewConstrains)
        NSLayoutConstraint.activate(posterImageConstrains)
        NSLayoutConstraint.activate(titleLabelConstrains)
        NSLayoutConstraint.activate(createLabelConstrains)

        
    }


    
    
}
