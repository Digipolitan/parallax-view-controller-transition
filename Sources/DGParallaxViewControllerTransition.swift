//
//  DGParallaxViewControllerTransition.swift
//  DGParallaxInteractiveTransition
//
//  Created by Benoit BRIATTE on 17/01/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit

/**
 * Parallax transition for view controllers
 * @author Benoit BRIATTE http://www.digipolitan.com
 * @copyright 2017 Digipolitan. All rights reserved.
 */
open class DGParallaxViewControllerTransition: NSObject, UIViewControllerTransitioningDelegate {

    /**
     * Retrieves the interactive transition if interactive = true when the view controller is attach to the transition
     */
    fileprivate var interactiveTransition: DGParallaxInteractiveTransition?

    /**
     * Modify presented margins, default zero margin
     */
    open var presentedViewInsets: UIEdgeInsets

    /**
     * Change the overlay color, default value black
     */
    open var overlayColor: UIColor

    /**
     * Change the maximum overlay alpha, default 0.75
     */
    open var maximumOverlayAlpha: CGFloat

    /**
     * Update the presenting view scale, default 0.92
     */
    open var presentingViewScale: CGFloat

    public override init() {
        self.overlayColor = .black
        self.maximumOverlayAlpha = 0.75
        self.presentingViewScale = 0.92
        self.presentedViewInsets = .zero
        super.init()
    }

    /**
     * Attach the animation to the given view controller
     * @param viewController The view controller to be presented
     * @param interactive Sets to true allow user interaction, otherwise no user interaction will be provided
     */
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
        return DGParallaxPresentationController(presentedViewController: presented, presenting: presenting, containerViewInsets: self.presentedViewInsets, maximumOverlayAlpha: self.maximumOverlayAlpha, overlayColor: self.overlayColor)
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
