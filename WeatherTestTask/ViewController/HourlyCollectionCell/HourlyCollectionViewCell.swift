//
//  HourlyCollectionViewCell.swift
//  WeatherTestTask
//
//  Created by Сергей  on 27.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    static var nib: UINib { UINib(nibName: "HourlyCollectionViewCell", bundle: .main) }
    static var identifier = "HourlyCollectionViewCell"

    @IBOutlet weak var weatherTime: UILabel!
    @IBOutlet weak var weatherPicture: UIImageView!
    @IBOutlet weak var weatherTemperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(model: HourlyWeatherDto){
        self.weatherTime.text = model.dateTime
        self.weatherTemperature.text = "\(model.temperature.value)°"
//        self.weatherPicture.image = UIImage(named: "cloud.sun.rain")
    }
}
