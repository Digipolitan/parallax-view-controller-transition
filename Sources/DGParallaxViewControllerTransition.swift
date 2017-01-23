//
//  DGParallaxViewControllerTransition.swift
//  DGParallaxInteractiveTransition
//
//  Created by Benoit BRIATTE on 17/01/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit

open class DGParallaxViewControllerTransition: NSObject, UIViewControllerTransitioningDelegate {

    fileprivate var interactiveTransition: DGParallaxInteractiveTransition?

    open var presentedViewInsets: UIEdgeInsets

    open var overlayColor: UIColor

    open var maximumOverlayAlpha: CGFloat

    open var presentingViewScale: CGFloat

    public override init() {
        self.overlayColor = .black
        self.maximumOverlayAlpha = 0.7
        self.presentingViewScale = 0.92
        self.presentedViewInsets = .zero
        super.init()
    }

    open func attach(to viewController: UIViewController, interactive: Bool = true) {
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
        if interactive {
            self.interactiveTransition = DGParallaxInteractiveTransition(viewController: viewController)
        } else {
            self.interactiveTransition = nil
        }
    }

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = DGParallaxPresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.containerViewInsets = self.presentedViewInsets
        presentationController.overlayColor = self.overlayColor
        presentationController.maximumOverlayAlpha = self.maximumOverlayAlpha
        return presentationController
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = DGParallaxViewControllerAnimator(state: .presenting)
        animator.viewScale = self.presentingViewScale
        return animator
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DGParallaxViewControllerAnimator(state: .dismissing)
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let interactiveTransition = self.interactiveTransition else {
            return nil
        }
        return interactiveTransition.isStarted ? interactiveTransition : nil
    }
}
