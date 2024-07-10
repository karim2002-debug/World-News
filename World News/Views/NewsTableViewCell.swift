//
//  NewsTableViewCell.swift
//  World News
//
//  Created by Macbook on 06/07/2024.
//

import UIKit

import UIKit
import SDWebImage
class NewsTableViewCell: UITableViewCell {

    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    private let pubDateLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    private let posterImage : UIImageView = {
        
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
        
    }()
    
    
    static let identifier = "NewTableViewCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(posterImage)
        contentView.addSubview(pubDateLabel)
        applyConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    
    func configer(with model : Results){
        print(model)
        titleLabel.text = model.title
        pubDateLabel.text = model.pubDate
        guard let url = URL(string: model.image_url ?? "https://1734811051.rsc.cdn77.org/data/images/full/449023/rumor-apple-is-working-on-iphone-19-luck-project-what-are-other-os-names.jpg")else{return}
        posterImage.sd_setImage(with: url)
    }
    
    
   func applyConstrains(){
       let height = contentView.frame.height - 30
       let titleConstrains = [
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
        titleLabel.trailingAnchor.constraint(equalTo: posterImage.trailingAnchor)

        ]
       let posterImageConstrains = [

       posterImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 16),
       posterImage.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
       posterImage.heightAnchor.constraint(equalToConstant: 110),
       posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20)
       ]
       
       let pubDateConstrains = [
        pubDateLabel.topAnchor.constraint(equalTo:posterImage.bottomAnchor,constant: 8 ),
        pubDateLabel.trailingAnchor.constraint(equalTo: posterImage.trailingAnchor)
        ]
       NSLayoutConstraint.activate(titleConstrains)
       NSLayoutConstraint.activate(pubDateConstrains)
       NSLayoutConstraint.activate(posterImageConstrains)

    }
        
        
        

}

