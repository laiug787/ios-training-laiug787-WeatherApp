//
//  WeatherManager.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/06.
//

import YumemiWeather

final class WeatherRepository {
    
    static var instance = WeatherRepository()
    
    private let request = YumemiWeather.self
    
    private init() {
        
    }
    
    func fetchWeatherCondition() -> WeatherType {
        guard let weather = WeatherType(rawValue: request.fetchWeatherCondition()) else {
            fatalError("Fail to convert String to WeatherType")
        }
        return weather
    }
}
