//
//  WeatherManager.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/06.
//

import YumemiWeather

protocol WeatherRepositoryProtocol: AnyObject {
    var delegate: WeatherRepositoryDelegate? { get set }
    
    func fetchWeatherCondition() -> WeatherCondition
}

class WeatherRepository: WeatherRepositoryProtocol {
    var delegate: WeatherRepositoryDelegate?
    
    func fetchWeatherCondition() -> WeatherCondition {
        guard let weather = WeatherCondition(rawValue: YumemiWeather.fetchWeatherCondition()) else {
            fatalError("Fail to convert String to WeatherCondition")
        }
        return weather
    }
}
