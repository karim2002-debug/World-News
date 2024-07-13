//
//  Indicator.swift
//  World News
//
//  Created by Macbook on 11/07/2024.
//

import Foundation
import NVActivityIndicatorView


class Indicator : UIViewController {
    static let shared = Indicator()
    let indicator : NVActivityIndicatorView = {
        let indicator = NVActivityIndicatorView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 50, height: 50)))
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.type = .ballClipRotateMultiple
        indicator.color = .label
         return indicator
    }()
    
 
    
    func ApplyConstrains(){
        
        view.addSubview(indicator)
        let indicatorConstrain = [
            indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(indicatorConstrain)
    }

    
    
}
