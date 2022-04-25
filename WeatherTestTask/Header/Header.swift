//
//  Header.swift
//  WeatherTestTask
//
//  Created by Сергей on 18.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit

class Header: UIView {
    
    var positionClickHandler: (() -> Void)?
    var searchClickHandler: (() -> Void)?

    @IBOutlet weak var hourTable: HourCollectionViewCell!
    @IBAction func locationClicked() {
        print("BAM")
        positionClickHandler?()
    }
    @IBAction func searchClicked() {
        print("Search BAM")
        searchClickHandler?()
    }
    
    static func create() -> Header? {
        UINib(nibName: "Header", bundle: .main).instantiate(withOwner: nil, options: nil).first as? Header
    }
    // MARK: - Regeister HourCollectionViewCell
    
    let cellRegistration = UICollectionView.CellRegistration
    
    
    
//hourTable.register(HourCollectionViewCell.nib(), forCellReuseIdentifier: HourCollectionViewCell.identifire)
//
//hourTable.delegate = self
//hourTable.dataSource = self
//
//    hourTable.reg
//
}
