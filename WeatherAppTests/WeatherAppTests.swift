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
    
    let weatherData = WeatherData(
        date: "",
        maxTemperature: 1,
        minTemperature: 1,
        weatherCondition: .sunny
    )
    
    func fetchWeatherCondition(area: String, date: Date) {
        delegate?.weatherRepository(self, didFetchWeatherData: weatherData)
    }
}

final class WeatherAppTests: XCTestCase {
    
    func testWeatherImageIsSunny() {
        let repository = MockWeatherRepositry()
        let storyBoard = UIStoryboard(name: "WeatherView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "WeatherView") { coder in
            return WeatherViewController(coder: coder, repository: repository)
        }

        guard let imageView = viewController.weatherImage else { return }
        
        viewController.loadViewIfNeeded()
        
        viewController.reloadAction(self)
        
        XCTAssertNotNil(imageView.image)
        
        XCTAssertEqual(imageView.image, UIImage(named: "weather-sunny"))
    }

}
