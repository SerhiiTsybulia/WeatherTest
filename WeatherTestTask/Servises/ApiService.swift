//
//  ApiService.swift
//  WeatherTestTask
//
//  Created by Igor Skorina on 27.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import Foundation
import CoreLocation

protocol ApiServiceProtocol {
    func requestDailyWeather(at location: CLLocationCoordinate2D, completionHandler: @escaping (Result<DailyWeatherDto, Error>) -> Void)
    
}

// MARK: - ApiService

final class ApiService {
    static var shared: ApiServiceProtocol = ApiServiceMoc() //ApiService()
    private let apiKey = "uv8oBUByFjYbAAdn4XDHstOht7Z00jVB"
    
    // MARK: - LocationKey request
    
    private func requestLocationKey(location: CLLocationCoordinate2D, completionHandler: @escaping (Result<String, Error>) -> Void) {
        let lon = location.longitude
        let lat = location.latitude
        let url = "https://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=\(apiKey)&q=\(lat)%2C%20\(lon)"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            //Validation
            guard let data = data, error == nil else {
                completionHandler(.failure(error ?? MyError()))
                return
            }
            
            do {
                let json = try JSONDecoder().decode(LocationResponse.self, from: data)
                completionHandler(.success(json.key))
            }
            catch {
                completionHandler(.failure(error))
            }
        }).resume()
    }
    
    // MARK: - DailyWeather request
    
    private func requestDailyWeather(locationKey: String, completionHandler: @escaping (Result<DailyWeatherDto, Error>) -> Void) {
        let url = "https://dataservice.accuweather.com/forecasts/v1/daily/1day/\(locationKey)?apikey=\(apiKey)&details=true&metric=true"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            //Validation
            guard let data = data, error == nil else {
                completionHandler(.failure(error ?? MyError()))
                return
            }
            
            do {
                let weatherDto = try JSONDecoder().decode(DailyWeatherDto.self, from: data)
                completionHandler(.success(weatherDto))
            }
            catch {
                completionHandler(.failure(error))
            }
        }).resume()
    }
}

// MARK: - ApiServiceProtocol impl

extension ApiService: ApiServiceProtocol {
    
    func requestDailyWeather(at location: CLLocationCoordinate2D, completionHandler: @escaping (Result<DailyWeatherDto, Error>) -> Void) {
        requestLocationKey(location: location, completionHandler: { result in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let key):
                self.requestDailyWeather(locationKey: key, completionHandler: { result in
                    switch result {
                    case .failure(let error):
                        completionHandler(.failure(error))
                    case .success(let weather):
                        completionHandler(.success(weather))
                    }
                })
            }
        })
    }
}

struct MyError: Error {
    
}
