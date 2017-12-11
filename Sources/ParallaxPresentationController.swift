//
//  DGParallaxPresentationController.swift
//  DGParallaxViewControllerTransition
//
//  Created by Benoit BRIATTE on 17/01/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit

/**
 * Custom presentation controller, add margins and overlay color to the transition
 * @author Benoit BRIATTE http://www.digipolitan.com
 * @copyright 2017 Digipolitan. All rights reserved.
 */
class ParallaxPresentationController: UIPresentationController {

    /**
     * Container margins
     */
    public var containerViewInsets: UIEdgeInsets

    /**
     * Maximum overlay alpha
     */
    public var maximumOverlayAlpha: CGFloat

    /**
     * The overlay color
     */
    public var overlayColor: UIColor? {
        get {
            return self.overlayView.backgroundColor
        }
        set {
            self.overlayView.backgroundColor = newValue
        }
    }

    /**
     * Retrieves the overlay view
     */
    private lazy var overlayView: UIView = {
        let overlayView = UIView()
        overlayView.autoresizingMask = [.flexibleBottomMargin,
                                        .flexibleHeight,
                                        .flexibleLeftMargin,
                                        .flexibleRightMargin,
                                        .flexibleTopMargin,
                                        .flexibleWidth]
        return overlayView
    }()

    public override var shouldRemovePresentersView: Bool {
        return false
    }

    public init(presentedViewController: UIViewController,
                presenting presentingViewController: UIViewController?,
                containerViewInsets: UIEdgeInsets,
                maximumOverlayAlpha: CGFloat, overlayColor: UIColor) {
        self.containerViewInsets = containerViewInsets
        self.maximumOverlayAlpha = maximumOverlayAlpha
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.overlayColor = overlayColor
    }

    public override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard
            let containerView = self.containerView,
            let presentedView = self.presentedView
            else {
                return
        }
        self.overlayView.frame = containerView.bounds
        self.overlayView.alpha = 0
        containerView.insertSubview(self.overlayView, belowSubview: presentedView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            strongSelf.overlayView.alpha = strongSelf.maximumOverlayAlpha
            }, completion: nil)
    }

    public override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            strongSelf.overlayView.alpha = 0
            }, completion: nil)
    }

    public override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        if completed {
            self.overlayView.removeFromSuperview()
        }
    }

    public override var frameOfPresentedViewInContainerView: CGRect {
        return UIEdgeInsetsInsetRect(self.containerView?.bounds ?? .zero, self.containerViewInsets)
    }
}
