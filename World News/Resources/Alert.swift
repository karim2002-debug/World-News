

import Foundation

import UIKit

@objc protocol didTapedAlertButtonsDelegete{
    @objc optional func didTapedNormalButton()
    @objc optional func didTapedDestractiveButton()
}

class AlertViewController: UIViewController {
    
    
    //MARK: OUTLETS
    
    var delegete : didTapedAlertButtonsDelegete?
    public var alertTitleisFound : Bool!
    public var  isDestractiveButton : Bool!
    public var isImageExist : Bool!
    
    
    private let alertImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.tintColor = .red
        return image
    }()
    private let destractiveButton : UIButton = {
        let deleteButton = UIButton()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.tintColor = .red
        deleteButton.setTitleColor(.red, for: .normal)
        deleteButton.titleLabel?.font = .systemFont(ofSize: 18 , weight: .bold)
        return deleteButton
    }()
    private let normalButton : UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 18 , weight: .bold)
        button.setTitleColor(.systemBackground, for: .normal)
        return button
    }()
    private let seperateViewBetweenButton : UIView = {
        let seperte = UIView()
        seperte.translatesAutoresizingMaskIntoConstraints = false
        seperte.backgroundColor = .systemGray
        return seperte
    }()
    private let separtingLineMesaage : UIView = {
        let separeteView = UIView()
        separeteView.backgroundColor = .systemGray
        separeteView.translatesAutoresizingMaskIntoConstraints = false
        return separeteView
    }()
    
    private let alertMessage : UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let alertTitle : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    private let alertBackGround : UIView  = {
        let view = UIView()
        view.backgroundColor = .label
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    //MARK: VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.backgroundColor?.withAlphaComponent(1)
        view.addSubview(alertBackGround)
        view.addSubview(separtingLineMesaage)
        view.addSubview(alertMessage)
        view.addSubview(normalButton)
        view.addSubview(alertImage)
        
        if alertTitleisFound == true{
            view.addSubview(alertTitle)
        }else{
            alertTitle.isHidden = true
        }
        view.addSubview(destractiveButton)
        
        if isDestractiveButton == true{
            view.addSubview(normalButton)
            view.addSubview(destractiveButton)
            view.addSubview(seperateViewBetweenButton)
            normalButton.setTitle("Cancel", for: .normal)
            destractiveButton.setTitle("Delete", for: .normal)
            
        }else{
            view.addSubview(normalButton)
            normalButton.setTitle("Done", for: .normal)
        }
        applyConstrains()
        
        if isDestractiveButton == true{
            normalButton.addTarget(self, action: #selector(didTapedNormalButton), for: .touchUpInside)
            destractiveButton.addTarget(self, action: #selector(didTapedDelstractiveButtonButton), for: .touchUpInside)
        }else{
            normalButton.addTarget(self, action: #selector(didTapedNormalButton), for: .touchUpInside)
        }
    }
    
    //MARK: VIEWWILLAPPEAR
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0) {
            
            self.view.backgroundColor = .black.withAlphaComponent(0)
        }
    }
    
    //MARK: ACTIONS
    
    @objc private func didTapedNormalButton(){
        delegete?.didTapedNormalButton!()
    }
    @objc private func didTapedDelstractiveButtonButton(){
        delegete?.didTapedDestractiveButton!()
    }
    
    func showAlert(message : String , titleName : String? ,  image : UIImage? , isDestractive : Bool ){
        
        if titleName != nil{
            alertTitleisFound = true
            alertTitle.text = titleName
            alertMessage.text = message
            
        }else{
            alertTitleisFound = false
            alertMessage.text = message
        }
        if isDestractive == true{
            isDestractiveButton = true
            
        }else{
            isDestractiveButton = false
            destractiveButton.isHidden = true
        }
        if image != nil{
            isImageExist = true
            alertImage.image = image
        }else{
            isImageExist = false
            alertImage.isHidden = true
            
        }
    }
    
    
    private func applyConstrains(){
        
        let width = view.frame.width
        //  let height = view.frame.height
        
        let alertBackgroundConstrains = [
            
            alertBackGround.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertBackGround.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertBackGround.widthAnchor.constraint(equalToConstant:width - 100),
            // alertBackGround.heightAnchor.constraint(equalToConstant: height / 2.4)
            alertBackGround.bottomAnchor.constraint(equalTo: normalButton.bottomAnchor , constant: 8)
        ]
        
        
        
        if isImageExist == true{
            
            let imageConstrains = [
                alertImage.centerXAnchor.constraint(equalTo: alertBackGround.centerXAnchor),
                alertImage.topAnchor.constraint(equalTo: alertBackGround.topAnchor , constant: 4),
                alertImage.heightAnchor.constraint(equalToConstant: 50),
                alertImage.widthAnchor.constraint(equalToConstant: 50)
            ]
            NSLayoutConstraint.activate(imageConstrains)
            
        }
        
        
        if alertTitleisFound == true{
            if isImageExist == true{
                let alertTitleCons = [
                    alertTitle.centerXAnchor.constraint(equalTo: alertBackGround.centerXAnchor),
                    alertTitle.leadingAnchor.constraint(equalTo: alertBackGround.leadingAnchor , constant: 10),
                    alertTitle.trailingAnchor.constraint(equalTo: alertBackGround.trailingAnchor,constant: -10),
                    alertTitle.topAnchor.constraint(equalTo: alertImage.bottomAnchor,constant: 8)
                ]
                NSLayoutConstraint.activate(alertTitleCons)
                let alertMessageConstrains = [
                    alertMessage.leadingAnchor.constraint(equalTo: alertBackGround.leadingAnchor, constant: 8),
                    alertMessage.trailingAnchor.constraint(equalTo: alertBackGround.trailingAnchor, constant: -8),
                    alertMessage.topAnchor.constraint(equalTo: alertTitle.bottomAnchor, constant: 8)
                ]
                NSLayoutConstraint.activate(alertMessageConstrains)
                
            }else{
                let alertTitleWithoutImageCons = [
                    
                    alertTitle.centerXAnchor.constraint(equalTo: alertBackGround.centerXAnchor),
                    alertTitle.leadingAnchor.constraint(equalTo: alertBackGround.leadingAnchor , constant: 10),
                    alertTitle.trailingAnchor.constraint(equalTo: alertBackGround.trailingAnchor,constant: -10),
                    alertTitle.topAnchor.constraint(equalTo: alertBackGround.topAnchor,constant: 8)
                    
                ]
                NSLayoutConstraint.activate(alertTitleWithoutImageCons)
                let alertMessageConstrains = [
                    alertMessage.leadingAnchor.constraint(equalTo: alertBackGround.leadingAnchor, constant: 8),
                    alertMessage.trailingAnchor.constraint(equalTo: alertBackGround.trailingAnchor, constant: -8),
                    alertMessage.topAnchor.constraint(equalTo: alertTitle.bottomAnchor, constant: 8)
                ]
                NSLayoutConstraint.activate(alertMessageConstrains)
            }
        }
        else{
            if isImageExist == true{
                let alertMessageConstrains = [
                    alertMessage.centerXAnchor.constraint(equalTo: alertBackGround.centerXAnchor,constant: 10),
                    alertMessage.trailingAnchor.constraint(equalTo: alertBackGround.trailingAnchor, constant: -8),
                    alertMessage.topAnchor.constraint(equalTo: alertImage.bottomAnchor, constant: 8)
                    
//                    alertMessage.leadingAnchor.constraint(equalTo: alertBackGround.leadingAnchor, constant: 8),
//                    alertMessage.trailingAnchor.constraint(equalTo: alertBackGround.trailingAnchor, constant: -8),
//                    alertMessage.topAnchor.constraint(equalTo: alertImage.bottomAnchor, constant: 8)
                ]
                NSLayoutConstraint.activate(alertMessageConstrains)
            }else{
                let alertMessageWithoutTitleConstrains = [
                    alertMessage.centerXAnchor.constraint(equalTo: alertBackGround.centerXAnchor),
//                    alertMessage.trailingAnchor.constraint(equalTo: alertBackGround.trailingAnchor, constant: -8),
                    alertMessage.topAnchor.constraint(equalTo: alertImage.bottomAnchor, constant: 8)
                    
//                    alertMessage.leadingAnchor.constraint(equalTo: alertBackGround.leadingAnchor, constant: 8),
//                    alertMessage.trailingAnchor.constraint(equalTo: alertBackGround.trailingAnchor, constant: -8),
//                    alertMessage.topAnchor.constraint(equalTo: alertBackGround.topAnchor, constant: 8)
                ]
                NSLayoutConstraint.activate(alertMessageWithoutTitleConstrains)
            }
        }
        
        let alertseperteLineMessageConstrains = [
            separtingLineMesaage.leadingAnchor.constraint(equalTo: alertBackGround.leadingAnchor , constant: 8),
            separtingLineMesaage.trailingAnchor.constraint(equalTo: alertBackGround.trailingAnchor , constant: -8),
            separtingLineMesaage.topAnchor.constraint(equalTo: alertMessage.bottomAnchor , constant: 8),
            separtingLineMesaage.heightAnchor.constraint(equalToConstant: 2),
        ]
        
        if isDestractiveButton == true{
            let destractiveButtonConstrains = [
                destractiveButton.leadingAnchor.constraint(equalTo: alertBackGround.leadingAnchor, constant: 8),
                destractiveButton.topAnchor.constraint(equalTo: separtingLineMesaage.bottomAnchor, constant: 8),
                //   DestractiveButton.widthAnchor.constraint(equalToConstant: 100),
                destractiveButton.trailingAnchor.constraint(equalTo: alertBackGround.centerXAnchor)
            ]
            
            let normalButton = [
                normalButton.leadingAnchor.constraint(equalTo: destractiveButton.trailingAnchor, constant: 8),
                normalButton.centerYAnchor.constraint(equalTo: destractiveButton.centerYAnchor),
                normalButton.trailingAnchor.constraint(equalTo: alertBackGround.trailingAnchor , constant: -8)
            ]
            let seperteBetweenBtnConstrains = [
                seperateViewBetweenButton.topAnchor.constraint(equalTo: separtingLineMesaage.bottomAnchor),
                seperateViewBetweenButton.centerXAnchor.constraint(equalTo: alertBackGround.centerXAnchor),
                seperateViewBetweenButton.bottomAnchor.constraint(equalTo: alertBackGround.bottomAnchor),
                seperateViewBetweenButton.widthAnchor.constraint(equalToConstant: 2)
            ]
            NSLayoutConstraint.activate(seperteBetweenBtnConstrains)
            NSLayoutConstraint.activate(destractiveButtonConstrains)
            NSLayoutConstraint.activate(normalButton)
            
        }else{
            
            let DoneButtonConstrains = [
                normalButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                normalButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8),
                normalButton.topAnchor.constraint(equalTo: separtingLineMesaage.bottomAnchor , constant: 8)
            ]
            NSLayoutConstraint.activate(DoneButtonConstrains)
        }
        NSLayoutConstraint.activate(alertseperteLineMessageConstrains)
        NSLayoutConstraint.activate(alertBackgroundConstrains)
        
    }
    
    
}
