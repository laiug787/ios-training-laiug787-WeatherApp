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
            let WeatherRequestParameter = WeatherRequestParameter(area: area, date: date)
            let WeatherRequestParameterString = try encodeWeatherRequestData(WeatherRequestParameter)
            let weatherDataString = try YumemiWeather.fetchWeather(WeatherRequestParameterString)
            let weatherData = try decodeWeatherData(weatherDataString)
            delegate?.weatherRepository(self, didFetchWeatherData: weatherData)
        } catch {
            delegate?.weatherRepository(self, didFailWithError: WeatherError(error))
        }
    }
    
    private func encodeWeatherRequestData(_ data: WeatherRequestParameter) throws -> String {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let jsonData = try encoder.encode(data)
        return String(decoding: jsonData, as: UTF8.self)
    }
    
    private func decodeWeatherData(_ string: String) throws -> WeatherData {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let data = Data(string.utf8)
        return try decoder.decode(WeatherData.self, from: data)
    }
}
