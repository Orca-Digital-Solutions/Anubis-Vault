//
//  AnubisBaseTabBarController.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 21/10/2022.
//

import UIKit

class AnubisBaseTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.tabBar.tintColor = .tintColor
        self.tabBar.unselectedItemTintColor = .secondaryLabel
        self.tabBar.backgroundColor = .clear
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let toView = viewController.view, let fromView = self.selectedViewController?.view else {  return false }
        if(toView != fromView) {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve])
        }
        return true
    }
    
    private var scaleAnimation: CAKeyframeAnimation = {
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnimation.values = [1.0, 1.3, 1.5, 1.7, 1.5, 1.3, 1.0, 0.9, 1.0]
        scaleAnimation.duration = 0.35
        scaleAnimation.calculationMode = CAAnimationCalculationMode.cubic
        return scaleAnimation
    }()
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let itemIndex = tabBar.items?.firstIndex(of: item),
            tabBar.subviews.count > itemIndex + 1,
            let tabBarItemView = tabBar.subviews[itemIndex + 1] as? UIView else {
                return
        }
        tabBarItemView.layer.add(scaleAnimation, forKey: nil)
    }
}
