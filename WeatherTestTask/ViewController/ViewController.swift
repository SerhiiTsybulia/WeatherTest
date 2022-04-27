//
//  ViewController.swift
//  WeatherTestTask
//
//  Created by Сергей on 18.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
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
    
    
    //    var locationKey: LocationResponse?
    
    var dummyModels = [
        "cel 0",
        "cel 1",
        "cel 2",
        "cel 3",
        "cel 4",
        "cel 5"
    ]
    
    let locationManger = CLLocationManager()
    
    var currentLocation: CLLocation?
    
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
        let mainViewController = ViewController()
        navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    private func updateWeather(with location: CLLocationCoordinate2D) {
        apiService.requestDailyWeather(at: location, completionHandler: { [weak self] response in
            switch response {
            case .failure(let error):
                print("Get daily weather failure: \(error)")
            case .success(let dailyWeather):
                self?.updateWeather(with: dailyWeather)
            }
        })
    }
    
    private func updateWeather(with model: DailyWeatherDto) {
        // TODO: update UI
        preconditionFailure("!!! UPDATE UI !!!")
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
        //        return models.count
        dummyModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let curModel = dummyModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifire, for: indexPath)
        if cell.isSelected {
            
        }
        //            cell.textLabel?.text = curModel
        return cell
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
