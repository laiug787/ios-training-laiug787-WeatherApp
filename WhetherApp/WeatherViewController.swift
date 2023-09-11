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
    @IBOutlet @ViewLoading private var minTemperatureLabel: UILabel
    @IBOutlet @ViewLoading private var maxTemperatureLabel: UILabel
    
    @IBAction private func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction private func reloadAction(_ sender: Any) {
        repository.fetchWeatherCondition()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        minTemperatureLabel.textColor = .systemBlue
        maxTemperatureLabel.textColor = .systemRed
        repository.delegate = self
    }
    
    deinit {
        print("Deinitialize WeatherViewController")
    }
}

// MARK: Delegate
extension WeatherViewController: WeatherRepositoryDelegate {
    func weatherRepository(_ weatherRepository: WeatherRepositoryProtocol, didFetchWeatherData data: WeatherData) {
        weatherImage.image = UIImage(named: getImageName(for: data.weatherCondition))
        weatherImage.tintColor = getImageColor(for: data.weatherCondition)
        minTemperatureLabel.text = "\(data.minTemperature)"
        maxTemperatureLabel.text = "\(data.maxTemperature)"
    }
    
    func weatherRepository(_ weatherRepository: WeatherRepositoryProtocol, didFailWithError error: WeatherError) {
        let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
        let done = UIAlertAction(title: "OK", style: .default)
        alert.addAction(done)
        present(alert, animated: true)
    }
}

// MARK: Private
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

