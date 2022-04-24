//
//  HourTableViewCell.swift
//  WeatherTestTask
//
//  Created by Сергей on 18.04.2022.
//

import UIKit

class HourTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static let identifire = "HourTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "HourTableViewCell", bundle: nil)
    }
}
