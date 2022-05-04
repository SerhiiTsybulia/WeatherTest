//
//  WeatherTableViewCell.swift
//  WeatherTestTask
//
//  Created by Сергей on 18.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    let mainView = ViewController()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    
    private lazy var formatter: DateFormatter =  {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeZone = .current
        formatter.dateFormat = "E"
        return formatter
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let updateSelection: () -> Void = {
            if selected {
                self.dayLabel.textColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)
                self.temperatureLabel.textColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)
                self.weatherImg.tintColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)
            } else {
                self.dayLabel.textColor = UIColor(red: 25/255.0, green: 26/255.0, blue: 25/255.0, alpha: 1.0)
                self.temperatureLabel.textColor = UIColor(red: 25/255.0, green: 26/255.0, blue: 25/255.0, alpha: 1.0)
                self.weatherImg.tintColor = UIColor(red: 25/255.0, green: 26/255.0, blue: 25/255.0, alpha: 1.0)
            }
        }
        
        if animated {
            UIView.animate(withDuration: CATransaction.animationDuration(),
                           animations: updateSelection)
        } else {
            UIView.performWithoutAnimation(updateSelection)
        }
    }
    static let identifire = "WeatherTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    func setupCell5Days (model: DailyForecastDto) {
        if let date = model.dateConv {
            let str = formatter.string(from: date)
            dayLabel.text = str.uppercased()
        } else {
            dayLabel.text = "Date parsing failed"
        }
        
        let max = model.temperature?.maximum.value ?? 0
        let min = model.temperature?.minimum.value ?? 0
        
        temperatureLabel.text = "\(Int(max))° / \(Int(min))°"
        
        let iconNumber = model.day.icon
        switch iconNumber {
        case 1 :
            weatherImg.image = UIImage(systemName: "sun.max")
        case 2 :
            weatherImg.image = UIImage(systemName: "sun.min")
        case 3 :
            weatherImg.image = UIImage(systemName: "cloud.sun")
        case 4 :
            weatherImg.image = UIImage(systemName: "cloud.sun")
        case 5 :
            weatherImg.image = UIImage(systemName: "sun.haze")
        case 6 :
            weatherImg.image = UIImage(systemName: "cloud.sun")
        case 7 :
            weatherImg.image = UIImage(systemName: "cloud")
        case 8 :
            weatherImg.image = UIImage(systemName: "cloud.fill")
        case 11 :
            weatherImg.image = UIImage(systemName: "cloud.fog")
        case 12 :
            weatherImg.image = UIImage(systemName: "cloud.hail")
        case 13 :
            weatherImg.image = UIImage(systemName: "cloud.sun.rain")
        case 14 :
            weatherImg.image = UIImage(systemName: "cloud.sun.rain")
        case 15 :
            weatherImg.image = UIImage(systemName: "cloud.bolt.rain")
        case 16 :
            weatherImg.image = UIImage(systemName: "cloud.sun.bolt")
        case 17 :
            weatherImg.image = UIImage(systemName: "cloud.sun.bolt")
        case 18 :
            weatherImg.image = UIImage(systemName: "cloud.havyrain")
        case 19 :
            weatherImg.image = UIImage(systemName: "cloud")
        case 20 :
            weatherImg.image = UIImage(systemName: "cloud.sun")
        case 21 :
            weatherImg.image = UIImage(systemName: "cloud.sun")
        case 22 :
            weatherImg.image = UIImage(systemName: "cloud.snow")
        case 23 :
            weatherImg.image = UIImage(systemName: "cloud.snow")
        default :
            print("Error")
        }
    }
}
