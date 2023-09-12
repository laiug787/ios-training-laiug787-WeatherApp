//
//  WeatherError.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/12.
//

import Foundation
import YumemiWeather

enum WeatherError: Error {
    case invalidParameterError
    case invalidResponse
    case unknownError
    
    init(_ error: Error) {
        guard let weatherError = error as? YumemiWeatherError else {
            self = .invalidResponse
            return
        }
        
        switch weatherError {
        case .invalidParameterError:
            self = .invalidParameterError
        case .unknownError:
            self = .unknownError
        }
    }
}

extension WeatherError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidParameterError:
            return "Invalid parameter error"
        case .invalidResponse:
            return "Invalid response"
        case .unknownError:
            return "Unknown error"
        }
    }
}
