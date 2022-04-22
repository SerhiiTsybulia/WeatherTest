//
//  Header.swift
//  WeatherTestTask
//
//  Created by Сергей on 18.04.2022.
//

import UIKit

class Header: UIView {
    
    var positionClickHandler: (() -> Void)?
    var searchClickHandler: (() -> Void)?

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
  
    
}
