//
//  Header.swift
//  WeatherTestTask
//
//  Created by Сергей on 18.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit

protocol HeaderProtocol {
    var positionClickHandler: (() -> Void)? { get set }
    var searchClickHandler: (() -> Void)? { get set }
    
    func updateWeather(with models: [HourlyWeatherDto])
    func updateHeaderLocation(with model: LocationResponse)
    func updateHeaderData(with model: DailyForecastDto)
}

class Header: UIView {
    
    static func create() -> Header? {
        UINib(nibName: "Header", bundle: .main).instantiate(withOwner: nil, options: nil).first as? Header
    }
    
    var positionClickHandler: (() -> Void)?
    var searchClickHandler: (() -> Void)?
    
    private var hourlyWeatherModels: [HourlyWeatherDto]?
    
    // MARK: - Outlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    
    @IBAction func locationClicked() { positionClickHandler?() }
    @IBAction func searchClicked() { searchClickHandler?() }
    
    @IBOutlet weak var locationLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var temperatureLable: UILabel!
    @IBOutlet weak var speedOfWind: UILabel!
    @IBOutlet weak var windOrientation: UIImageView!
    @IBOutlet weak var weatherPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit() {
        initCollectionView()
    }
    
    private func initCollectionView() {
        hourlyCollectionView.register( HourlyCollectionViewCell.nib, forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        hourlyCollectionView.dataSource = self
    }
    // MARK: - Header weather and location data update
        
    private lazy var formatter: DateFormatter =  {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeZone = .current
        formatter.dateFormat = "E, d MMM"
        return formatter
    }()
    
    private func innerUpdateHeaderData(with model: DailyForecastDto) {
        if let date = model.dateConv {
            let str = formatter.string(from: date)
            dateLable.text = str.uppercased()
        } else {
            dateLable.text = "Date parsing failed"
        }
        
        let max = model.temperature?.maximum.value ?? 0
        let min = model.temperature?.minimum.value ?? 0
        
        temperatureLable.text = "\(Int(max))° / \(Int(min))°"
        
        let speed = model.day.wind.speed.value
        speedOfWind.text = "\(Int(speed))м/сек"
        
        let direction = model.day.wind.direction.localized
        switch direction {
        case "N" :
            windOrientation.image = UIImage(named: "icon_wind_n")
        case "E" :
            windOrientation.image = UIImage(named: "icon_wind_e")
        case "NE" :
            windOrientation.image = UIImage(named: "icon_wind_ne")
        case "S" :
            windOrientation.image = UIImage(named: "icon_wind_s")
        case "SE" :
            windOrientation.image = UIImage(named: "icon_wind_se")
        case "W" :
            windOrientation.image = UIImage(named: "icon_wind_w")
        case "WN" :
            windOrientation.image = UIImage(named: "icon_wind_wn")
        case "WS" :
            windOrientation.image = UIImage(named: "icon_wind_ws")
        default:
            print("Error")
        }
        
        let iconNumber = model.day.icon
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

// MARK: - HeaderProtocol impl

extension Header: HeaderProtocol {
    func updateWeather(with models: [HourlyWeatherDto]) {
        hourlyWeatherModels = models
        DispatchQueue.main.async {
            self.hourlyCollectionView.reloadData()
        }
    }
    
    func updateHeaderLocation(with model: LocationResponse) {
        DispatchQueue.main.async {
            self.locationLable.text = model.localizedName
        }
    }
    
    func updateHeaderData(with model: DailyForecastDto) {
        UIView.transition(with: self,
                          duration: CATransaction.animationDuration(),
                          options: .transitionCrossDissolve) {
            self.innerUpdateHeaderData(with: model)
        }
    }
}

// MARK: - UICollectionViewDataSource impl

extension Header: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeatherModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hourlyCollectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as? HourlyCollectionViewCell
        (hourlyWeatherModels?[indexPath.item]).map { cell?.setupCell(model: $0) }
        precondition(cell != nil, "cell must be not nil")
        return cell ?? .init(frame: .zero)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}


