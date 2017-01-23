//
//  DGParallaxViewControllerAnimator.swift
//  DGParallaxInteractiveTransition
//
//  Created by Benoit BRIATTE on 17/01/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit

public enum DGParallaxViewControllerAnimatorState {
    case presenting
    case dismissing
}

class DGParallaxViewControllerAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    var state: DGParallaxViewControllerAnimatorState
    var viewScale: CGFloat

    init(state: DGParallaxViewControllerAnimatorState) {
        self.state = state
        self.viewScale = 1
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
        let fromView = fromViewController.view,
        let toView = toViewController.view
        else {
            return
        }
        let containerView = transitionContext.containerView
        var finalFrame = CGRect.zero
        if self.state == .presenting {
            finalFrame = transitionContext.finalFrame(for: toViewController)
            toView.frame = finalFrame.offsetBy(dx: 0, dy: finalFrame.maxY)
            containerView.addSubview(toView)
        } else {
            let fromFinalFrame = transitionContext.finalFrame(for: fromViewController)
            finalFrame = fromFinalFrame.offsetBy(dx: 0, dy: fromView.frame.maxY)
        }
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: UIViewAnimationOptions(rawValue: 0), animations: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            if strongSelf.state == .presenting {
                toView.frame = finalFrame
                fromView.transform = CGAffineTransform.scaledBy(.identity)(x: strongSelf.viewScale, y: strongSelf.viewScale)
            } else {
                fromView.frame = finalFrame
                toView.transform = CGAffineTransform.scaledBy(.identity)(x: strongSelf.viewScale, y: strongSelf.viewScale)
            }
        }) { [weak self] (finished) in
            guard let strongSelf = self else {
                return
            }
            let cancelled = transitionContext.transitionWasCancelled
            let completed = finished && !cancelled
            transitionContext.completeTransition(completed)
            if completed {
                if strongSelf.state == .presenting {
                    containerView.insertSubview(fromView, at: 0)
                } else {
                    fromView.removeFromSuperview()
                }
            }
        }
    }
}
