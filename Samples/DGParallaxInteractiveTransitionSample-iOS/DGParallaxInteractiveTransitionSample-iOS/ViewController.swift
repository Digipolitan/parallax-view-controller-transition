//
//  ViewController.swift
//  DGParallaxInteractiveTransitionSample-iOS
//
//  Created by Benoit BRIATTE on 23/12/2016.
//  Copyright © 2016 Digipolitan. All rights reserved.
//

import UIKit
import DGParallaxInteractiveTransition

class ViewController: UIViewController {

    let transition = DGParallaxViewControllerTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        print("APPEAR")
    }

    @IBAction func touchDisplayDetail(_ sender: Any) {
        let detailViewController = DetailViewController()
        //let navigationController = UINavigationController(rootViewController: detailViewController)
        transition.presentedViewInsets = UIEdgeInsets(top: 50, left: 10, bottom: 50, right: 10)
        transition.attach(to: detailViewController)
        self.present(detailViewController, animated: true, completion: nil)
    }
}
