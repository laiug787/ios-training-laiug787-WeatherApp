//
//  ViewController.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/04.
//

import UIKit

// MARK: ViewController
final class WeatherViewController: UIViewController {
    
    var repository: WeatherRepositoryProtocol = WeatherRepository()
    
    private var isAlertVisible: Bool = false
    
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var minTemperatureLabel: UILabel!
    @IBOutlet var maxTemperatureLabel: UILabel!
    
    @IBAction private func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func reloadAction(_ sender: Any) {
        guard !isAlertVisible else { return }
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
        weatherImage.image = UIImage(named: getImageName(for: data.weatherCondition))
        weatherImage.tintColor = getImageColor(for: data.weatherCondition)
        minTemperatureLabel.text = "\(data.minTemperature)"
        maxTemperatureLabel.text = "\(data.maxTemperature)"
    }
    
    func weatherRepository(_ weatherRepository: WeatherRepositoryProtocol, didFailWithError error: Error) {
        let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: .alert)
        let done = UIAlertAction(title: "OK", style: .default) { (action) in
            self.isAlertVisible = false
        }
        alert.addAction(done)
        present(alert, animated: true)
        isAlertVisible = true
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

