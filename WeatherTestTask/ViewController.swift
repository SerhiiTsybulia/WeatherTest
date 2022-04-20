//
//  ViewController.swift
//  WeatherTestTask
//
//  Created by Сергей on 18.04.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var table: UITableView!
    
    //    var models = [Weather]()
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
        
        // MARK: - Regeister cells
        
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifire)
        table.register(HourTableViewCell.nib(), forCellReuseIdentifier: HourTableViewCell.identifire)
        
        table.delegate = self
        table.dataSource = self
        
        table.allowsSelection = true
        table.allowsMultipleSelection = false
        
        table.backgroundColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)
        view.backgroundColor = UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    // MARK: - Location impl
    
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
    // MARK: - Weatehr request
    
    func requestWeatherForLocation(){
        guard let currentLocation = currentLocation else {
            return
        }
        
        let lon = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        let apiKey = "uv8oBUByFjYbAAdn4XDHstOht7Z00jVB"
        
        let url = "https://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=\(apiKey)&q=\(lat)%2C%20\(lon)"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            //Validation
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            let stringResponse = String(data: data, encoding: .utf8) ?? "Empty"
            print (stringResponse)
            
            do {
                let json = try JSONDecoder().decode(LocationResponse.self, from: data)
                print (json)
            }
            catch {
                print("error: \(error)")
            }
            
        }).resume()
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        Header.create()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        400
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt: IndexPath) -> CGFloat{
        70
    }
}

struct LocationResponse: Codable{
    let version: Int
    let key: String
    let localizedName: String
    let country: Country
    let geoPosition: GeoPosition
    
    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case version = "Version"
        case localizedName = "LocalizedName"
        case country = "Country"
        case geoPosition = "GeoPosition"
    }
}

struct Country: Codable{
    let id: String
    let localizedName: String
    let englishName: String
}

enum MesuringType: String, Codable {
    case Metric
    case Imperial
}

struct Mesuring: Codable {
    let value: Double
    let unit: String
    let unitType: Int
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}

struct GeoPosition: Codable {
    let latitude: Double
    let longitude: Double
    let elevation: [MesuringType: Mesuring]
    
    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case elevation = "Elevation"
    }
}
