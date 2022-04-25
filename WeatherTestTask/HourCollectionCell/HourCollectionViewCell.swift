//
//  HourCollectionViewCell.swift
//  WeatherTestTask
//
//  Created by Сергей on 25.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit

class HourCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static let identifire = "HourCollectionViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "HourCollectionViewCell", bundle: nil)
    }

}
