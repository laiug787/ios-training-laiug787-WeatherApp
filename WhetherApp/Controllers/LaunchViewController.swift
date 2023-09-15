//
//  LaunchViewController.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/04.
//

import UIKit

final class LaunchViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let repository = WeatherRepository()
        let storyBoard = UIStoryboard(name: "WeatherView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "WeatherView") { coder in
            return WeatherViewController(coder: coder, repository: repository)
        }
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
    
}
