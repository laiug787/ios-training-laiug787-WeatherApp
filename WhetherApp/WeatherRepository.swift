//
//  WeatherManager.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/06.
//

import YumemiWeather

protocol WeatherRepositoryProtocol {
    func fetchWeatherCondition() -> WeatherCondition
}

struct WeatherRepository: WeatherRepositoryProtocol {
    func fetchWeatherCondition() -> WeatherCondition {
        guard let weather = WeatherCondition(rawValue: YumemiWeather.fetchWeatherCondition()) else {
            fatalError("Fail to convert String to WeatherCondition")
        }
        return weather
    }
}
