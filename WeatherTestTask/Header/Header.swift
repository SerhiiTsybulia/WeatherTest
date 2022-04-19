//
//  Header.swift
//  WeatherTestTask
//
//  Created by Сергей on 18.04.2022.
//

import UIKit

class Header: UIView {
    static func create() -> Header? {
        UINib(nibName: "Header", bundle: .main).instantiate(withOwner: nil, options: nil).first as? Header
    }
    
    // MARK: - Outlets
    
    
}
