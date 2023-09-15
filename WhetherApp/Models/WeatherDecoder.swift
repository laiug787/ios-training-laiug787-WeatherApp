//
//  WeatherDecoder.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/11.
//

import Foundation

struct WeatherDecoder {
    static func decodeWeatherData(_ jsonString: String) throws -> WeatherData {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Fail to convert String to Data")
        }
        
        return try decoder.decode(WeatherData.self, from: jsonData)
    }
}
