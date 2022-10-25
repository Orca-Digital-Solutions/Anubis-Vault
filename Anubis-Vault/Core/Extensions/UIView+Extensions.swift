//
//  UIView+Extensions.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 21/10/2022.
//

import UIKit

extension UIView {
    
    func setupViewShadows() {
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.layer.shadowOpacity = 0.6
        self.layer.shadowColor = self.backgroundColor?.withAlphaComponent(1.5).cgColor
        self.layer.shadowRadius = 6
    }
    
    func animateViewFadeInOut() {
        self.hideView { _ in
            self.showView()
        }
    }
    
    func showView() {
        guard self.isHidden else { return }
        UIView.transition(with: self, duration: 0.25, options: .transitionCrossDissolve, animations: {
            self.alpha = 1.00
            self.isHidden.toggle()
        })
    }
    
    func hideView(completion: ((Bool) -> Void)? = nil) {
        guard !self.isHidden else { return }
        UIView.transition(with: self, duration: 0.25, options: .transitionCrossDissolve, animations: {
            self.alpha = 0.00
            self.isHidden.toggle()
        }, completion: completion)
    }
    

}
