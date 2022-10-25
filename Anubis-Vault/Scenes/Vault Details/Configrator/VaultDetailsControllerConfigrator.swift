//
//  VaultDetailsControllerConfigrator.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 25/10/2022.
//

import UIKit

final class VaultDetailsControllerConfigrator {
    
    class func createVaultDetails(_ entity: VaultPasswsordEntity) -> UIViewController {
        let vaultDetailsView = VaultDetailsViewController()
        let router = VaultDetailsVCRouter(view: vaultDetailsView)
        let presenter = VaultDetailsPresenter(entity: entity, view: vaultDetailsView, router: router)
        vaultDetailsView.presenter = presenter
        return vaultDetailsView
    }
    
}

