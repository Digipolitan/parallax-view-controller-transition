//
//  ParallaxViewControllerAnimator.swift
//  DGParallaxViewControllerTransition
//
//  Created by Benoit BRIATTE on 17/01/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit

enum ParallaxViewControllerAnimatorState {
    case presenting
    case dismissing
}

class ParallaxViewControllerAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    private(set) var state: ParallaxViewControllerAnimatorState
    public var viewTransform: CGAffineTransform

    public init(state: ParallaxViewControllerAnimatorState) {
        self.state = state
        self.viewTransform = .identity
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.state == .presenting {
            self.presentingTransition(using: transitionContext)
        } else {
            self.dismissingTransition(using: transitionContext)
        }
    }

    #if os(iOS)
    private func prepareBackgroundColor(viewController: UIViewController) {
        if let navigationController = viewController as? UINavigationController,
            navigationController.isNavigationBarHidden == false {
            let navigationBar = navigationController.navigationBar
            if navigationBar.barStyle == .default {
                viewController.view.backgroundColor = navigationController.navigationBar.barTintColor ?? .white
            } else {
                viewController.view.backgroundColor = .black
            }
        }
    }
    #endif

    private func presentingTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let fromView = fromViewController.view,
            let toView = toViewController.view
            else {
                return
        }
        let containerView = transitionContext.containerView
        let toFinalFrame = transitionContext.finalFrame(for: toViewController)
        toView.frame = toFinalFrame.offsetBy(dx: 0, dy: toFinalFrame.maxY)
        #if os(iOS)
        self.prepareBackgroundColor(viewController: fromViewController)
        #endif
        containerView.addSubview(toView)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: .beginFromCurrentState, animations: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            toView.frame = toFinalFrame
            fromView.transform = strongSelf.viewTransform
            }, completion: { (finished) in
            let cancelled = transitionContext.transitionWasCancelled
            let completed = finished && !cancelled
            transitionContext.completeTransition(completed)
        })
    }

    private func dismissingTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let fromView = fromViewController.view,
            let toView = toViewController.view,
            let snapshotView = toView.snapshotView(afterScreenUpdates: true)
            else {
                return
        }
        let containerView = transitionContext.containerView
        let fromFinalFrame = transitionContext.finalFrame(for: fromViewController)
        let finalFrame = fromFinalFrame.offsetBy(dx: 0, dy: fromView.frame.maxY)
        containerView.insertSubview(snapshotView, at: 0)
        snapshotView.transform = toView.transform
        snapshotView.frame = toView.frame
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: UIViewAnimationOptions(rawValue: 0), animations: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            fromView.frame = finalFrame
            snapshotView.transform = strongSelf.viewTransform
            }, completion: { (finished) in
            let cancelled = transitionContext.transitionWasCancelled
            let completed = finished && !cancelled
            transitionContext.completeTransition(completed)
            snapshotView.removeFromSuperview()
            if completed {
                toView.transform = snapshotView.transform
            }
        })
    }
}
