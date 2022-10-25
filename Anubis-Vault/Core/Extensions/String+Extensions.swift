//
//  UITabBarItem+Extensions.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 21/10/2022.
//

import UIKit

extension String {
    
    func extractDomainFromString() -> String? {
        var extractResult: String?
        do {
            let extractTypes: NSTextCheckingResult.CheckingType = [ .link]
            let hostDetector = try NSDataDetector(types: extractTypes.rawValue)
            hostDetector.enumerateMatches(
                in: self, options: [],
                range: NSMakeRange(0, (self as NSString).length)) { (detectorResult, _, _) in
                    guard let detectorResult = detectorResult, let resultURL = detectorResult.url else { return }
                    if #available(iOS 16.0, *) {
                        extractResult = resultURL.host()
                    } else {
                        extractResult = resultURL.host
                    }
                }
        }
        catch {}
        return extractResult
    }
    
}
