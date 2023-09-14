//
//  WeatherRequestParameter.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/11.
//

import Foundation

struct WeatherRequestParameter: Encodable {
    let area: String
    let date: Date
}


