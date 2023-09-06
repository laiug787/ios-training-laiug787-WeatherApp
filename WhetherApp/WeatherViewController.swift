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
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func reloadAction(_ sender: Any) {
        let weather = weatherAPI.fetchWeatherCondition()
        
        weatherImage.image = UIImage(named: weather.imageName)
        weatherImage.tintColor = weather.imageColor
    }
}

private extension WeatherType {
    
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

