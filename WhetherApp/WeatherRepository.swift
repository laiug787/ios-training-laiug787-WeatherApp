//
//  WeatherManager.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/06.
//

import YumemiWeather

protocol WeatherRepositoryProtocol: AnyObject {
    var delegate: WeatherRepositoryDelegate? { get set }
    
    func fetchWeatherCondition()
}

class WeatherRepository: WeatherRepositoryProtocol {
    weak var delegate: WeatherRepositoryDelegate?
    
    func fetchWeatherCondition() {
        do {
            let weatherString = try YumemiWeather.fetchWeatherCondition(at: "Tokyo")
            guard let weather = WeatherCondition(rawValue: weatherString) else {
                fatalError("Fail to convert String to WeatherCondition")
            }
            delegate?.weatherRepository(self, didFetchWeatherCondition: weather)
        } catch {
            delegate?.weatherRepository(self, didFailWithError: WeatherError(error))
        }
    }
}
