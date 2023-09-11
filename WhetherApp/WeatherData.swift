//
//  WeatherData.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/11.
//

import Foundation

struct WeatherData: Hashable, Decodable {
    var date: String
    var maxTemperature: Int
    var minTemperature: Int
    var weatherCondition: WeatherCondition
}
