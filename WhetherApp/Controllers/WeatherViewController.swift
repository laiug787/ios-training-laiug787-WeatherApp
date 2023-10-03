//
//  ViewController.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/04.
//

import UIKit

// MARK: ViewController
final class WeatherViewController: UIViewController {
    
    private var repository: WeatherRepositoryProtocol!
    
    @IBOutlet @ViewLoading var weatherImage: UIImageView
    @IBOutlet @ViewLoading var minTemperatureLabel: UILabel
    @IBOutlet @ViewLoading var maxTemperatureLabel: UILabel
    
    @IBAction private func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func reloadAction(_ sender: Any) {
        guard self.presentedViewController == nil else { return }
        repository.fetchWeatherCondition(area: "Tokyo", date: .now)
    }
    
    init?(coder: NSCoder, repository: WeatherRepositoryProtocol) {
        self.repository = repository
        super.init(coder: coder)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        repository.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.reloadAction),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    deinit {
        print("Deinitialize WeatherViewController")
    }
}

// MARK: Delegate
extension WeatherViewController: WeatherRepositoryDelegate {
    func weatherRepository(_ weatherRepository: WeatherRepositoryProtocol, didFetchWeatherData data: WeatherData) {
        weatherImage.image = getImageView(for: data.weatherCondition)
        weatherImage.tintColor = getImageColor(for: data.weatherCondition)
        minTemperatureLabel.text = "\(data.minTemperature)"
        maxTemperatureLabel.text = "\(data.maxTemperature)"
    }
    
    func weatherRepository(_ weatherRepository: WeatherRepositoryProtocol, didFailWithError error: Error) {
        let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
        let done = UIAlertAction(title: "OK", style: .default)
        alert.addAction(done)
        present(alert, animated: true)
    }
}

// MARK: Private
private extension WeatherViewController {
    func getImageView(for weatherCondition: WeatherCondition) -> UIImage? {
        switch weatherCondition {
        case .sunny:
            return UIImage.sunny
        case .cloudy:
            return UIImage.cloudy
        case .rainy:
            return UIImage.rainy
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

extension UIImage {
    static var sunny: UIImage? {
        return UIImage(named: "weather-sunny")
    }
    
    static var cloudy: UIImage? {
        return UIImage(named: "weather-cloudy")
    }
    
    static var rainy: UIImage? {
        return UIImage(named: "weather-rainy")
    }
}
