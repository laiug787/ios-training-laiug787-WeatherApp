//
//  ViewController.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/04.
//

import UIKit

// MARK: ViewController
final class WeatherViewController: UIViewController {
    
    private let repository = WeatherRepository()
    
    weak var delegate: WeatherViewDelegate?
    
    @IBOutlet @ViewLoading private var weatherImage: UIImageView

    @IBAction private func closeAction(_ sender: Any) {
        delegate?.closeWeather()
    }
    
    @IBAction private func reloadAction(_ sender: Any) {
        delegate?.reloadWeather()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    deinit {
        print("Deinitialize WeatherViewController")
    }
}

// MARK: Delegate
extension WeatherViewController: WeatherViewDelegate {
    func closeWeather() {
        weatherImage.image = nil
        self.dismiss(animated: true)
    }
    
    func reloadWeather() {
        let weather = repository.fetchWeatherCondition()
        weatherImage.image = UIImage(named: getImageName(for: weather))
        weatherImage.tintColor = getImageColor(for: weather)
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

