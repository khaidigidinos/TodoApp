//
//  UIAlertControllerExtension.swift
//  TodoApp
//
//  Created by Khai Nguyen Minh on 3/21/22.
//

import SwiftUI

extension UIAlertController {

    func show() {
        present(animated: true, completion: nil)
    }

    func present(animated: Bool, completion: (() -> Void)?) {
        if let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController {
            presentFromController(rootVC, animated: animated, completion: completion)
        }
    }

    private func presentFromController(controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if  let navVC = controller as? UINavigationController,
            let visibleVC = navVC.visibleViewController {
                presentFromController(visibleVC, animated: animated, completion: completion)
        } else {
          if  let tabVC = controller as? UITabBarController,
              let selectedVC = tabVC.selectedViewController {
                presentFromController(selectedVC, animated: animated, completion: completion)
          } else {
              controller.presentViewController(self, animated: animated, completion: completion)
          }
        }
    }
}
