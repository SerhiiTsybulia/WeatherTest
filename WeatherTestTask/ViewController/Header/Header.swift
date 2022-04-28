//
//  Header.swift
//  WeatherTestTask
//
//  Created by Сергей on 18.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit

class Header: UIView{
    
    var positionClickHandler: (() -> Void)?
    var searchClickHandler: (() -> Void)?
    
    
    var modelsForCollection: HourlyWeather = HourlyWeather()
    
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    @IBAction func locationClicked() { positionClickHandler?()}
    @IBAction func searchClicked() { searchClickHandler?()}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hourlyCollectionView.register(UINib(nibName: "HourlyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HourlyCollectionViewCell")
        hourlyCollectionView.dataSource = self
        hourlyCollectionView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        
    }
    
    static func create() -> Header? {
        UINib(nibName: "Header", bundle: .main).instantiate(withOwner: nil, options: nil).first as? Header
    }
    
}
extension Header: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelsForCollection.hourlyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hourlyCollectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCollectionViewCell", for: indexPath) as! HourlyCollectionViewCell
        
        let hourlyWeath = modelsForCollection.hourlyWeather[indexPath.item]
        cell.setupCell(model: hourlyWeath)
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
}
