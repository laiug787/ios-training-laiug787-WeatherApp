//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by 瀬川 裕翔 on 2023/09/14.
//

import XCTest
@testable import WhetherApp

final class MockWeatherRepositry: WeatherRepositoryProtocol {
    weak var delegate: WhetherApp.WeatherRepositoryDelegate?
    
    let weatherData: WeatherData
    
    init(maxTemperature: Int = 10, minTemperature: Int = 20, weatherCondition: WeatherCondition = .sunny) {
        self.weatherData = WeatherData(
            date: "",
            maxTemperature: maxTemperature,
            minTemperature: minTemperature,
            weatherCondition: weatherCondition
        )
    }
    
    func fetchWeatherCondition(area: String, date: Date) {
        delegate?.weatherRepository(self, didFetchWeatherData: weatherData)
    }
}

final class WeatherAppTests: XCTestCase {
    
    func testWeatherImageIsSunny() {
        let repository = MockWeatherRepositry(weatherCondition: .sunny)
        let storyBoard = UIStoryboard(name: "WeatherView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "WeatherView") { coder in
            return WeatherViewController(coder: coder, repository: repository)
        }
        viewController.loadViewIfNeeded()
        viewController.reloadAction(self)
        
        XCTAssertEqual(viewController.weatherImage.image, UIImage.sunny)
    }
    
    func testWeatherImageIsCloudy() {
        let repository = MockWeatherRepositry(weatherCondition: .cloudy)
        let storyBoard = UIStoryboard(name: "WeatherView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "WeatherView") { coder in
            return WeatherViewController(coder: coder, repository: repository)
        }
        viewController.loadViewIfNeeded()
        viewController.reloadAction(self)

        XCTAssertEqual(viewController.weatherImage.image, UIImage.cloudy)
    }

    func testWeatherImageIsRainy() {
        let repository = MockWeatherRepositry(weatherCondition: .rainy)
        let storyBoard = UIStoryboard(name: "WeatherView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "WeatherView") { coder in
            return WeatherViewController(coder: coder, repository: repository)
        }
        viewController.loadViewIfNeeded()
        viewController.reloadAction(self)

        XCTAssertEqual(viewController.weatherImage.image, UIImage.rainy)
    }

    func testMaxTemperatureLabelHasText() {
        let maxTemperature = 30
        let repository = MockWeatherRepositry(maxTemperature: maxTemperature)
        let storyBoard = UIStoryboard(name: "WeatherView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "WeatherView") { coder in
            return WeatherViewController(coder: coder, repository: repository)
        }
        viewController.loadViewIfNeeded()
        viewController.reloadAction(self)

        XCTAssertEqual(viewController.maxTemperatureLabel.text, "\(maxTemperature)")
    }

    func testMinTemperatureLabelHasText() {
        let minTemperature = 0
        let repository = MockWeatherRepositry(minTemperature: minTemperature)
        let storyBoard = UIStoryboard(name: "WeatherView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "WeatherView") { coder in
            return WeatherViewController(coder: coder, repository: repository)
        }
        viewController.loadViewIfNeeded()
        viewController.reloadAction(self)

        XCTAssertEqual(viewController.minTemperatureLabel.text, "\(minTemperature)")
    }
}
