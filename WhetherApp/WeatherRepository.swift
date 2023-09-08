//
//  WeatherManager.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/06.
//

import YumemiWeather

protocol WeatherRepositoryProtocol {
    func fetchWeatherCondition()
    var delegate: WeatherRepositoryDelegate? { get set }
    
}

class WeatherRepository: WeatherRepositoryProtocol {
    var delegate: WeatherRepositoryDelegate?
    
    func fetchWeatherCondition() {
        guard let weather = WeatherCondition(rawValue: YumemiWeather.fetchWeatherCondition()) else {
            fatalError("Fail to convert String to WeatherCondition")
        }
        delegate?.reloadButtonTapped(weather)
    }
}
