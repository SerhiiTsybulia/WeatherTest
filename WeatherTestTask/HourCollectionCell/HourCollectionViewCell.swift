//
//  HourCollectionViewCell.swift
//  WeatherTestTask
//
//  Created by Igor Skorina on 25.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HourCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 90/255.0, green: 159/255.0, blue: 240/255.0, alpha: 1.0)
//        addSubview(mainImageView)
//
//        NSLayoutConstraint.activate([
//            mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
//            mainImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20),
//            mainImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
//            mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 30)
//        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
        
    }
    
//    let mainImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = UIColor(red: 90/255.0, green: 159/255.0, blue: 240/255.0, alpha: 1.0)
//        imageView.tintColor = .white
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
}
