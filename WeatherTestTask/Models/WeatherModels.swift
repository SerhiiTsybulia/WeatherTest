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
// MARK: - Daily weather model

struct DailyWeatherDto: Codable {
    let temperature: [TempType: Temperature]
    let day: DayDto
    
    enum CodingKeys: String, CodingKey {
        case temperature = "Temperature"
        case day = "Day"
    }
}

enum TempType: String, Codable {
    case Minimum
    case Maximum
}

struct Temperature: Codable {
    let value: Double
    let unit: String
    let unitType: Int
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}

struct DayDto: Codable{
    let wind: WindDto
    
    enum CodingKeys: String, CodingKey {
        case wind = "Wind"
    }
}

struct WindDto: Codable{
    let speed: SpeedDto
    let direction: DirectionDto
    
    enum CodingKeys: String, CodingKey {
        case speed = "Speed"
        case direction = "Direction"
    }
}

struct SpeedDto: Codable{
    let value: Double
    let unit: String
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
    }
}

struct DirectionDto: Codable{
    let localized: String
    
    enum CodingKeys: String, CodingKey {
        case localized = "Localized"
    }
}

// MARK: - Weather for 5 days model

struct For5DaysWeatherDto: Codable{
    let date: String
    let temperature: [TempType: Temperature]
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case temperature = "Temperature"
    }
}

// MARK: - Hourly weather model

struct HourlyWeatherDto: Codable{
    let dateTime: String
    let temperature: Temperature
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
        case temperature = "Temperature"
    }
}

class HourlyWeather{
    var hourlyWeather = [HourlyWeatherDto]()
    init(){
        setup()
    }
    func setup(){
        let h1 = HourlyWeatherDto(dateTime: "11:00", temperature: Temperature(value: 11.4, unit: "C", unitType: 17))
        let h2 = HourlyWeatherDto(dateTime: "12:00", temperature: Temperature(value: 12.4, unit: "C", unitType: 17))
        let h3 = HourlyWeatherDto(dateTime: "13:00", temperature: Temperature(value: 13.4, unit: "C", unitType: 17))
        let h4 = HourlyWeatherDto(dateTime: "14:00", temperature: Temperature(value: 14.4, unit: "C", unitType: 17))
        let h5 = HourlyWeatherDto(dateTime: "15:00", temperature: Temperature(value: 15.4, unit: "C", unitType: 17))
        self.hourlyWeather = [h1, h2, h3, h4, h5]
    }
}
