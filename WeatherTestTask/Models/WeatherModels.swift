//
//  HourlyWeatherModel.swift
//  WeatherTestTask
//
//  Created by Igor Skorina on 27.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Location model

struct LocationResponse: Codable{
    let key: String
    let localizedName: String
    let country: Country
    let geoPosition: GeoPosition
    
    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case localizedName = "LocalizedName"
        case country = "Country"
        case geoPosition = "GeoPosition"
    }
}

struct Country: Codable{
    let id: String
    let localizedName: String
    let englishName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}

struct GeoPosition: Codable {
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
}

// MARK: - Weather for 5 days model

struct For5DaysWeatherDto: Codable {

    let dailyForecasts: [DailyForecastDto]
    
    enum CodingKeys: String, CodingKey {
        case dailyForecasts = "DailyForecasts"
    }
}

struct DailyForecastDto: Codable {
    let epochDate: Double?
    var date: Date? {
        epochDate.map { Date(timeIntervalSince1970: $0) }
    }
    let temperature: TemperatureDto?
    
    enum CodinKeys: String, CodingKey {
        case epochDate = "EpochDate"
        case temperature = "Temperature"
    }
}
struct Day: Codable {
    let icon: Int
    let wind: Wind
    let evapotranspiration: Evapotranspiration
    
    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case wind = "Wind"
        case evapotranspiration = "Evapotranspiration"
    }
}

struct Evapotranspiration: Codable {
    let value: Double
    let unit: Unit
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
    }
}

struct Wind: Codable {
    let speed: Evapotranspiration
    let direction: Direction
    
    enum CodingKeys: String, CodingKey {
        case speed = "Speed"
        case direction = "Direction"
    }
}

struct Direction: Codable {
    let degrees: Int
    let localized, english: String
    
    enum CodingKeys: String, CodingKey {
        case degrees = "Degrees"
        case localized = "Loacalized"
        case english = "English"
    }
}

struct TemperatureDto: Codable {
    let minimum, maximum: Evapotranspiration
    
    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}

// MARK: - Hourly weather model

struct HourlyWeatherDto: Codable {
    
    let dateTime: String
    var date: Date? {
        try? Date(dateTime, strategy: .iso8601)
    }
    let weatherIcon: Int
    let temperature: Temperature
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
        case weatherIcon = "WeatherIcon"
        case temperature = "Temperature"
    }
}

struct Temperature: Codable {
    let value: Double
    let unit: Unit
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
    }
}

enum Unit: String, Codable {
    case c = "C"
    case cm = "cm"
    case km = "km"
    case kmH = "km/h"
    case m = "m"
    case mm = "mm"
    case wM = "W/m²"
}



// MARK: - Hourly weather FOR TESTING
//class HourlyWeather {
//    var hourlyWeather = [HourlyWeatherDto]()
//    init(){
//        setup()
//    }
//    func setup(){
//        let h1 = HourlyWeatherDto(dateTime: "11:00", temperature: Temperature(value: 11.4, unit: "C", unitType: 17))
//        let h2 = HourlyWeatherDto(dateTime: "12:00", temperature: Temperature(value: 12.4, unit: "C", unitType: 17))
//        let h3 = HourlyWeatherDto(dateTime: "13:00", temperature: Temperature(value: 13.4, unit: "C", unitType: 17))
//        let h4 = HourlyWeatherDto(dateTime: "14:00", temperature: Temperature(value: 14.4, unit: "C", unitType: 17))
//        let h5 = HourlyWeatherDto(dateTime: "15:00", temperature: Temperature(value: 15.4, unit: "C", unitType: 17))
//        self.hourlyWeather = [h1, h2, h3, h4, h5]
//    }
//}
