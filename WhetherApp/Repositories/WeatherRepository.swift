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
    
    func fetchWeatherCondition(area: String, date: Date)
}

class WeatherRepository: WeatherRepositoryProtocol {
    weak var delegate: WeatherRepositoryDelegate?
    
    func fetchWeatherCondition(area: String, date: Date) {
        do {
            let WeatherRequestString = try encode(WeatherRequestParameter(area: area, date: date))
            let weatherDataString = try YumemiWeather.fetchWeather(WeatherRequestString)
            let weatherData = try decode(weatherDataString: weatherDataString)
            delegate?.weatherRepository(self, didFetchWeatherData: weatherData)
        } catch {
            delegate?.weatherRepository(self, didFailWithError: WeatherError(error))
        }
    }
    
    private func encode(_ data: WeatherRequestParameter) throws -> String {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let jsonData = try encoder.encode(data)
        guard let string = String(data: jsonData, encoding: .utf8) else {
            fatalError("Fail to convert Data to String")
        }
        return string
    }
    
    private func decode(weatherDataString string: String) throws -> WeatherData {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = string.data(using: .utf8) else {
            fatalError("Fail to convert String to Data")
        }
        return try decoder.decode(WeatherData.self, from: data)
    }
}
