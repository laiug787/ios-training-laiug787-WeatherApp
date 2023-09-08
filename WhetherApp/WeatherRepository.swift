//
//  WeatherManager.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/06.
//

import YumemiWeather

protocol WeatherRepositoryProtocol {
    func fetchWeatherCondition()
}

struct WeatherRepository: WeatherRepositoryProtocol {
    weak var delegate: WeatherViewDelegate?
    
    func fetchWeatherCondition() {
        guard let weather = WeatherCondition(rawValue: YumemiWeather.fetchWeatherCondition()) else {
            fatalError("Fail to convert String to WeatherCondition")
        }
        delegate?.reloadButtonTapped(weather)
    }
    
    func close() {
        delegate?.closeButtonTapped()
    }
}
