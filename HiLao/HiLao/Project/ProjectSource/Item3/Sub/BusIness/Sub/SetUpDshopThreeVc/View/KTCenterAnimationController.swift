//
//  KTCenterAnimationController.swift
//  Project
//
//  Created by 张凯强 on 2017/12/24.
//  Copyright © 2017年 HHCSZGD. All rights reserved.
//

import UIKit

class KTCenterAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        let toVC = transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromVC = transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.from)
        if (toVC?.isBeingPresented)! {
            return 0.3
        }else if (fromVC?.isBeingDismissed)! {
            return 0.2
        }
        return 0.3
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
       
        let containerView = transitionContext.containerView
        let duration = self.transitionDuration(using: transitionContext)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        if (toVC == nil) || (fromVC == nil) {
            return
        }
        
        if (toVC?.isBeingPresented)! {
            guard let toVC = toVC as? SelectBusinessDay else {
                return
            }
            containerView.addSubview((toVC.view)!)
            toVC.view.frame = CGRect.init(x: 0, y: 0, width: containerView.bounds.size.width, height: containerView.bounds.size.height)
            toVC.superBackView.alpha = 0.0
            let oldTransform = toVC.backView.transform
            toVC.backView.transform = (oldTransform.scaledBy(x: 0.3, y: 0.3))
            toVC.backView.center = containerView.center
            UIView.animate(withDuration: duration, animations: {
                toVC.superBackView.alpha = 0.3
                toVC.backView.transform = oldTransform
            }, completion: { (bool) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
            
        }else if (fromVC?.isBeingDismissed)! {
            UIView.animate(withDuration: duration, animations: {
                fromVC?.view.alpha = 0.0
            }, completion: { (bool) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
        
        
        
    }
    
    
}
