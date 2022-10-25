//
//  UIFont+Extensions.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 25/10/2022.
//

import UIKit

extension UIFont {
    
    // copied From here
    // https://spin.atomicobject.com/2018/02/02/swift-scaled-font-bold-italic/
    
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0)
    }

    func Bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
}
