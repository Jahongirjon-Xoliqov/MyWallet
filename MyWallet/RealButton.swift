//
//  RealButton.swift
//  MyWallet
//
//  Created by Dzakhon on 20/03/24.
//

import UIKit

class RealButton: UIButton {
    
    func changeContent() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    func setConstraints() {
        
        if let imageView {
            addSubview(imageView)
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        }
        
        if let titleLabel {
            addSubview(titleLabel)
            titleLabel.numberOfLines = 2
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.topAnchor.constraint(equalTo: imageView!.bottomAnchor, constant: 10).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        }
        
        
    }
    
}
