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
    func requestWeatherFor5Days(at location: CLLocationCoordinate2D, completionHandler: @escaping (Result<For5DaysWeatherDto, Error>) -> Void)
    func requestHourlyWeather(at location: CLLocationCoordinate2D, completionHandler: @escaping (Result<HourlyWeatherDto, Error>) -> Void)
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
                let dailyWeatherDto = try JSONDecoder().decode(DailyWeatherDto.self, from: data)
                completionHandler(.success(dailyWeatherDto))
            }
            catch {
                completionHandler(.failure(error))
            }
        }).resume()
    }
    // MARK: - For5days request
    
    private func requestWeatherFor5Days(locationKey: String, completionHandler: @escaping (Result<For5DaysWeatherDto, Error>) -> Void) {
        let url = "https://dataservice.accuweather.com/forecasts/v1/daily/5day/\(locationKey)?apikey=\(apiKey)&details=true&metric=true"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            //Validation
            guard let data = data, error == nil else {
                completionHandler(.failure(error ?? MyError()))
                return
            }
            do {
                let fiveDaysWeatherDto = try JSONDecoder().decode(For5DaysWeatherDto.self, from: data)
                completionHandler(.success(fiveDaysWeatherDto))
            }
            catch {
                completionHandler(.failure(error))
            }
        }).resume()
    }
    // MARK: - HourlyWeather request
    
    private func requestHourlyWeather(locationKey: String, completionHandler: @escaping (Result<HourlyWeatherDto, Error>) -> Void) {
        let url = "https://dataservice.accuweather.com/forecasts/v1/hourly/12hour/\(locationKey)?apikey=\(apiKey)&details=true&metric=true"
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            //Validation
            guard let data = data, error == nil else {
                completionHandler(.failure(error ?? MyError()))
                return
            }
            do {
                let hourlyWeatherDto = try JSONDecoder().decode(HourlyWeatherDto.self, from: data)
                completionHandler(.success(hourlyWeatherDto))
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
    func requestWeatherFor5Days(at location: CLLocationCoordinate2D, completionHandler: @escaping (Result<For5DaysWeatherDto, Error>) -> Void) {
        requestLocationKey(location: location, completionHandler: { result in
        switch result {
        case .failure(let error):
            completionHandler(.failure(error))
        case .success(let key):
            self.requestWeatherFor5Days(locationKey: key, completionHandler: { result in
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
        
    func requestHourlyWeather(at location: CLLocationCoordinate2D, completionHandler: @escaping (Result<HourlyWeatherDto, Error>) -> Void){
        requestLocationKey(location: location, completionHandler: { result in
        switch result {
        case .failure(let error):
            completionHandler(.failure(error))
        case .success(let key):
            self.requestHourlyWeather(locationKey: key, completionHandler: { result in
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
