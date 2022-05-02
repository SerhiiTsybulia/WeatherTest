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
        formatter.dateStyle = .medium
        formatter.timeZone = .current
        return formatter
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected{
            dayLabel.textColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)
            temperatureLabel.textColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)
            weatherImg.tintColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)
        }else{
            dayLabel.textColor = UIColor(red: 25/255.0, green: 26/255.0, blue: 25/255.0, alpha: 1.0)
            temperatureLabel.textColor = UIColor(red: 25/255.0, green: 26/255.0, blue: 25/255.0, alpha: 1.0)
            weatherImg.tintColor = UIColor(red: 25/255.0, green: 26/255.0, blue: 25/255.0, alpha: 1.0)
        }
        
        
    }
    static let identifire = "WeatherTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    func setupCell5Days (model: DailyForecast) {
        if let timeResult = model.epochDate{
            let date = Date(timeIntervalSince1970: TimeInterval(timeResult))
            let localDate = formatter.string(from: date)
            dayLabel.text = localDate
        } else {
            dayLabel.text = "Decodable error"
        }
        
        let max = model.temperature.maximum
        let min = model.temperature.minimum
        
        self.temperatureLabel.text = "\(max)°/\(min)°"
    }
}

