//
//  ViewController.swift
//  DGParallaxInteractiveTransitionSample-tvOS
//
//  Created by Benoit BRIATTE on 23/12/2016.
//  Copyright © 2016 Digipolitan. All rights reserved.
//

import UIKit
import DGParallaxInteractiveTransition

class RootViewController: UIViewController {

    var parallaxTransition: DGParallaxViewControllerTransition?

    @IBAction func touchDisplayDetail(_ sender: Any) {
        let detailViewController = DetailViewController()
        let navigationController = UINavigationController(rootViewController: detailViewController)
        let parallaxTransition = DGParallaxViewControllerTransition()
        parallaxTransition.presentedViewInsets = UIEdgeInsets(top: 100, left: 100, bottom: 0, right: 100)
        parallaxTransition.attach(to: navigationController)
        self.present(navigationController, animated: true, completion: nil)
        self.parallaxTransition = parallaxTransition
    }
}
