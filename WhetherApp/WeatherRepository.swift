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
        do {
            let request = WeatherRequestData(area: "Tokyo", date: .now)
            let weatherDataString = try YumemiWeather.fetchWeather(request.encodeToString())
            guard let jsonData = weatherDataString.data(using: .utf8) else {
                fatalError("Fail to convert String to Data")
            }
            let weatherData = try decodeWeatherData(jsonData)
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
