//
//  Header.swift
//  WeatherTestTask
//
//  Created by Сергей on 18.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit

class Header: UIView, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var positionClickHandler: (() -> Void)?
    var searchClickHandler: (() -> Void)?
    
    @IBOutlet weak var forecastView: UIView!
    @IBAction func locationClicked() { positionClickHandler?()}
    @IBAction func searchClicked() { searchClickHandler?()}
    
    private let weatherCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 90/255.0, green: 159/255.0, blue: 240/255.0, alpha: 1.0)
        collectionView.register(HourCollectionViewCell.self, forCellWithReuseIdentifier: HourCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(weatherCollectionView)
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
//        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourCollectionViewCell.identifier,
                                                            for: indexPath) as? HourCollectionViewCell else { fatalError()
        }
        return cell
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            weatherCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            weatherCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            weatherCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
    
    static func create() -> Header? {
        UINib(nibName: "Header", bundle: .main).instantiate(withOwner: nil, options: nil).first as? Header
    }
    
}
