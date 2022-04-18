//
//  ViewController.swift
//  WeatherTestTask
//
//  Created by Сергей on 18.04.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet var tabel: UITableView!
    
    var models = [Weather]()
    
    let locationManger = CLLocationManager()
    
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabel.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifire)
        tabel.register(HourTableViewCell.nib(), forCellReuseIdentifier: HourTableViewCell.identifire)
        
        tabel.delegate = self
        tabel.dataSource = self
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
    
    //Creating Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

struct Weather{
    
}
