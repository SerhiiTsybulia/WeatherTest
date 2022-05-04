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
    
    func updateWeather(with model: For5DaysWeatherDto)
    func updateWeather(with models: [HourlyWeatherDto])
}

class Header: UIView {
    
    static func create() -> Header? {
        UINib(nibName: "Header", bundle: .main).instantiate(withOwner: nil, options: nil).first as? Header
    }
    
    var positionClickHandler: (() -> Void)?
    var searchClickHandler: (() -> Void)?
    
    private var dailyWeatherModel: For5DaysWeatherDto?
    private var hourlyWeatherModels: [HourlyWeatherDto]?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    
    @IBAction func locationClicked() { positionClickHandler?() }
    @IBAction func searchClicked() { searchClickHandler?() }
    @IBOutlet weak var locationLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var temperatureLable: UILabel!
    @IBOutlet weak var speedOfWind: UILabel!
    @IBOutlet weak var windOrientation: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    private func commonInit(){
        initCollectionView()
    }
    
    private func initCollectionView() {
        hourlyCollectionView.register( HourlyCollectionViewCell.nib, forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        hourlyCollectionView.dataSource = self
    }
}

// MARK: - HeaderProtocol impl

extension Header: HeaderProtocol {
    func updateWeather(with model: For5DaysWeatherDto) {
        dailyWeatherModel = model
    }
    
    func updateWeather(with models: [HourlyWeatherDto]) {
        hourlyWeatherModels = models
        DispatchQueue.main.async {
            self.hourlyCollectionView.reloadData()
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
