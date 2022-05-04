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
    
    private lazy var formatter: DateFormatter =  {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(model: HourlyWeatherDto) {
        if let date = model.date {
            weatherTime.text = formatter.string(from: date)
        } else {
            weatherTime.text = "Date parsing failed"
        }
        
        weatherTemperature.text = "\(Int(model.temperature.value))°"
        
        let iconNumber = model.weatherIcon
        switch iconNumber {
        case 1 :
            weatherPicture.image = UIImage(systemName: "sun.max")
        case 2 :
            weatherPicture.image = UIImage(systemName: "sun.min")
        case 3 :
            weatherPicture.image = UIImage(systemName: "cloud.sun")
        case 4 :
            weatherPicture.image = UIImage(systemName: "cloud.sun")
        case 5 :
            weatherPicture.image = UIImage(systemName: "sun.haze")
        case 6 :
            weatherPicture.image = UIImage(systemName: "cloud.sun")
        case 7 :
            weatherPicture.image = UIImage(systemName: "cloud")
        case 8 :
            weatherPicture.image = UIImage(systemName: "cloud.fill")
        case 11 :
            weatherPicture.image = UIImage(systemName: "cloud.fog")
        case 12 :
            weatherPicture.image = UIImage(systemName: "cloud.hail")
        case 13 :
            weatherPicture.image = UIImage(systemName: "cloud.sun.rain")
        case 14 :
            weatherPicture.image = UIImage(systemName: "cloud.sun.rain")
        case 15 :
            weatherPicture.image = UIImage(systemName: "cloud.bolt.rain")
        case 16 :
            weatherPicture.image = UIImage(systemName: "cloud.sun.bolt")
        case 17 :
            weatherPicture.image = UIImage(systemName: "cloud.sun.bolt")
        case 18 :
            weatherPicture.image = UIImage(systemName: "cloud.havyrain")
        case 19 :
            weatherPicture.image = UIImage(systemName: "cloud")
        case 20 :
            weatherPicture.image = UIImage(systemName: "cloud.sun")
        case 21 :
            weatherPicture.image = UIImage(systemName: "cloud.sun")
        case 22 :
            weatherPicture.image = UIImage(systemName: "cloud.snow")
        case 23 :
            weatherPicture.image = UIImage(systemName: "cloud.snow")
        default :
            print("Error")
        }
    }
}
