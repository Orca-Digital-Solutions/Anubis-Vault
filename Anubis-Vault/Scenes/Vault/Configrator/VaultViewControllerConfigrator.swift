//
//  VaultViewControllerConfigrator.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 19/10/2022.
//

import UIKit

final class VaultViewControllerConfigrator {
    
    class func createVaultVC() -> UINavigationController {
        let vaultNavigation = UINavigationController(rootViewController: VaultViewController())
        if let vaultView = vaultNavigation.children.first as? VaultViewController {
            let keyboardManager = KeyboardManager(view: vaultView.view, publisher: vaultView.$bottomConstraint)
            let vaultRepository = RealmManager()
            let vaultRouter = VaultVCRouter(navigationController: vaultNavigation)
            let vaultPresenter = VaultVCPreseneter(view: vaultView, router: vaultRouter, realmRepository: vaultRepository)
            vaultView.preseneter = vaultPresenter
            vaultView.keyboardManager = keyboardManager
        }
        return vaultNavigation
    }
    
}
