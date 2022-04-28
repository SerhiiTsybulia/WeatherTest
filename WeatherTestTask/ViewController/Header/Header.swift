//
//  Header.swift
//  WeatherTestTask
//
//  Created by Сергей on 18.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit

@IBDesignable
class Header: UIView {
    
    static func create() -> Header? {
        UINib(nibName: "Header", bundle: .main).instantiate(withOwner: nil, options: nil).first as? Header
    }
    
    var positionClickHandler: (() -> Void)?
    var searchClickHandler: (() -> Void)?
    
    var modelsForCollection: HourlyWeather = HourlyWeather()
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    @IBAction func locationClicked() { positionClickHandler?() }
    @IBAction func searchClicked() { searchClickHandler?() }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    private func commonInit(){
        initCollectionView()
    }
    
    private func initCollectionView() {
        hourlyCollectionView.register( HourlyCollectionViewCell.nib,
                                       forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        hourlyCollectionView.dataSource = self
    }
}

extension Header: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelsForCollection.hourlyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = hourlyCollectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as! HourlyCollectionViewCell
        
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
