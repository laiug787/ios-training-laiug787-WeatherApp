//
//  ViewController.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/04.
//

import UIKit
import YumemiWeather

final class WeatherViewController: UIViewController {

    private let WeatherRequest = YumemiWeather.self
    
    @IBOutlet private weak var weatherImage: UIImageView!

    @IBAction private func closeAction(_ sender: Any) {
        weatherImage.image = nil
    }
    
    @IBAction private func reloadAction(_ sender: Any) {
        guard let weather = WeatherType(rawValue: WeatherRequest.fetchWeatherCondition()) else { return }
        
        weatherImage.image = UIImage(named: weather.imageName)?.withRenderingMode(.alwaysTemplate)
        weatherImage.tintColor = weather.imageColor
    }
}

