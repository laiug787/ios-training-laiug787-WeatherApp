//
//  ViewController.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/04.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    private let repository = WeatherRepository()
    
    @IBOutlet @ViewLoading private var weatherImage: UIImageView

    @IBAction private func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction private func reloadAction(_ sender: Any) {
        let weather = repository.fetchWeatherCondition()
        
        weatherImage.image = UIImage(named: getImageName(for: weather))
        weatherImage.tintColor = getImageColor(for: weather)
    }
}

private extension WeatherViewController {
    func getImageName(for weatherCondition: WeatherCondition) -> String {
        switch weatherCondition {
        case .sunny:
            return "weather-sunny"
        case .cloudy:
            return "weather-cloudy"
        case .rainy:
            return "weather-rainy"
        }
    }
    
    func getImageColor(for weatherCondition: WeatherCondition) -> UIColor {
        switch weatherCondition {
        case .sunny:
            return .systemRed
        case .cloudy:
            return .systemGray
        case .rainy:
            return .systemBlue
        }
    }
}

