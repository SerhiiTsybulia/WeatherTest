//
//  ApiServiceMoc.swift
//  WeatherTestTask
//
//  Created by Igor Skorina on 27.04.2022.
//  Copyright © 2022 STDevelopment. All rights reserved.
//

import Foundation
import CoreLocation

final class ApiServiceMoc {
    
}

extension ApiServiceMoc: ApiServiceProtocol {
    func requestDailyWeather(at location: CLLocationCoordinate2D, completionHandler: @escaping (Result<DailyWeatherDto, Error>) -> Void) {
        completionHandler(.failure(MyError()))
    }
}
