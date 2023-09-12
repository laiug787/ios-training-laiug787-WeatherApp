//
//  WeatherData.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/11.
//

import Foundation

struct WeatherData: Decodable {
    let date: String
    let maxTemperature: Int
    let minTemperature: Int
    let weatherCondition: WeatherCondition
}
