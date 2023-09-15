//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by 瀬川 裕翔 on 2023/09/14.
//

import XCTest
@testable import WhetherApp

final class WeatherRepositryTest: WeatherRepositoryProtocol {
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
    
    func testSunnyWeatherImage() {
        let repository = WeatherRepositryTest()
        let viewController = WeatherViewController(repository: repository)
        
        viewController.loadViewIfNeeded()
        
        viewController.reloadAction(self)
        
        let imageView = viewController.weatherImage!
        
        XCTAssertNotNil(imageView.image)
        
        XCTAssertEqual(imageView.image, UIImage(named: "weather-sunny"))
    }

}
