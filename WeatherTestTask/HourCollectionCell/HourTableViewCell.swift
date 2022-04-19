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
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        
//        // Configure the view for the selected state
//    }
    static let identifire = "HourTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "HourTableViewCell", bundle: nil)
    }
}
