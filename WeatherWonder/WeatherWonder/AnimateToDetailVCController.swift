//
//  AnimateToDetailVCController.swift
//  WeatherWonder
//
//  Created by Nathan Birkholz on 1/16/15.
//  Copyright (c) 2015 Nate Birkholz. All rights reserved.
//

import UIKit

class AnimateToDetailVCController : NSObject, UIViewControllerAnimatedTransitioning {

  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    return 1.0
  }

  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as ViewController
    let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as DetailViewController
    let containerView = transitionContext.containerView()
    let duration = self.transitionDuration(transitionContext)
    let selectedRow = fromViewController.tableView.indexPathForSelectedRow()
    let cell = fromViewController.tableView.cellForRowAtIndexPath(selectedRow!) as WeatherCell
    let weatherSnapshot = cell.forecastImage.snapshotViewAfterScreenUpdates(false)

    weatherSnapshot.frame = containerView.convertRect(cell.forecastImage.frame, fromView: fromViewController.tableView.cellForRowAtIndexPath(selectedRow!))
    cell.forecastImage.hidden = true
    toViewController.view.frame = transitionContext.finalFrameForViewController(toViewController)
    toViewController.view.alpha = 0
    toViewController.detailImageView.hidden = true
      // Update layout to clean up begnning positions of labels on detail VC, Size Classes issue
    toViewController.view.setNeedsLayout()
    toViewController.view.layoutIfNeeded()

    containerView.addSubview(toViewController.view)
    containerView.addSubview(weatherSnapshot)
    UIView.animateWithDuration(duration, animations: { () -> Void in
        // Update layout to set proper target for final frame of animation, Size Classes issue
      toViewController.view.setNeedsLayout()
      toViewController.view.layoutIfNeeded()
      
      toViewController.view.alpha = 1.0
      var endRect = containerView.convertRect(toViewController.detailImageView.frame, fromView: toViewController.view)
      weatherSnapshot.frame = toViewController.detailImageView.frame
    }) { (finished) -> Void in
      toViewController.detailImageView.hidden = false
      cell.forecastImage.hidden = false
      weatherSnapshot.removeFromSuperview()
      transitionContext.completeTransition(true)
    }
  }

} // End
