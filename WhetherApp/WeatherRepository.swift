//
//  WeatherManager.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/06.
//

import YumemiWeather

protocol WeatherRepositoryProtocol {
    func fetchWeatherCondition() -> WeatherType
}

struct WeatherRepository: WeatherRepositoryProtocol {
    func fetchWeatherCondition() -> WeatherType {
        guard let weather = WeatherType(rawValue: YumemiWeather.fetchWeatherCondition()) else {
            fatalError("Fail to convert String to WeatherType")
        }
        return weather
    }
}
