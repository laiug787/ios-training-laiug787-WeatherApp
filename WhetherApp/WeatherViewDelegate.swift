//
//  WeatherViewDelegate.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/06.
//

import Foundation

protocol WeatherViewDelegate: AnyObject {
    func closeWeather()
    func reloadWeather()
}

class WeatherView {
    weak var delegate: WeatherViewDelegate?
    
    func close() {
        delegate?.closeWeather()
    }
    
    func reload() {
        delegate?.reloadWeather()
    }
}

