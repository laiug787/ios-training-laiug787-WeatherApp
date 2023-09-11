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
    
    func fetchWeatherCondition() {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
<<<<<<< HEAD
            let weatherDataString = try YumemiWeather.fetchWeather(jsonString)
            guard let jsonData = weatherDataString.data(using: .utf8) else {
                fatalError("Fail to convert String to Data")
            }
            let weatherData = try decodeWeatherData(jsonData)
=======
            let request = WeatherRequest(area: "Tokyo", date: .now)
            let weatherDataString = try YumemiWeather.fetchWeather(request.encodeToString())
            let weatherData = try WeatherDecoder.decodeWeatherData(weatherDataString)
>>>>>>> 859bfa1 (add: WeatherRequest)
            delegate?.weatherRepository(self, didFetchWeatherData: weatherData)
        } catch {
            delegate?.weatherRepository(self, didFailWithError: WeatherError(error))
        }
    }
    
    private func decodeWeatherData(_ data: Data) throws -> WeatherData {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(WeatherData.self, from: data)
    }
}
