//
//  WeatherType.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/05.
//

import UIKit

enum WeatherType: String {
    case sunny
    case cloudy
    case rainy
    
    var imageName: String {
        switch self {
        case .sunny:
            return "whether-sunny"
        case .cloudy:
            return "whether-cloudy"
        case .rainy:
            return "whether-rainy"
        }
    }
    
    var imageColor: UIColor {
        switch self {
        case .sunny:
            return .systemRed
        case .cloudy:
            return .systemGray
        case .rainy:
            return .systemBlue
        }
    }
}
