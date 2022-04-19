//
//  ViewController.swift
//  WeatherTestTask
//
//  Created by Сергей on 18.04.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var tabel: UITableView!
    
    var models = [Weather]()
    var dummyModels = [
        "cel 0",
        "cel 1",
        "cel 2",
        "cel 3",
        "cel 4",
        "cel 5",
        "cel 6",
        "cel 7",
        "cel 8",
        "cel 9",
        "cel 10",
        "cel 11",
        "cel 12",
        "cel 13",
        "cel 14",
        "cel 15",
        "cel 16",
        "cel 17",
        "cel 18",
        "cel 19",
        "cel 20",
        "cel 21",
        "cel 22",
        "cel 23",
        "cel 24",
        "cel 25",
        "cel 26",
        "cel 27",
        "cel 28",
        "cel 29"
    ]
    
    let locationManger = CLLocationManager()
    
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register cells
        
        tabel.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifire)
        tabel.register(HourTableViewCell.nib(), forCellReuseIdentifier: HourTableViewCell.identifire)
        
        tabel.delegate = self
        tabel.dataSource = self
        
        tabel.allowsSelection = true
        tabel.allowsMultipleSelection = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    //Creating Location
    
    func setupLocation(){
        locationManger.delegate = self
        locationManger.requestWhenInUseAuthorization()
        locationManger.startUpdatingLocation()
    }
    func locationManager(_ manger: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManger.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation(){
        guard let currentLocation = currentLocation else {
            return
        }
        
        let lon = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
//        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=97860de1eff6c5147d0d3a45ea871487"
        
        print("\(lon) | \(lat)")
    }
}

// MARK: - UITableViewDataSource impl

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return models.count
        dummyModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let curModel = dummyModels[indexPath.row]
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifire, for: indexPath)
            cell.textLabel?.text = curModel
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HourTableViewCell.identifire, for: indexPath)
            cell.textLabel?.text = curModel
            return cell
        }
    }
}

// MARK: - UITableViewDelegate impl

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(" --- CLICK ---")
    }
    
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        "Фуутер"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        Header.create()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        200
    }
}

struct Weather{
    
}
