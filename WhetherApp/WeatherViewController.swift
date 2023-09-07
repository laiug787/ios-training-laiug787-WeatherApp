//
//  ViewController.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/04.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    private let weatherAPI = WeatherRepository.instance
    
    @IBOutlet @ViewLoading private var weatherImage: UIImageView

    @IBAction private func closeAction(_ sender: Any) {
        weatherImage.image = nil
        self.dismiss(animated: true)
    }
    
    @IBAction private func reloadAction(_ sender: Any) {
        let weather = weatherAPI.fetchWeatherCondition()
        
        weatherImage.image = UIImage(named: getImageName(for: weather))
        weatherImage.tintColor = getImageColor(for: weather)
    }
}

private extension WeatherViewController {
    func getImageName(for weatherType: WeatherType) -> String {
        switch weatherType {
        case .sunny:
            return "weather-sunny"
        case .cloudy:
            return "weather-cloudy"
        case .rainy:
            return "weather-rainy"
        }
    }
    
    func getImageColor(for weatherType: WeatherType) -> UIColor {
        switch weatherType {
        case .sunny:
            return .systemRed
        case .cloudy:
            return .systemGray
        case .rainy:
            return .systemBlue
        }
    }
}

