//
//  ReachableSheetPresentationController.swift
//  PresentationController
//
//  Created by muukii on 7/1/18.
//  Copyright © 2018 eure. All rights reserved.
//

import UIKit

final class ReachableSheetPresentationController : UIPresentationController {

  private let backdropView = UIVisualEffectView(effect: nil)

  private let effect = UIBlurEffect.init(style: .dark)

  private let containerViewForPresentedView: UIView = .init()

  override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
    super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

    let controlView = UIControl()
    controlView.addTarget(self, action: #selector(didTapBackdropView), for: .touchUpInside)

    backdropView.contentView.addSubview(controlView)
    controlView.frame = backdropView.bounds
    controlView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }

  @objc
  dynamic private func didTapBackdropView() {

    presentedViewController.dismiss(animated: true, completion: nil)
  }

  override func presentationTransitionWillBegin() {

    guard let containerView = containerView else { return }

    makeupView: do {

      containerViewForPresentedView.layer.cornerRadius = 6
      containerViewForPresentedView.layer.masksToBounds = true

      let view = presentedViewController.view!
      containerViewForPresentedView.addSubview(view)
      view.frame = containerViewForPresentedView.bounds
      view.autoresizingMask = [.flexibleHeight, .flexibleWidth]

    }

    containerView.addSubview(backdropView)

    backdropView.frame = containerView.bounds
    backdropView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    self.backdropView.effect = nil

    // To access context
    // UIVisualEffect's animation does not work in animation in context.
    presentedViewController.transitionCoordinator?.animate(
      alongsideTransition: { (context) in

        UIViewPropertyAnimator(duration: context.transitionDuration, curve: .easeOut) {
          self.backdropView.effect = self.effect
          }
          .startAnimation()
    },
      completion: { (context) in

    })
  }

  override func presentationTransitionDidEnd(_ completed: Bool) {

  }

  override func dismissalTransitionWillBegin() {

    presentedViewController.transitionCoordinator?.animate(
      alongsideTransition: { (context) in

        UIViewPropertyAnimator(duration: context.transitionDuration, curve: .easeOut) {
          self.backdropView.effect = nil
          }
          .startAnimation()
    },
      completion: { (context) in

    })
  }

  override func dismissalTransitionDidEnd(_ completed: Bool) {

    backdropView.removeFromSuperview()
  }

  override var frameOfPresentedViewInContainerView: CGRect {

    let containerViewBounds = containerView!.bounds

    var frame = containerViewBounds
    let height: CGFloat = 300
    frame.origin.y += frame.size.height - height
    frame.size.height = height
    if #available(iOS 11.0, *) {
      frame = frame.insetBy(dx: 8, dy: containerView!.safeAreaInsets.bottom + 16)
    } else {
      frame = frame.insetBy(dx: 8, dy: 16)
    }

    return frame
  }

  override var shouldPresentInFullscreen: Bool {
    return false
  }

  override var shouldRemovePresentersView: Bool {
    return false
  }

  override var presentedView: UIView? {
    return containerViewForPresentedView
  }
}
