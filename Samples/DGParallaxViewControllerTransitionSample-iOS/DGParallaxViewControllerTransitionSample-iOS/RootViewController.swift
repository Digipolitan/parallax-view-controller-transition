//
//  ViewController.swift
//  DGParallaxViewControllerTransitionSample-iOS
//
//  Created by Benoit BRIATTE on 23/12/2016.
//  Copyright © 2016 Digipolitan. All rights reserved.
//

import UIKit
import DGParallaxViewControllerTransition

class RootViewController: UIViewController {

    var parallaxTransition: DGParallaxViewControllerTransition?
    var startOffset: CGFloat = 0

    @IBAction func touchDisplayDetail(_ sender: Any) {
        let viewController = RootViewController(nibName: "RootViewController", bundle: nil)
        viewController.startOffset = self.startOffset + 50
        let navigationController = UINavigationController(rootViewController: RootViewController(nibName: "RootViewController", bundle: nil))
        navigationController.navigationBar.barTintColor = .red
        navigationController.navigationBar.isTranslucent = false
        let parallaxTransition = DGParallaxViewControllerTransition()
        parallaxTransition.presentedViewInsets = UIEdgeInsets(top: 100 + self.startOffset, left: 0, bottom: 100, right: 0)
        parallaxTransition.overlayColor = .gray
        parallaxTransition.maximumOverlayAlpha = 0.5
        parallaxTransition.attach(to: viewController)
        self.present(viewController, animated: true, completion: nil)
        self.parallaxTransition = parallaxTransition
    }
}
