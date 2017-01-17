//
//  DGParallaxViewControllerAnimator.swift
//  DGParallaxInteractiveTransition
//
//  Created by Benoit BRIATTE on 17/01/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit

public enum DGParallaxViewControllerAnimatorState {
    case presenting;
    case dismissing;
}

class DGParallaxViewControllerAnimator: UIViewControllerAnimatedTransitioning {

    open var state: DGParallaxViewControllerAnimatorState
    open var viewScale: CGFloat

    public init(state: DGParallaxViewControllerAnimatorState) {
        self.state = state
        self.viewScale = 1
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let fromViewController = transitionContext.viewController(forKey: UITransitionContextFromViewControllerKey),
           let toViewController = transitionContext.viewController(forKey: UITransitionContextFromViewControllerKey) {

        }

    }

}
