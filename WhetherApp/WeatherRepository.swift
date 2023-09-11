//
//  WeatherManager.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/06.
//

import Foundation
import YumemiWeather

protocol WeatherRepositoryProtocol: AnyObject {
    var delegate: WeatherRepositoryDelegate? { get set }
    
    func fetchWeatherCondition()
}

class WeatherRepository: WeatherRepositoryProtocol {
    weak var delegate: WeatherRepositoryDelegate?
    
    let jsonString = """
        {
            "area": "tokyo",
            "date": "2020-04-01T12:00:00+09:00"
        }
        """
    
    func fetchWeatherCondition() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let weatherDataString = try YumemiWeather.fetchWeather(jsonString)
            guard let jsonData = weatherDataString.data(using: .utf8) else {
                fatalError("Fail to convert String to Data")
            }
            let weatherData = try decoder.decode(WeatherData.self, from: jsonData)
            delegate?.weatherRepository(self, didFetchWeatherData: weatherData)
        } catch {
            delegate?.weatherRepository(self, didFailWithError: WeatherError(error))
        }
    }
}
