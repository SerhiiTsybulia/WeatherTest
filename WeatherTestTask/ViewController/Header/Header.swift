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
    

    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    @IBAction func locationClicked() { positionClickHandler?()}
    @IBAction func searchClicked() { searchClickHandler?()}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hourlyCollectionView.register(UINib(nibName: "HourlyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HourlyCollectionViewCell")
        hourlyCollectionView.dataSource = self
        hourlyCollectionView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func create() -> Header? {
        UINib(nibName: "Header", bundle: .main).instantiate(withOwner: nil, options: nil).first as? Header
    }
    
}
extension Header: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        .init(frame: .zero)
    }
}
