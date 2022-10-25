//
//  UIImage+Extensions.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 19/10/2022.
//

import UIKit

extension UIImage {
    
    class func createFromBaseName(_ baseName: String!, tintColor: UIColor = .tintColor) -> UIImage? {
        let baseImage = UIImage(systemName: baseName)?.withTintColor(tintColor, renderingMode: .alwaysOriginal)
        return baseImage
    }
}
