//
//  LaunchViewController.swift
//  WhetherApp
//
//  Created by 瀬川 裕翔 on 2023/09/04.
//

import UIKit

final class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let storyboard = UIStoryboard(name: "WeatherView", bundle: nil)
        let nextVC = storyboard.instantiateViewController(identifier: "WeatherView")
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let storyboard = UIStoryboard(name: "WeatherView", bundle: nil)
        let nextVC = storyboard.instantiateViewController(identifier: "WeatherView")
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
}
