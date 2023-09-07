//
//  WeatherManager.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/06.
//

import YumemiWeather

final class WeatherRepository {
    
    static var instance = WeatherRepository()
    
    private let yumemiWeather = YumemiWeather.self
    
    private init() {
        
    }
    
    func fetchWeatherCondition() -> WeatherType {
        guard let weather = WeatherType(rawValue: yumemiWeather.fetchWeatherCondition()) else {
            fatalError("Fail to convert String to WeatherType")
        }
        return weather
    }
}
