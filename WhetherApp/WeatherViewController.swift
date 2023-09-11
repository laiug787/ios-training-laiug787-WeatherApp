//
//  ViewController.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/04.
//

import UIKit

// MARK: ViewController
final class WeatherViewController: UIViewController {
    
    private let repository: WeatherRepositoryProtocol = WeatherRepository()
    
    @IBOutlet @ViewLoading private var weatherImage: UIImageView

    @IBAction private func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction private func reloadAction(_ sender: Any) {
        repository.fetchWeatherCondition()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository.delegate = self
    }
    
    deinit {
        print("Deinitialize WeatherViewController")
    }
}

// MARK: Delegate
extension WeatherViewController: WeatherRepositoryDelegate {
    func weatherRepository(_ weatherRepository: WeatherRepositoryProtocol, didFetchWeatherCondition condition: WeatherCondition) {
        weatherImage.image = UIImage(named: getImageName(for: condition))
        weatherImage.tintColor = getImageColor(for: condition)
    }
}

// MARK: Extensions
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

