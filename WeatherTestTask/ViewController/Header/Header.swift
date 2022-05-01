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
    func updateWeather(with model: Instruction)
}

class Header: UIView {
    
    static func create() -> Header? {
        UINib(nibName: "Header", bundle: .main).instantiate(withOwner: nil, options: nil).first as? Header
    }
    
    var positionClickHandler: (() -> Void)?
    var searchClickHandler: (() -> Void)?
    
//    var modelsForCollection: HourlyWeatherDto = HourlyWeather() //FOR TESTING
    
    private var dailyWeatherModel: For5DaysWeatherDto?
    private var hourlyWeatherList: HourlyWeather?
    private var hourlyWeatherModel: Instruction?
    
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    @IBAction func locationClicked() { positionClickHandler?() }
    @IBAction func searchClicked() { searchClickHandler?() }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    private func commonInit(){
        initCollectionView()
    }
    
    private func initCollectionView() {
        hourlyCollectionView.register( HourlyCollectionViewCell.nib,
                                       forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        hourlyCollectionView.dataSource = self
    }
}

// MARK: - HeaderProtocol impl

extension Header: HeaderProtocol {
    func updateWeather(with model: For5DaysWeatherDto) {
        dailyWeatherModel = model
        // TODO: update UI
    }

    func updateWeather(with model: Instruction) {
        hourlyWeatherModel = model
        hourlyCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource impl

extension Header: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeatherList?.instructions.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hourlyCollectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as! HourlyCollectionViewCell
        
        let hourlyWeath = hourlyWeatherList?.instructions[indexPath.item]
        cell.setupCell(model: hourlyWeatherModel!)
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
