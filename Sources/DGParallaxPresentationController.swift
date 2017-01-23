//
//  DGParallaxPresentationController.swift
//  DGParallaxInteractiveTransition
//
//  Created by Benoit BRIATTE on 17/01/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit

class DGParallaxPresentationController: UIPresentationController {

    var containerViewInsets: UIEdgeInsets

    var overlayColor: UIColor? {
        get {
            return self.overlayView.backgroundColor
        }
        set {
            self.overlayView.backgroundColor = newValue != nil ? newValue : .black
        }
    }

    var maximumOverlayAlpha: CGFloat

    fileprivate lazy var overlayView: UIView = {
        let overlayView = UIView()
        overlayView.autoresizingMask = [.flexibleBottomMargin,
                                        .flexibleHeight,
                                        .flexibleLeftMargin,
                                        .flexibleRightMargin,
                                        .flexibleTopMargin,
                                        .flexibleWidth]
        return overlayView
    }()

    override var shouldRemovePresentersView: Bool {
        return true
    }

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        self.containerViewInsets = .zero
        self.maximumOverlayAlpha = 0.7
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.overlayColor = nil
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let containerView = self.containerView, let presentedView = self.presentedView else {
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

    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] _ in
            guard let strongSelf = self else {
                return
            }
            strongSelf.overlayView.alpha = 0
        }, completion: nil)
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        if completed {
            self.overlayView.removeFromSuperview()
        }
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        return UIEdgeInsetsInsetRect(super.frameOfPresentedViewInContainerView, self.containerViewInsets)
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        guard let containerView = self.containerView else {
            return
        }
        self.presentingViewController.view.bounds = containerView.frame
    }
}
