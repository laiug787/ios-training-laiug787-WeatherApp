//
//  WeatherViewDelegate.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/06.
//

import Foundation

protocol WeatherRepositoryDelegate: AnyObject {
    func weatherRepository(_ weatherRepository: WeatherRepositoryProtocol, didFetchWeatherData data: WeatherData)
    func weatherRepository(_ weatherRepository: WeatherRepositoryProtocol, didFailWithError error: Error)
}

