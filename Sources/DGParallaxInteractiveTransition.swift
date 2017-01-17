//
//  DGParallaxInteractiveTransition.swift
//  DGParallaxInteractiveTransition
//
//  Created by Benoit BRIATTE on 17/01/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit

class DGParallaxInteractiveTransition: UIPercentDrivenInteractiveTransition {

    fileprivate(set) public weak var viewController: UIViewController?
    private var previousLocation: CGPoint?

    public var isStarted: Bool {
        return self.previousLocation != nil
    }

    private lazy var panGestureRecognizer: UIPanGestureRecognizer = {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action:  #selector(handle(gestureRecognizer:)))
        #if os(iOS)
            panGestureRecognizer.maximumNumberOfTouches = 1
        #endif
        return panGestureRecognizer
    }()

    init(viewController: UIViewController) {
        super.init()
        viewController.view.addGestureRecognizer(self.panGestureRecognizer)
        self.viewController = viewController
    }

    deinit {
        self.viewController?.view.removeGestureRecognizer(self.panGestureRecognizer)
    }

    @objc private func handle(gestureRecognizer: UIPanGestureRecognizer) {
        if let view = gestureRecognizer.view, let window = view.window {
            self.previousLocation = gestureRecognizer.location(in: window)
            if gestureRecognizer.state == .began {
                self.viewController?.dismiss(animated: true, completion: nil)
            } else if gestureRecognizer.state == .cancelled {
                self.cancel()
                previousLocation = nil
            } else if gestureRecognizer.state == .changed || gestureRecognizer.state == .ended {
                let translation = gestureRecognizer.translation(in: window)
                let verticalMovement = translation.y / window.bounds.height
                let downwardMovement = fmaxf(Float(verticalMovement), 0)
                let progress = CGFloat(fminf(downwardMovement, 1))
                if gestureRecognizer.state == .changed {
                    self.update(progress)
                } else {
                    if progress > 0.3 || gestureRecognizer.velocity(in: window).y > 600 {
                        self.finish()
                    } else {
                        self.cancel()
                    }
                    previousLocation = nil
                }
            }
        }
    }
}
