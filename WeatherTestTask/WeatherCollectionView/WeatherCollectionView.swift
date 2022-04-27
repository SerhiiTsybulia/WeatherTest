////
////  WeatherCollectionView.swift
////  WeatherTestTask
////
////  Created by Сергей on 25.04.2022.
////  Copyright © 2022 STDevelopment. All rights reserved.
////
//
//import UIKit
//
//class WeatherCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    static let identifier = "WeatherCollectionView"
//    
//    let cells = ["cell1","cell2","cell3","cell4","cell5","cell6","cell7","cell8",
//                 "cell9","cell10","cell11","cell12"]
//    
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return cells.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = dequeueReusableCell(withReuseIdentifier: HourCollectionViewCell.identifier, for: indexPath)
//        return cell
//    }
//    
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
