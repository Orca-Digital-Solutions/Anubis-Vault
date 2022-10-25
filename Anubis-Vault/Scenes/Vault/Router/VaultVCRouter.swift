//
//  VaultVCRouter.swift
//  Anubis-Vault
//
//  Created by Shady K. Maadawy on 21/10/2022.
//

import UIKit

final class VaultVCRouter {

    private weak var navigationController: UINavigationController!
    
    init(navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }
    
    func pushAddView(presenter: VaultPresenterDelegation) {
        let viewContrroler = CreatePasswordViewControllerConfigrator.createPasswordVC(presenter: presenter)
        self.navigationController.pushViewController(viewContrroler, animated: true)
    }
    
    func pushDetailsView(for vaultEntity: VaultPasswsordEntity) {
        let viewController = VaultDetailsControllerConfigrator.createVaultDetails(vaultEntity)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func pushSearchView(_ searchText: String!) {
        let viewController = SearchViewControllerConfigrator.createSearchView(searchText)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

