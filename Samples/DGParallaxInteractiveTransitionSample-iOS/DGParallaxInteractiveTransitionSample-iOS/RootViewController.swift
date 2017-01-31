//
//  ViewController.swift
//  DGParallaxInteractiveTransitionSample-iOS
//
//  Created by Benoit BRIATTE on 23/12/2016.
//  Copyright © 2016 Digipolitan. All rights reserved.
//

import UIKit
import DGParallaxInteractiveTransition

class RootViewController: UIViewController {

    var parallaxTransition: DGParallaxViewControllerTransition?

    @IBAction func touchDisplayDetail(_ sender: Any) {
        let detailViewController = DetailViewController(nibName: "DetailViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: detailViewController)
        navigationController.navigationBar.isTranslucent = false
        let parallaxTransition = DGParallaxViewControllerTransition()
        parallaxTransition.presentedViewInsets = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        parallaxTransition.overlayColor = .gray
        parallaxTransition.maximumOverlayAlpha = 0.5
        parallaxTransition.attach(to: navigationController)
        self.present(navigationController, animated: true, completion: nil)
        self.parallaxTransition = parallaxTransition
    }
}
