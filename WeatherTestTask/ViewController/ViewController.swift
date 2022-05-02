//
//  ViewController.swift
//  WeatherTestTask
//
//  Created by Сергей on 18.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    private lazy var apiService = ApiService.shared
    
    @IBOutlet var table: UITableView!
    
    private lazy var header: Header? = {
        let header = Header.create()
        header?.positionClickHandler = { [weak self] in
            self?.locationButtonClicked()
        }
        header?.searchClickHandler = { [weak self] in
            self?.searchButtonClicked()
        }
        return header
    }()
    
//    var dummyModels = [
//        "cel 0",
//        "cel 1",
//        "cel 2",
//        "cel 3",
//        "cel 4",
//        "cel 5"
//    ]
    private var dailyWeatherList: [For5DaysWeatherDto]?
    private var dailyWeatherModel: [DailyForecast]?
    private let locationManger = CLLocationManager()
    private var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Regeister cells
        
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifire)
        table.delegate = self
        table.dataSource = self
        
        table.allowsSelection = true
        table.allowsMultipleSelection = false
        
        table.backgroundColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)
        view.backgroundColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)
        table.separatorColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func locationButtonClicked() {
        let mainViewController = LocationViewController()
        mainViewController.locationPicked = { [weak self] newLocation in
            self?.locationPicked(location: newLocation)
        }
        navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    private func searchButtonClicked() {
        let mainViewController = SearchViewController()
        navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    
    private func locationPicked(location: CLLocationCoordinate2D) {
        updateWeather(with: location)
    }
    
    private func updateWeather(with location: CLLocationCoordinate2D) {
        
        apiService.requestHourlyWeather(at: location, completionHandler: { [weak self] response in
            switch response {
            case .failure(let error):
                print("Get hourly weather failure: \(error)")
            case .success(let hourlyWeather):
                self?.updateWeather(with: hourlyWeather)
            }
        })
        
        apiService.requestWeatherFor5Days(at: location, completionHandler: { [weak self] response in
            switch response {
            case .failure(let error):
                print("Get daily weather failure: \(error)")
            case .success(let weatherFor5Days):
                self?.updateWeather(with: weatherFor5Days)
            }
        })
    }
    
    private func updateWeather(with models: [HourlyWeatherDto]) {
        header?.updateWeather(with: models)
    }
    
    private func updateWeather(with model: For5DaysWeatherDto) {
        DispatchQueue.main.async {
            self.table.reloadData()
        }
    }
    
    // MARK: - Location impl
    
    func setupLocation() {
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
    }
}
// MARK: - UITableViewDataSource impl

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyWeatherList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifire, for: indexPath) as? WeatherTableViewCell
        (dailyWeatherModel?[indexPath.item]).map {
            cell?.setupCell5Days(model: $0)}
        precondition(cell != nil, "cell must be not nil")

        if ((cell?.isSelected) != nil) {
           // UPDATE HEADER PART
        }
        return cell ?? .init(frame: .zero)
    }
}


// MARK: - UITableViewDelegate impl

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        nil
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        400
    }
    func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat{
        70
    }
}

// MARK: - CLLocationManagerDelegate impl

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.first, currentLocation == nil {
            currentLocation = newLocation
            updateWeather(with: newLocation.coordinate)
        }
    }
}
