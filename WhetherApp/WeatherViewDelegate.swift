//
//  WeatherViewDelegate.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/06.
//

import Foundation

protocol WeatherViewDelegate: AnyObject {
    func closeButtonTapped()
    func reloadButtonTapped(_ weather: WeatherCondition)
}

