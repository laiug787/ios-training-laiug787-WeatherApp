//
//  WeatherError.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/12.
//

import Foundation
import YumemiWeather

enum WeatherError: Error {
    case invalidParameter
    case invalidResponse
    case unknown
    
    init(_ error: Error) {
        guard let weatherError = error as? YumemiWeatherError else {
            self = .invalidResponse
            return
        }
        
        switch weatherError {
        case .invalidParameterError:
            self = .invalidParameter
        case .unknownError:
            self = .unknown
        }
    }
}

extension WeatherError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidParameter:
            return "Invalid parameter"
        case .invalidResponse:
            return "Invalid response"
        case .unknown:
            return "Unknown error"
        }
    }
}
