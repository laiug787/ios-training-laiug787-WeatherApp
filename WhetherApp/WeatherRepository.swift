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
            let weatherRequestData = WeatherRequestData(area: "Tokyo", date: .now)
            let weatherRequestDataString = try encodeWeatherRequestData(weatherRequestData)
            let weatherDataString = try YumemiWeather.fetchWeather(weatherRequestDataString)
            let weatherData = try decodeWeatherData(weatherDataString)
            delegate?.weatherRepository(self, didFetchWeatherData: weatherData)
        } catch {
            delegate?.weatherRepository(self, didFailWithError: WeatherError(error))
        }
    }
    
    private func encodeWeatherRequestData(_ data: WeatherRequestData) throws -> String {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let jsonData = try encoder.encode(data)
        let string = String(decoding: jsonData, as: UTF8.self)
        return string
    }
    
    private func decodeWeatherData(_ string: String) throws -> WeatherData {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let data = Data(string.utf8)
        return try decoder.decode(WeatherData.self, from: data)
    }
}
