//
//  UINavigationBarAppearance+Extensions.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 21/10/2022.
//

import UIKit

extension UINavigationBarAppearance {
    
    class func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        let backItemAppearance = UIBarButtonItemAppearance()
        backItemAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.clear]
        appearance.backButtonAppearance = backItemAppearance
        var backImageName = "chevron.backward"
        if #unavailable(iOS 14.0) {
            backImageName = "arrow.left"
        }
        let backImage = UIImage.createFromBaseName(backImageName, tintColor: .secondaryLabel)
        appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
}
