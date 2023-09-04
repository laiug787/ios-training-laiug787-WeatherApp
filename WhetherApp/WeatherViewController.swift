//
//  ViewController.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/04.
//

import UIKit
import YumemiWeather

final class WeatherViewController: UIViewController {

    @IBOutlet private weak var weatherImage: UIImageView!
    
    private let manager = YumemiWeather.self

    @IBAction private func closeAction(_ sender: Any) {
        print("close")
    }
    
    @IBAction private func reloadAction(_ sender: Any) {
        let weather = manager.fetchWeatherCondition()
        
        if weather == "sunny" {
            weatherImage.image = UIImage(named:"whether-sunny")?.withRenderingMode(.alwaysTemplate)
            weatherImage.tintColor = .systemRed
        } else if weather == "cloudy" {
            weatherImage.image = UIImage(named:"whether-cloudy")?.withRenderingMode(.alwaysTemplate)
            weatherImage.tintColor = .systemGray
        } else if weather == "rainy" {
            weatherImage.image =  UIImage(named:"whether-rainy")?.withRenderingMode(.alwaysTemplate)
            weatherImage.tintColor = .systemBlue
        }
        
        print(weather)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

